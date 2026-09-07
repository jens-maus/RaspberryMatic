 ##
 # SysVar.getValueByName
 # Ermittelt den Wert einer Systemvariable mit bestimmten Namen.
 #
 # Parameter:
 #   name: [string] Name der Systemvariablen
 #
 # Rückgabewert: [string]
 #   Wert der Systemvariablen.
 ##


 set script {
    var sv = dom.GetObject(name);
    if (sv)
    {
      Write(sv.Value());
    }
 }

 jsonrpc_response [json_toString [hmscript $script args]]