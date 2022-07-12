 ##
 # SysVar.setBool
 # Setzt den Wert einer Systemvariable vom Type boolean
 #
 # Parameter:
 #   name: [string] Name der betreffenden Systemvariablen.
 #   value:  [boolean] Wert
 #
 #
 # Rückgabewert: [string]
 #  Wert der Systemvariablen.
 ##

 set val $args(value)

 if {($val != 0) && ($val != 1) } {

    if {$val >= 1} {
      set args(value) 1
    } else {
      set args(value) 0
    }
 }

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

