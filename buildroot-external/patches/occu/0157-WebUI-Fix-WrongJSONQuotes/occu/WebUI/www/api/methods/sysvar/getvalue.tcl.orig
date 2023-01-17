##
# SysVar.getValue
# Liefert den aktuellen Wert einer Systemvariablen.
#
# Parameter:
#   id: [string] Id der betreffenden Systemvariablen.
#
# Rückgabewert: [string]
#   Aktueller Wert der Systemvariablen.
##

set script {
  var sv = dom.GetObject(id);
  
  if (sv)
  {
    Write(sv.Value());
  }
}

jsonrpc_response [json_toString [hmscript $script args]]
