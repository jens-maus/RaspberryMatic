##
# system.describe
# Liefert eine Liste aller Methoden.
#
# Privilegstufe: NONE
#
# Parameter: <keine>
#
# Rückgabewert:
#   Liste aller Methoden als Array. Jedes Array-Element ist ein Objekt mit den folgenden Felder:
#     name : [string] Methodenname
#     level: [string] Privilegstufe (NONE, GUEST, USER, ADMIN)
#     info : [string] Kurzbeschreibung der Methode      
##

set result "\{"

append result "\"name\": \"HomeMatic JSON API\","
append result "\"id\": \"urn:www-homematic-com:homematic-jsonrpc-api\","
append result "\"summary\": \"Zugriff auf HomeMatic Zentrale\","
append result "\"help\": \"/api/homematic.cgi\","
append result "\"procs\": \["

set first 1
foreach name [lsort [array name METHOD_LIST]] {
  array set method $METHOD_LIST($name)
  
  if { 1 != $first } then { append result "," } else { set first 0 } 
  append result "\{"
  append result "\"name\": [json_toString $name]," 
  append result "\"level\": [json_toString $method(LEVEL)]," 
  append result "\"summary\": [json_toString $method(INFO)]"
  append result "\}"
}

append result "\]"

append result "\}"

jsonrpc_response $result

