
/* Copyright (c) 2006 by eQ-3 Entwicklung GmbH
 * based on work Copyright (c) 2002-2003 by Chris Morley
 */

#include "XmlRpcServerProxy.h"
#include "XmlRpcServer.h"
#include "XmlRpcServerConnection.h"
#include "XmlRpcSocket.h"
#include "XmlRpcUtil.h"
#include "XmlRpcException.h"


using namespace XmlRpc;


XmlRpcServerProxy::XmlRpcServerProxy(XmlRpcServer* s)
{
	_server=s;
}


XmlRpcServerProxy::~XmlRpcServerProxy()
{
  this->shutdown();
}


// Create a socket, bind to the specified port, and
// set it in listen mode to make it available for clients.
bool 
XmlRpcServerProxy::bindAndListen(int port, int backlog /*= 5*/)
{
  int fd = XmlRpcSocket::socket();
  if (fd < 0)
  {
    XmlRpcUtil::error("XmlRpcServerProxy::bindAndListen: Could not create socket (%s).", XmlRpcSocket::getErrorMsg().c_str());
    return false;
  }

  this->setfd(fd);

  // Don't block on reads/writes
  if ( ! XmlRpcSocket::setNonBlocking(fd))
  {
    this->close();
    XmlRpcUtil::error("XmlRpcServerProxy::bindAndListen: Could not set socket to non-blocking input mode (%s).", XmlRpcSocket::getErrorMsg().c_str());
    return false;
  }

  // Allow this port to be re-bound immediately so server re-starts are not delayed
  if ( ! XmlRpcSocket::setReuseAddr(fd))
  {
    this->close();
    XmlRpcUtil::error("XmlRpcServerProxy::bindAndListen: Could not set SO_REUSEADDR socket option (%s).", XmlRpcSocket::getErrorMsg().c_str());
    return false;
  }

  // Bind to the specified port on the default interface
  if ( ! XmlRpcSocket::bind(fd, port))
  {
    this->close();
    XmlRpcUtil::error("XmlRpcServerProxy::bindAndListen: Could not bind to specified port (%s).", XmlRpcSocket::getErrorMsg().c_str());
    return false;
  }

  // Set in listening mode
  if ( ! XmlRpcSocket::listen(fd, backlog))
  {
    this->close();
    XmlRpcUtil::error("XmlRpcServerProxy::bindAndListen: Could not set socket in listening mode (%s).", XmlRpcSocket::getErrorMsg().c_str());
    return false;
  }

  XmlRpcUtil::log(2, "XmlRpcServerProxy::bindAndListen: server listening on port %d", port);

  // Notify the dispatcher to listen on this source when we are in work()
  _server->getDispatcher()->addSource(this, XmlRpcDispatch::ReadableEvent);

  return true;
}


// Create a unix domain socket, bind to the specified file, and
// set it in listen mode to make it available for clients.
bool 
XmlRpcServerProxy::bindAndListen(const char* path, int backlog /*= 5*/)
{
  int fd = XmlRpcSocket::domainSocket();
  if (fd < 0)
  {
    XmlRpcUtil::error("XmlRpcServerProxy::bindAndListen: Could not create socket (%s).", XmlRpcSocket::getErrorMsg().c_str());
    return false;
  }


  this->setfd(fd);

  // Don't block on reads/writes
  if ( ! XmlRpcSocket::setNonBlocking(fd))
  {
    this->close();
    XmlRpcUtil::error("XmlRpcServerProxy::bindAndListen: Could not set socket to non-blocking input mode (%s).", XmlRpcSocket::getErrorMsg().c_str());
    return false;
  }

  // Bind to the specified file
  if ( ! XmlRpcSocket::bind(fd, path))
  {
    this->close();
    XmlRpcUtil::error("XmlRpcServerProxy::bindAndListen: Could not bind to specified port (%s).", XmlRpcSocket::getErrorMsg().c_str());
    return false;
  }

  // Set in listening mode
  if ( ! XmlRpcSocket::listen(fd, backlog))
  {
    this->close();
    XmlRpcUtil::error("XmlRpcServerProxy::bindAndListen: Could not set socket in listening mode (%s).", XmlRpcSocket::getErrorMsg().c_str());
    return false;
  }

  XmlRpcUtil::log(2, "XmlRpcServerProxy::bindAndListen: server listening on unix domain socket path %s", path);

  // Notify the dispatcher to listen on this source when we are in work()
  _server->getDispatcher()->addSource(this, XmlRpcDispatch::ReadableEvent);

  return true;
}


// Handle input on the server socket by accepting the connection
// and reading the rpc request.
unsigned
XmlRpcServerProxy::handleEvent(unsigned mask)
{
  XmlRpcUtil::log(5,"XmlRpcServerProxy: handleEvent.");
  acceptConnection();
  return XmlRpcDispatch::ReadableEvent;		// Continue to monitor this fd
}


// Accept a client connection request and create a connection to
// handle method calls from the client.
void
XmlRpcServerProxy::acceptConnection()
{
  int s = XmlRpcSocket::accept(this->getfd());
  XmlRpcUtil::log(2, "XmlRpcServerProxy::acceptConnection: socket %d", s);
  if (s < 0)
  {
    //this->close();
    XmlRpcUtil::error("XmlRpcServerProxy::acceptConnection: Could not accept connection (%s).", XmlRpcSocket::getErrorMsg().c_str());
  }
  else if ( ! XmlRpcSocket::setNonBlocking(s))
  {
    XmlRpcSocket::close(s);
    XmlRpcUtil::error("XmlRpcServerProxy::acceptConnection: Could not set socket to non-blocking input mode (%s).", XmlRpcSocket::getErrorMsg().c_str());
  }
  else  // Notify the dispatcher to listen for input on this source when we are in work()
  {
    XmlRpcUtil::log(2, "XmlRpcServerProxy::acceptConnection: creating a connection");
    _server->getDispatcher()->addSource(this->createConnection(s), XmlRpcDispatch::ReadableEvent);
  }
}


// Create a new connection object for processing requests from a specific client.
XmlRpcServerConnection*
XmlRpcServerProxy::createConnection(int s)
{
  // Specify that the connection object be deleted when it is closed
  return new XmlRpcServerConnection(s, _server, true);
}


void 
XmlRpcServerProxy::removeConnection(XmlRpcServerConnection* sc)
{
  _server->getDispatcher()->removeSource(sc);
}


// Close the server socket file descriptor and stop monitoring connections
void 
XmlRpcServerProxy::shutdown()
{
  // This closes and destroys all connections as well as closing this socket
//  _disp.clear();
}

