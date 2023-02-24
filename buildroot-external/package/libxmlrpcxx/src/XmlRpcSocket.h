#ifndef _XMLRPCSOCKET_H_
#define _XMLRPCSOCKET_H_
//
// XmlRpc++ Copyright (c) 2002-2003 by Chris Morley
//

/* changed by eQ-3 Entwicklung GmbH 2006 */

#if defined(_MSC_VER)
# pragma warning(disable:4786)    // identifier was truncated in debug info
#endif

#ifndef MAKEDEPEND
# include <string>
#endif

#include "dllexport.h"

namespace XmlRpc {

  //! A platform-independent socket API.
  class XMLRPC_DLLEXPORT XmlRpcSocket {
  public:

    //! Creates a stream (TCP) socket. Returns -1 on failure.
    static int socket();

    //! Creates a stream unix domain socket. Returns -1 on failure.
    static int domainSocket();

    //! Closes a socket.
    static void close(int socket);


    //! Sets a stream (TCP) socket to perform non-blocking IO. Returns false on failure.
    static bool setNonBlocking(int socket);

    //! Read text from the specified socket. Returns false on error.
    static bool nbRead(int socket, std::string& s, bool *eof);

    //! Write text to the specified socket. Returns false on error.
    static bool nbWrite(int socket, std::string& s, int *bytesSoFar);


    // The next four methods are appropriate for servers.

    //! Allow the port the specified socket is bound to to be re-bound immediately so 
    //! server re-starts are not delayed. Returns false on failure.
    static bool setReuseAddr(int socket);

    //! Bind to a specified port
    static bool bind(int socket, int port);

    //! Bind to a specified port and ip
    static bool bind(int socket, const char* ip, int port);

    //! Bind unix domain socket to a specified path
    static bool bind(int socket, const char* path);

    //! Set socket in listen mode
    static bool listen(int socket, int backlog);

    //! Accept a client connection request
    static int accept(int socket);


    //! Connect a socket to a server (from a client)
    static bool connect(int socket, const std::string& host, int port);

    //! Connect a unix domain socket to a server (from a client)
    static bool connect(int socket, const std::string& path);

    //! Return the port the socket is bound to. -1 for error.
    static int getSocketPort(int fd);

    //! Returns last errno
    static int getError();

    //! Returns message corresponding to last error
    static std::string getErrorMsg();

    //! Returns message corresponding to error
    static std::string getErrorMsg(int error);
  };

} // namespace XmlRpc

#endif
