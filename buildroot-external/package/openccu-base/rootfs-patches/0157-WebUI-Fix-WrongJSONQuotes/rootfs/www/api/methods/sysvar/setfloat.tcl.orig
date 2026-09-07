 ##
 # SysVar.setFloat
 # Setzt den Wert einer Systemvariable vom Type float
 #
 # Parameter:
 #   name: [string] Name der betreffenden Systemvariablen.
 #   value:  [number] Wert
 #
 #
 # Rückgabewert: [string]
 #  Wert der Systemvariablen.
 ##

 set script {
   var sv = dom.GetObject(name);

   if (sv)
   {
     Write(sv.State(value));
   }
 }

 if {[hmscript $script args] } {
   jsonrpc_response $args(value)
 } else {
   jsonrpc_response -1
 }

