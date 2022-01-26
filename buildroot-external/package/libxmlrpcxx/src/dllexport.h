#ifndef _XMLRPC_DLLEXPORT_H_
#define _XMLRPC_DLLEXPORT_H_

#ifdef WIN32
  #ifdef XMLRPC_BUILD_DLL
    #define XMLRPC_DLLEXPORT __declspec(dllexport)
    #pragma warning( disable: 4251 )
  #else
    #ifdef BUILD_LIB
      #define XMLRPC_DLLEXPORT
    #else
      #define XMLRPC_DLLEXPORT __declspec(dllimport)
      #pragma warning( disable: 4251 )
    #endif
  #endif
#else
  #define XMLRPC_DLLEXPORT
#endif

#endif

