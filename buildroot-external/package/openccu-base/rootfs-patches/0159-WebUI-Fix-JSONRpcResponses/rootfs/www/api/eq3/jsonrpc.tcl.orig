##
# jsonrpc.tcl
# JSON-RPC Hilfsfunktionen.
#
# Autor: Falk Werner
##

##
# JSONRPC-Daten.
##
array set JSONRPC    ""
set JSONRPC(METHOD)  ""
set JSONRPC(PARAMS)  ""
set JSONRPC(ID)     "\"error\""
set JSONRPC(ID_USED) 1

##
# Parst eine JSON-RPC-Anfrage.
##
proc jsonrpc_parse {request} {
  global JSONRPC JSONRPC_ERROR
  
#  set request [string range $request 1 end]
  if { [catch { array set parsedRequest [encoding convertfrom identity [json_parse $request]]} errMsg] } then {
     jsonrpc_error 100 "invalid request ($errMsg)"
  }  
  if { [catch { set JSONRPC(ID) $parsedRequest(id)} ] } then {
    set JSONRPC(ID_USED) 0
  }
  if { [catch { set JSONRPC(METHOD) $parsedRequest(method)} ] } then {
    jsonrpc_error 102 "params not found in request"
  }
  if { [catch { set JSONRPC(PARAMS) $parsedRequest(params)} ] } then {
    jsonrpc_error 103 "method not found in request"
  }
}

##
# Sendet einen JSON-RPC-Fehlercode und beendet das Script.
##
proc jsonrpc_error {errorCode errorText} {
  global JSONRPC
  
  set errorCode [encoding convertto identity $errorCode]
  set errorText [encoding convertto identity $errorText]
  set JSONRPC(ID) [encoding convertto identity $JSONRPC(ID)]
  
  puts "CONTENT-TYPE: application/json; charset=utf-8"
  puts ""
  puts "\{"                    

  if { $JSONRPC(ID_USED) } then {
    puts "  \"id\": $JSONRPC(ID),"  
  }  
  
  puts "  \"version\": \"1.1\","
  puts "  \"result\": null," 
  puts "  \"error\": \{"
  puts "    \"name\": \"JSONRPCError\","
  puts "    \"code\": $errorCode,"
  puts "    \"message\": [json_toString $errorText]"
  puts "  \}"
  
  puts "\}"
  
  exit
}

##
# Sendet eine JSON-RPC-Antwort. Das Script wird NICHT beendet.
##
proc jsonrpc_response {result} {
  global JSONRPC
  
  set result      [encoding convertto identity $result]
  set JSONRPC(ID) [encoding convertto identity $JSONRPC(ID)]
  
  puts "CONTENT-TYPE: application/json; charset=utf-8"
  puts ""


  puts -nonewline "\{"
  if { $JSONRPC(ID_USED) } then {
    puts -nonewline "\"id\": $JSONRPC(ID),"
  }
  puts -nonewline "\"version\": \"1.1\","    
  puts -nonewline "\"result\": $result," 
  puts -nonewline "\"error\": null"   
  puts -nonewline "\}"
}
