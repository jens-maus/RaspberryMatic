##
# Device.listStatus
# Liefert die Detaildaten aller fertig konfigurierten Geräte.
#
# Parameter:
#   id: [string] Id des GerÃ¤ts
#
# Rückgabewert: [array]
#   Jedes Element ist eine Zeichenkette, welche die Id des Geräts symbolisiert.
##

proc getIfaceURL {interface} {
  global INTERFACE_LIST
  if {[info exists INTERFACE_LIST($interface)]} {
    array set ifaceList $INTERFACE_LIST($interface)
    return $ifaceList(URL)
  } else {
    return ""
  }
}

set script {
  var device = dom.GetObject(id);
  if (device)
  {
    var interface = dom.GetObject(device.Interface());

    Write("ID {" # device.ID() # "}");
    Write(" NAME {" # device.Name() # "}");
    Write(" ADDRESS {" # device.Address() # "}");
    Write(" INTERFACE {"# interface.Name() # "}");
  }
}

array set device [hmscript $script args]                            
                                            
if { ![info exists device(NAME)] } then {   
  jsonrpc_error 501 "device not found"  
}                               

#
# get device status information
#
set url [getIfaceURL $device(INTERFACE)]
array set valueset [xmlrpc $url getParamset [list string "$device(ADDRESS):0"] [list string VALUES]]

#
# form output JSON
#

set result "\{"
append result "\"ID\":[json_toString $device(ID)]"
append result ",\"NAME\":[json_toString $device(NAME)]"
append result ",\"ADDRESS\":[json_toString $device(ADDRESS)]"
append result ",\"INTERFACE\":[json_toString $device(INTERFACE)]"
foreach key [array names valueset] {
  append result ",\"$key\":[json_toString $valueset($key)]"
}
append result "\}"

jsonrpc_response $result
