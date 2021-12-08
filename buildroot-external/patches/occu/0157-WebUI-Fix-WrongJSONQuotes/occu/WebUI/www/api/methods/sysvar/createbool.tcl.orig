##
# SysVar.createBool
# Erzeugt eine Systemvariable vom Typ Boolean.
#
# Parameter:
#   name: [string] Name der betreffenden Systemvariablen.
#   init_val: [bool] Initialer Status
#   internal: [integer]  Variable sichtbar / Variable intern
#   chnID: [integer] ID des Kanals, an dem die Variable gebunden werden soll. Wenn an kein Kanal gebunden werden soll, ist -1 zu übergeben
# Rückgabewert: [string]
#   Objekt der Systemvariablen mit Name, ID, Wert.
##

set script {
  if (chnID != -1) {
   object channel = dom.GetObject(chnID);
  }

  object oSysVars = dom.GetObject( ID_SYSTEM_VARIABLES );
  object sv = dom.CreateObject(OT_VARDP);

  sv.ValueType( ivtBinary );
  sv.ValueSubType( istBool );
  sv.Name(name);
  sv.ValueName0("false");
  sv.ValueName1("true");
  sv.State(init_val);

  sv.Internal(internal);

  if (channel) {
    sv.Channel(chnID);
    channel.DPs().Add(sv.ID());
  }

  oSysVars.Add(sv.ID());

  Write("{'name':'"#sv.Name()#"','id':'"#sv.ID()#"','value':'"#sv.Value()#"' }");
  }

jsonrpc_response [hmscript $script args]

