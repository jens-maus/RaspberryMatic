#!/bin/tclsh

##
# homematic.cgi
# HomeMatic JSON API
#
# Autor: Falk Werner
##

##
#  A. Grobelnik, 160210
#
# Prüfen, ob es sich um die Zentrale handelt.
# Wenn es sich um das Konfigtool handelt, dürfen
# einige Funktionen nicht aufgerufen werden.
#
# Die Variable 'central' steht global zu Verfügung
# und wird zur Zeit außer in dieser Datei noch 
# in api/methods/webui/getcolors.tcl verwendet.
#
# Bei der Art der Prüfung handelt es sich zur Zeit
# um eine Notlösung. 
##

set central true 

# Zentrale oder Konfigtool (/www/ = Zentrale)
if {$env(DOCUMENT_ROOT) != "\/www\/"} then {
  set central false
}

#####################
# Verwendete Module #
#####################
load tclrpc.so

if {$central} then { 
  load tclrega.so
}

source [file join $env(DOCUMENT_ROOT) api/eq3/common.tcl]
source [file join $env(DOCUMENT_ROOT) api/eq3/ipc.tcl]
source [file join $env(DOCUMENT_ROOT) api/eq3/json.tcl]
source [file join $env(DOCUMENT_ROOT) api/eq3/jsonrpc.tcl]
source [file join $env(DOCUMENT_ROOT) api/eq3/hmscript.tcl]
source [file join $env(DOCUMENT_ROOT) api/eq3/event.tcl]


##############
# Konstanten #
##############

array set INTERFACE_LIST [ipc_getInterfaces]

set       METHODS_FILE "methods.conf"
array set METHOD_LIST  [file_load $METHODS_FILE]

array set USER_LEVEL ""
set       USER_LEVEL(NONE)  0
set       USER_LEVEL(GUEST) 1
set       USER_LEVEL(USER)  2
set       USER_LEVEL(ADMIN) 8
set       USER_LEVEL(0)     NONE
set       USER_LEVEL(1)     GUEST
set       USER_LEVEL(2)     USER
set       USER_LEVEL(8)     ADMIN

array set USER_LEVEL_NAME ""
set       USER_LEVEL_NAME(NONE)  "&lt;keine&gt;"
set       USER_LEVEL_NAME(GUEST) "Gast"
set       USER_LEVEL_NAME(USER)  "Benutzer"
set       USER_LEVEL_NAME(ADMIN) "Administrator"
set       USER_LEVEL_NAME(0)     $USER_LEVEL_NAME(NONE)  
set       USER_LEVEL_NAME(1)     $USER_LEVEL_NAME(GUEST) 
set       USER_LEVEL_NAME(2)     $USER_LEVEL_NAME(USER)  
set       USER_LEVEL_NAME(8)     $USER_LEVEL_NAME(ADMIN) 


##############
# Prozeduren #
##############

##
# Liefert eine Methode anhand ihres Namens.
# Falls die Methode nicht gefunden werden kann, wird die Methode METHOD_NOT_FOUND zurückgegeben.
##
proc getMethod { methodName } {
  global METHOD_LIST
  
  foreach name [array names METHOD_LIST] {
    if { $name == $methodName } then { return $METHOD_LIST($name) }
  }
  
  jsonrpc_error 401 "method not found ($methodName)"
}

##
# Prüft, ob die aktuelle Privilegstufe ausreicht, um die methode auszuführen.
#
# Falls die Privilegstufe nicht ausreicht, wird das Script mit einer
# entsprechenden Fehlermeldung beendet.
##
proc checkPrivilegeLevel { p_method p_args } {
  global USER_LEVEL
  upvar $p_method method
  upvar $p_args   args
  
  if { "NONE" != $method(LEVEL) } then {
    array set _args_ ""
    set _args_(_session_id_) $args(_session_id_)
    
    set level $USER_LEVEL($method(LEVEL))
    set upl   [hmscript_runFromFile "eq3/getupl.hms" _args_]
    if { $level > $upl } then {
      jsonrpc_error 400 "access denied (\"$method(LEVEL)\" needed $upl)"
    }
  }
}

