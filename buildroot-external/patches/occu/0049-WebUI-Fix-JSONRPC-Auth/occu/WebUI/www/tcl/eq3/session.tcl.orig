##
# session.tcl
# Session-Verwaltung
##

package require http

set LOGIN_URL 127.0.0.1/login.htm
set RENEW_URL 127.0.0.1/pages/index.htm

##
# session_getHttpHeader
# Liefert den Wert eines HTTP-Headers 
#
# @param  pRequest   [string] HTTP-Token
# @param  headerName [string] Name des HTTP Headers
# @return [string] Wert des HTTP-Headers oder "", falls der Header nicht
#                  gesetz ist
##
proc session_getHttpHeader { pRequest headerName } {
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
# session_login
# Erstellt eine Session und führt die Benutzeranmeldung aus
#
# @param  username [string] Benutzername
# @param  password [string] Passwort
# @return [string] Session-Id
#
# @throws "create", falls keine Session-Id erstellt werden konnte
#                   (z.B.: zu viele gleichzeitige Sitzungen)
# @throws "id", falls die erzeugte Session-Id ungültig ist
#               (das sollte eigentlich niemals geschehen)
# @throws "credentials", falls Benutzername oder Passwort falsch sind
##
proc session_login { username password } {
  global LOGIN_URL
  
  # Schritt 1: Session erstellen
  
  set request  [::http::geturl $LOGIN_URL]
  set location [session_getHttpHeader $request location]
  ::http::cleanup $request

  if { ![regexp {sid=@([^@]*)@} $location dummy sid] } then {
    error "create"
  }

  # Schritt 2: Benutzeranmeldung
  
  set url   "$LOGIN_URL?sid=@$sid@"
  set query [::http::formatQuery tbUsername $username tbPassword $password]
  
  set request  [::http::geturl $url -query $query]
  set location [session_getHttpHeader $request location]
  set code     [::http::code $request]
  ::http::cleanup $request
  
  if { -1 != [string first 500 $code] } then {
    session_logout $sid
    error "id"
  }
  
  if { -1 != [string first error $location] } then {
    session_logout $sid
    error "credentials"
  }
  
  return $sid
}

##
# session_isValid
# Prüft, ob eine Sitzung gültig ist
#
# @param  sid [string] Session-Id
# @return [bool] true, falls die Session-Id gültig ist
##
proc session_isValid { sid } {

  if {
    ([string index $sid 0] != "@")
    || ([string index $sid [expr [string length $sid] -1]]  != "@")
    || ([string length $sid] != 12)} {

   return false
  }

  set    script "var _session_id_ = \"$sid\";"
  append script {
    var result = false;
    var s  = system.GetSessionVarStr(_session_id_);
    if (s) { result = true; }
    Write(result);
  }
  return [rega_exec $script]
}

##
# session_getUserId
# Liefert die Id des angemeldeten Benutzers
#
# @param sid [string] Session-Id
# @return [string] User-Id oder ""
##
proc session_getUserId { sid } {
	set script "var id = \"$sid\";"
	append script {
		var s = system.GetSessionVarStr(id);
		Write(s.StrValueByIndex(";",0));
	}
	
	return [rega_exec $script]
}

##
# session_renew
# Erneuert eine Sitzung
#
# @param sid [string] Session-Id
##
proc session_renew { sid } {
  global RENEW_URL
  
  ::http::cleanup [::http::geturl "$RENEW_URL?sid=@$sid@"]
}


##
# session_logout
# Schließt eine laufende Sitzung.
#
# @param sid [string] Session-Id
##
proc session_logout { sid } {
  if {[session_isValid $sid] == true} {
    rega_exec "system.ClearSessionID(\"$sid\");"
  }
}
