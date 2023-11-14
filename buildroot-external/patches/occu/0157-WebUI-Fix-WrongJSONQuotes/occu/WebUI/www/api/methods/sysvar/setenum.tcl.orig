 ##
 # SysVar.setEnum
 # Setzt den Wert einer Systemvariable vom Typ Enum
 #
 # Parameter:
 #   name: [string] Name der betreffenden Systemvariablen.
 #   valueList:  [list] Werteliste - z. B. "Wert1;Wert2;Wert3"
 #
 #
 # Rückgabewert: [string]
 #  Wert der Systemvariablen.
 ##

 set script {
   var sv = dom.GetObject(name);

   if (sv)
   {
     Write(sv.ValueList(valueList));
   }
 }

 if {[hmscript $script args] } {
   jsonrpc_response $args(valueList)
 } else {
   jsonrpc_response -1
 }

