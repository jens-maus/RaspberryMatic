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

# Schritt 1: Session erstellen

set request  [::http::geturl $LOGIN_URL]
set location [getHttpHeader $request location]
::http::cleanup $request

if { ![regexp {sid=@([^@]*)@} $location dummy sid] } then {
  jsonrpc_error 501 "too many sessions"
}

# Schritt 2: Benutzeranmeldung

set url   "$LOGIN_URL?sid=@$sid@"
set query [::http::formatQuery tbUsername $username tbPassword $password]
  
set request  [::http::geturl $url -query $query]
set location [getHttpHeader $request location]
set code     [::http::code $request]
::http::cleanup $request
  
if { -1 != [string first 500 $code] } then {
  hmscript "system.ClearSessionID(\"$sid\");"
  jsonrpc_error 501 "invalid session id"
}
  
if { -1 != [string first error $location] } then {
  hmscript "system.ClearSessionID(\"$sid\");"
  jsonrpc_error 502 "invalid username oder password"
}
  
jsonrpc_response [json_toString $sid]



