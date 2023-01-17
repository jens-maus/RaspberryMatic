
#ifndef _XMLRPCSERVERPROXY_H_
#define _XMLRPCSERVERPROXY_H_

/* Copyright (c) 2006 by eQ-3 Entwicklung GmbH
 * based on work Copyright (c) 2002-2003 by Chris Morley
 */

#if defined(_MSC_VER)
# pragma warning(disable:4786)    // identifier was truncated in debug info
#endif

#ifndef MAKEDEPEND
# include <map>
# include <string>
#endif

#include "XmlRpcDispatch.h"
#include "XmlRpcSource.h"
#include "dllexport.h"

namespace XmlRpc {


  // An abstract class supporting XML RPC methods
  class XmlRpcServerMethod;

  // Class representing connections to specific clients
  class XmlRpcServerConnection;

  // Class representing argument and result values
  class XmlRpcValue;

  // The real server class
  class XmlRpcServer;

  //! A class to handle XML RPC requests on behalf of the real server
  class XMLRPC_DLLEXPORT XmlRpcServerProxy : public XmlRpcSource {
  public:
    //! Create a server proxy object.
    XmlRpcServerProxy(XmlRpcServer* s);
    //! Destructor.
    virtual ~XmlRpcServerProxy();

    //! Create a socket, bind to the specified port, and
    //! set it in listen mode to make it available for clients.
    bool bindAndListen(int port, int backlog = 5);

    //! Create a unix domain socket, bind to the specified file path, and
    //! set it in listen mode to make it available for clients.
    bool bindAndListen(const char* path, int backlog = 5);

    //! Close all connections with clients and the socket file descriptor
    void shutdown();

    // XmlRpcSource interface implementation

    //! Handle client connection requests
    virtual unsigned handleEvent(unsigned eventType);

    //! Remove a connection from the dispatcher
    virtual void removeConnection(XmlRpcServerConnection*);

  protected:

    //! Accept a client connection request
    virtual void acceptConnection();

    //! Create a new connection object for processing requests from a specific client.
    virtual XmlRpcServerConnection* createConnection(int socket);

	//! The server object we receive proxy requests for
	XmlRpcServer* _server;

  };
} // namespace XmlRpc

#endif //_XMLRPCSERVERPROXY_H_
