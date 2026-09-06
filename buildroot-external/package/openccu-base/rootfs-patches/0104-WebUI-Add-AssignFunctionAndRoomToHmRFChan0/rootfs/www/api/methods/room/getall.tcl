##
# Room.getAll
# Liefert Detailinformationen zu allen Räumen.
#
# Parameter:
#   <keine>
#
# Rückgabewert: [array]
#   Jedes Element ist ein Objekt mit den folgenden Feldern:
#    id:          [string] Id des Raumes
#    name:        [string] Bezeichnung des Raumes
#    description: [string] Beschreibung des Raumes
#    channelIds:  [array]  Jedes Element ist eine Zeichnenkette, welche die Id des Kanals repräsentiert
##

set script {
  string id;
  foreach(id, dom.GetObject(ID_ROOMS).EnumUsedIDs())
  {
    var room = dom.GetObject(id);
    
    if (room)
    {
      WriteLine("{");
      WriteLine("ID {" # room.ID() # "}");
      WriteLine("NAME {" # room.Name() # "}");
      WriteLine("DESCRIPTION {" # room.EnumInfo() # "}");
    
      Write("CHANNELS {");
      string channelId;
      foreach(channelId, room.EnumIDs())
      {
        Write("{" # channelId # "} ");
      }
      WriteLine("}");
    
      WriteLine("}");
    }
  }
}

set rooms [hmscript_run script]

set result "\["
set first 1

foreach room $rooms {
  if { 1 != $first } then { append result "," } else { set first 0 }
  array set _room_  $room
  
  append result "\{"
  append result "\"id\":[json_toString $_room_(ID)],"
  append result "\"name\":[json_toString $_room_(NAME)],"
  append result "\"description\":[json_toString $_room_(DESCRIPTION)],"
  
  set _first_ 1
  append result "\"channelIds\":\["
  foreach channelId $_room_(CHANNELS) {
    if { 1 != $_first_ } then {append result "," } else { set _first_ 0 }
    append result [json_toString $channelId]
  }
  append result "\]"
  
  append result "\}"
}

append result "\]"

jsonrpc_response $result
