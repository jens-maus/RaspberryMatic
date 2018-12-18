##
# Session.Login
# Erstellt eine Session und führt die Benutzeranmeldung durch.
#
# Parameter:
#   username    : [string] Benutzername
#   password    : [string] Passwort
#
# Rückgabewert: [bool]
#   _session_id_
##

package require http

set LOGIN_URL 127.0.0.1/login.htm

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

set username $args(username)
set password $args(password)

# Schritt 1: Benutzeranmeldung und Session erstellen

set request  [::http::geturl $LOGIN_URL -query [::http::formatQuery tbUsername $username tbPassword $password]]
set location [getHttpHeader $request location]
set code     [::http::code $request]
::http::cleanup $request

if { -1 != [string first 503 $code] } then {
  jsonrpc_error 503 "service not available"
}

if { ![regexp {sid=@([^@]*)@} $location dummy sid] } then {
  jsonrpc_error 501 "invalid credentials or too many sessions"
}

jsonrpc_response [json_toString $sid]
