##
# Subsection.getAll
# Liefert Detailinformationen zu allen Gewerken.
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
  foreach(id, dom.GetObject(ID_FUNCTIONS).EnumUsedIDs())
  {
    var subsection = dom.GetObject(id);
    
    if (subsection)
    {
      WriteLine("{");
      WriteLine("ID {" # subsection.ID() # "}");
      WriteLine("NAME {" # subsection.Name() # "}");
      WriteLine("DESCRIPTION {" # subsection.EnumInfo() # "}");
    
      Write("CHANNELS {");
      string channelId;
      foreach(channelId, subsection.EnumUsedIDs())
      {
        Write("{" # channelId # "} ");
      }
      WriteLine("}");
    
      WriteLine("}");
    }
  }
}

set subsections [hmscript_run script]

set result "\["
set first 1

foreach subsection $subsections {
  if { 1 != $first } then { append result "," } else { set first 0 }
  array set _subsection_ $subsection
  
  append result "\{"
  append result "\"id\":[json_toString $_subsection_(ID)],"
  append result "\"name\":[json_toString $_subsection_(NAME)],"
  append result "\"description\":[json_toString $_subsection_(DESCRIPTION)],"
  
  set _first_ 1
  append result "\"channelIds\":\["
  foreach channelId $_subsection_(CHANNELS) {
    if { 1 != $_first_ } then {append result "," } else { set _first_ 0 }
    append result [json_toString $channelId]
  }
  append result "\]"
  
  append result "\}"
}

append result "\]"

jsonrpc_response $result
