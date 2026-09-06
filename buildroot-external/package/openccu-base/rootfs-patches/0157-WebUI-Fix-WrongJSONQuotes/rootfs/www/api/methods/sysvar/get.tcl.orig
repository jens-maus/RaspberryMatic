##
# SysVar.get
# Liefert Detailinformationen zu einer Systemvariablen.
#
# Parameter:
#   id: [string] Id der betreffenden Systemvariablen
#
# Rückgabewert: [object]
#   Jedes Element ist ein Objekt mit den folgenden allgemeinen Feldern:
#     id        : [string] Id der Systemvariable
#     name      : [string] Bezeichnung der Systemvariable
#     type      : [string] Datentyp 
#                          [LOGIC, LIST, NUMBER, ALARM, STRING]
#     value     : [string] aktueller Wert
#     unit      : [string] Maßeinheit
#     channelId : [string] Id des zugeordneten Kanals 
#                          (ungültig bei "0" und "65535")
#     isVisible : [bool]   Gibt an, ob die Systemvariablen sichtbar ist
#     isLogged  : [bool]   Gibt an, ob Wertänderungen protokolliert werden
#     isInternal: [bool]   Gibt an, ob die Systemvariable intern verwendet wird
#
#  Zusätzliche Felder für type == LOGIC und type == ALARM:
#     valueName0: [string] Bezeichnung des Wertes 0 
#     valueName1: [string] Bezeichnung des Wertes 1 
#
#  Zusätzliche Felder für type == LIST:
#     valueList: [string] Werteliste (Separator: ";")
#
#  Zusätzliche Felder für type == NUMBER:
#     minValue : [number] minimaler Wert
#     maxValue : [number] maximaler Wert
##

set script {
  var sv = dom.GetObject(id);
  if (sv)
  {
    var sv_type = "UNKNOWN";
    if (sv.ValueSubType() == istAlarm   ) { sv_type = "ALARM";  }
    if (sv.ValueSubType() == istBool    ) { sv_type = "LOGIC";  }
    if (sv.ValueSubType() == istEnum    ) { sv_type = "LIST";   }
    if (sv.ValueSubType() == istGeneric ) { sv_type = "NUMBER"; }
    if (sv.ValueSubType() == istChar8859) { sv_type = "STRING"; }
      
    WriteLine("ID {" # sv.ID() # "}");
    WriteLine("NAME {" # sv.Name() # "}");
    WriteLine("TYPE {" # sv_type # "}");
    WriteLine("UNIT {" # sv.ValueUnit() # "}");
    WriteLine("VALUE {" # sv.Value() # "}");
    WriteLine("LOGGED {" # sv.DPArchive() # "}");
    WriteLine("VISIBLE {" # sv.Visible() # "}");
    WriteLine("INTERNAL {" # sv.Internal() # "}");
    WriteLine("CHANNEL_ID {" # sv.Channel() # "}");
    WriteLine("VALUE_MIN {" # sv.ValueMin() # "}");
    WriteLine("VALUE_MAX {" # sv.ValueMax() # "}");
    WriteLine("VALUE_LIST {" # sv.ValueList() # "}");
    WriteLine("VALUE_NAME_0 {" # sv.ValueName0() # "}");
    WriteLine("VALUE_NAME_1 {" # sv.ValueName1() # "}");
  }
}

array set _sv_ [hmscript $script args]

set type $_sv_(TYPE)
  
set    result "\{"
append result "\"id\":[json_toString $_sv_(ID)],"
append result "\"name\":[json_toString $_sv_(NAME)],"
append result "\"type\":[json_toString $_sv_(TYPE)],"
append result "\"unit\":[json_toString $_sv_(UNIT)],"
append result "\"value\":[json_toString $_sv_(VALUE)],"
append result "\"channelId\":[json_toString $_sv_(CHANNEL_ID)],"

if { ("ALARM" == $type) || ("LOGIC" == $type) } then {
  append result "\"valueName0\":[json_toString $_sv_(VALUE_NAME_0)],"
  append result "\"valueName1\":[json_toString $_sv_(VALUE_NAME_1)],"
}
  
if { "LIST" == $type } then {
  append result "\"valueList\":[json_toString $_sv_(VALUE_LIST)],"
}
  
if { "NUMBER" == $type } then {
  append result "\"minValue\":[json_toString $_sv_(VALUE_MIN)],"
  append result "\"maxValue\":[json_toString $_sv_(VALUE_MAX)],"
}

append result "\"isLogged\":$_sv_(LOGGED),"
append result "\"isVisible\":$_sv_(VISIBLE),"
append result "\"isInternal\":$_sv_(INTERNAL)"
append result "\}"

jsonrpc_response $result