##
# Prüft, ob die notwendigen Argumente einer Methode angegeben sind
##
proc checkArguments { p_method p_args } {
  upvar $p_method method
  upvar $p_args   args
  
  foreach argName $method(ARGUMENTS) {
    if { ![info exists args($argName)] } then {
      jsonrpc_error 402 "missing argument ($argName)"
    }
  }
}

##################
# Einsprungpunkt #
##################

# HTTP-POST: Methode ausführen
if {$env(REQUEST_METHOD) == "POST"} then {
  if { [catch {   
    jsonrpc_parse [read stdin $env(CONTENT_LENGTH)]
    
    array set method [getMethod $JSONRPC(METHOD)]
    array set args   $JSONRPC(PARAMS)
  
    # wenn Zentrale  
    if {$central} then {
       checkPrivilegeLevel method args
    }
    
    checkArguments      method args

    source [file join $env(DOCUMENT_ROOT) "api/methods/$method(SCRIPT_FILE)"]
  }] } then {  
    jsonrpc_error 200 "internal error:\n$errorInfo"
  }
}

# HTTP-GET: Schnittstellenbeschreibung ausgeben
if {$env(REQUEST_METHOD) == "GET"} then {
  puts "CONTENT-TYPE: text/html; charset=iso-8859-1"
  puts {}
  puts {
<html>
<head>
  <title>HomeMatic JSON API</title>
  <style type='text/css'>
    .odd {
      background-color: #cccccc;
    }
  </style>
</head>
<body>
  <h1>HomeMatic JSON API</h1>
  <p>
    Die HomeMatic JSON API vereinheitlicht Zugriff auf die verschiedenen 
    Teile der HomeMatic Zentrale unter einer einheitlichen Schnittstelle.
    Diese Schnittstelle basiert auf 
    <a href='http://json-rpc.org/wiki/specification'>JSON-RPC</a>, 
    einer Form des entfernen Prozeduraufrufs, der auf 
    <a href='http://json.org/'>JSON</a> aufsetzt.
  </p>
  <h2>Methoden&uuml;bersicht</h2>
  <table border='1' cellspacing='0' cellpadding='5px'>
    <tr><th>Methodenname</th><th>Privilegstufe</th><th>Kurzbeschreibung</th><th>Parameter</th></tr>
  }
  set className odd
  foreach name [lsort [array name METHOD_LIST]] {
    array set method $METHOD_LIST($name)
    puts "<tr class='$className'><td>$name</td><td>$USER_LEVEL_NAME($method(LEVEL))</td><td>$method(INFO)</td><td>$method(ARGUMENTS)&nbsp;</td></tr>"
    if { "odd" == $className } then { set className even } else { set className odd }
  }
  puts {
  </table>
  <h2>Fehlercodes</h2>
  <table border='1' cellspacing='0' cellpadding='5px'>
    <tr><th>Fehlercode</th><th>Kurzbeschreibung</th></tr>
    <tr><td>100</td><td>Ung&uuml;ltige Anfrage</td></tr>
    <tr><td>101</td><td>Das Element <i>id</i> fehlt in der Anfrage</td></tr>
    <tr><td>102</td><td>Das Element <i>method</i> fehlt in der Anfrage</td></tr>
    <tr><td>103</td><td>Das Element <i>params</i> fehlt in der Anfrage</td></tr>
    <tr><td>200</td><td>Ung&uuml;ltige Antwort</td></tr>
    <tr><td>201</td><td>Das Element <i>id</i> fehlt in der Antwort</td></tr>
    <tr><td>202</td><td>Das Element <i>result</i> fehlt in der Antwort</td></tr>
    <tr><td>203</td><td>Das Element <i>error</i> fehlt in der Antwort</td></tr>
    <tr><td>300</td><td>Interner Fehler</td></tr>
    <tr><td>400</td><td>Privilegstufe reicht nicht</td></tr>
    <tr><td>401</td><td>Methode nicht gefunden</td></tr>  
    <tr><td>402</td><td>Argument nicht gefunden</td></tr>
    <tr><td>5xx</td><td>Anwendungsspezifische Fehler</td></tr>
  </table>
</body>
</html>
  }
}
