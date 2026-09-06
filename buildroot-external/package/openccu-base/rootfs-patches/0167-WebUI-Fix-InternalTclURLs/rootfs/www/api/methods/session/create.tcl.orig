##
# Session.create
# Erstellt eine neue Sitzung und liefert die Session-Id zurück.
#
# Parameter:
#   <keine>
#
# Rückgabewert: [string]
#   Session-Id
##

package require http

set LOGIN_URL {127.0.0.1/login.htm}

##
# getHttpHeader
# Liefert den Wert eines HTTP-Headers oder "", falls
# der Header nicht gesetzt ist
##
proc getHttpHeader { pRequest headerName } {
  upvar $pRequest request

  set headerName [string toupper $headerName]
  array set meta $request(meta)
  foreach header [array names meta] {
    if {$headerName == [string toupper $header] } then {
      return $meta($header)
    }
  }
  
  return ""
}

##
# Einsprungpunkt
##

set request [::http::geturl $LOGIN_URL]
set location [getHttpHeader $request location]
::http::cleanup $request

if { [regexp {sid=@([^@]*)@} $location dummy _session_id_] } then {
  ::http::cleanup [::http::geturl "127.0.0.1$location"]
  jsonrpc_response [json_toString $_session_id_]
} else {
  jsonrpc_error 501 "could not create session $location [array get $request]"
}
