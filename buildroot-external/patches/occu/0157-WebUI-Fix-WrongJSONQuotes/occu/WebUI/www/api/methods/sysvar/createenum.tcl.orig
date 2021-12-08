##
# SysVar.createEnum
# Erzeugt eine Systemvariable vom Typ Enum.
#
# Parameter:
#   name: [string] Name der betreffenden Systemvariablen.
#   valList: Enum "Wert1;Wert2;Wert3;...."
#   internal: [integer]  Variable sichtbar / Variable intern
#   chnID: [integer] ID des Kanals, an dem die Variable gebunden werden soll. Wenn an kein Kanal gebunden werden soll, ist -1 zu übergeben
#   Rückgabewert: [string]
#   Objekt der Systemvariablen mit Name, ID, Wert.
##

set script {

  if (chnID != -1) {
   object channel = dom.GetObject(chnID);
  }

  object oSysVars = dom.GetObject( ID_SYSTEM_VARIABLES );
  object sv = dom.CreateObject(OT_VARDP);

  sv.Name(name);
  sv.ValueType( ivtInteger );
  sv.ValueSubType( istEnum );
  sv.ValueList( valList );
  sv.State(0);


  sv.Internal(internal);

  if (channel) {
    sv.Channel(chnID);
    channel.DPs().Add(sv.ID());
  }

  oSysVars.Add(sv.ID());

  Write("{'name':'"#sv.Name()#"','id':'"#sv.ID()#"','value':'"#sv.ValueList()#"' }");
}

jsonrpc_response [hmscript $script args]
