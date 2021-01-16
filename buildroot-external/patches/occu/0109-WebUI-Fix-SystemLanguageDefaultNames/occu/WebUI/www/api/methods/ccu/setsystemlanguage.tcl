##
# CCU.setSystemLanguage
# Setzt die Systemsprache der CCU in /etc/config/systemLanguage
# und benennt die Namen aller Gewerke, Raeume und Standard-Systemvariablen
# in die jeweilige Sprache um.
#
# Parameter:
#  lang         : [string] Die gewaehlte Systemsprache (de, en)
#
# Rückgabewert: immer true
##

proc resetSystemLanguage {a} {

  array set args $a

  # define rega script
  set script {

    string oID;
    string metaDataFactoryName = "FACTORY_NAME";
  
    object funcs = dom.GetObject(ID_FUNCTIONS);
    object rooms = dom.GetObject(ID_ROOMS);
    object sv    = dom.GetObject(ID_SYSTEM_VARIABLES);
  
    foreach(oID, funcs.EnumIDs()) {
      object oObj = dom.GetObject(oID);
      var meta = oObj.MetaData(metaDataFactoryName);
      if (meta) {
        string newName = meta;
        oObj.Name(newName);
        oObj.RemoveMetaData(metaDataFactoryName);
      }
    }

    foreach(oID, rooms.EnumIDs()) {
      object oObj = dom.GetObject(oID);
      var meta = oObj.MetaData(metaDataFactoryName);
      if (meta) {
        string newName = meta;
        oObj.Name(newName);
        oObj.RemoveMetaData(metaDataFactoryName);
      }
    }

    foreach(oID, sv.EnumIDs()) {
      object oObj = dom.GetObject(oID);
      var meta = oObj.MetaData(metaDataFactoryName);
      if (meta) {
        string newName = meta;
        oObj.Name(newName);
        oObj.RemoveMetaData(metaDataFactoryName);
      }
  
      var metaValueName0 = oObj.MetaData(metaDataFactoryName#"_VALUE_NAME_0");
      if (metaValueName0) {
        string newName = metaValueName0;
        oObj.ValueName0(newName);
        oObj.RemoveMetaData(metaDataFactoryName#"_VALUE_NAME_0");
      }
  
      var metaValueName1 = oObj.MetaData(metaDataFactoryName#"_VALUE_NAME_1");
      if (metaValueName1) {
        string newName = metaValueName1;
        oObj.ValueName1(newName);
        oObj.RemoveMetaData(metaDataFactoryName#"_VALUE_NAME_1");
      }
    }
    
    Write("true");
  }

  set result [hmscript $script args]
  return $result
}

proc setSystemLanguage {a} {

  array set args $a

  # define rega script
  set script {
    string funcDefault    = "funcLight;funcHeating;funcClimateControl;funcWeather;funcEnvironment;funcSecurity;funcLock;funcButton;funcCentral;funcEnergy";
    string funcTranslated = "Licht;Heizung;Klima;Wetter;Umwelt;Sicherheit;Verschluss;Taster;Zentrale;Energiemanagement";

    string roomDefault = "roomLivingRoom;roomKitchen;roomBedroom;roomChildrensRoom1;roomChildrensRoom2;roomOffice;roomBathroom;roomGarage;roomHWR;roomGarden;roomTerrace";
    string roomTranslated = "Wohnzimmer;Küche;Schlafzimmer;Kinderzimmer 1;Kinderzimmer 2;Büro;Badezimmer;Garage;Hauswirtschaftsraum;Garten;Terrasse";
	
    string svDefault   = "sysVarAlarmZone1;sysVarAlarmZone1Msg;sysVarAlarmZone1Triggered;sysVarAlarmZone1NotTriggered;sysVarPresence;sysVarPresenceMsg;sysVarPresencePresent;sysVarPresenceNotPresent;sysVarAlarmMessages;sysVarAlarmMessagesCount;sysVarServiceMessages;sysVarServiceMessagesCount;sysVarRainToday;sysVarRainTodayDescr;sysVarRainYesterday;sysVarRainYesterdayDescr";
    string svTranslated   = "Alarmzone 1;Alarmmeldung Alarmzone 1;ausgelöst;nicht ausgelöst;Anwesenheit;Anwesenheit;anwesend;nicht anwesend;Alarmmeldungen;Anzahl Alarmmeldungen;Servicemeldungen;Anzahl Servicemeldungen;Regen heute;Regenmenge aktueller Tag;Regen gestern;Regenmenge vorheriger Tag";

    if (lang == "en") {
      funcTranslated = "Light;Heating;Climatic conditions;Weather;Environment;Security;Lock;Button;Central;Energy management";
      roomTranslated = "Living room;Kitchen;Bed room;Childrens room 1;Childrens room 2;Home office;Bathroom;Garage;Utility room;Garden;Terrace";
      svTranslated   = "Alarm zone 1;Alarm message alarm zone 1;triggered;not triggered;Presence;Presence;present;absent;Alarm messages;Number alarm messages;Service messages;Number service messages;Rain today;Rainfall current day;Rainfall yesterday;Rainfall previous day";
    }

    string oID;
    string metaDataFactoryName = "FACTORY_NAME";
  
    object funcs = dom.GetObject(ID_FUNCTIONS);
    object rooms = dom.GetObject(ID_ROOMS);
    object sv    = dom.GetObject(ID_SYSTEM_VARIABLES);
  
    ! Functions
    foreach(oID, funcs.EnumIDs()) {
      object oObj = dom.GetObject(oID);
      string listEntry;
      integer idx = 0;
      foreach(listEntry, funcDefault.Split(";")) {
        if ((oObj.Name() == listEntry) || (oObj.Name() == "${"#listEntry#"}")) {
          var meta = oObj.MetaData(metaDataFactoryName);
          if (!meta) {
            string newName = funcTranslated.StrValueByIndex(";", idx);
            oObj.RemoveMetaData(metaDataFactoryName);
            oObj.AddMetaData(metaDataFactoryName, oObj.Name());
            oObj.Name(newName);
          }
        }
        idx = idx + 1;
      }
    }
  
    ! Rooms
    foreach(oID, rooms.EnumIDs()) {
      object oObj = dom.GetObject(oID);
      string listEntry;
      integer idx = 0;
      foreach(listEntry, roomDefault.Split(";")) {
        if ((oObj.Name() == listEntry) || (oObj.Name() == "${"#listEntry#"}")) {
          var meta = oObj.MetaData(metaDataFactoryName);
          if (!meta) {
            string newName = roomTranslated.StrValueByIndex(";", idx);
            oObj.RemoveMetaData(metaDataFactoryName);
            oObj.AddMetaData(metaDataFactoryName, oObj.Name());
            oObj.Name(newName);
          }
        }
        idx = idx + 1;
      }
    }

    !Sysvars
    foreach(oID, sv.EnumIDs()) {
      object oObj = dom.GetObject(oID);
      string listEntry;
      integer idx = 0;
      foreach(listEntry, svDefault.Split(";")) {
        if ((oObj.Name() == listEntry) || (oObj.Name() == "${"#listEntry#"}")) {
          var meta = oObj.MetaData(metaDataFactoryName);
          if (!meta) {
            string newName = svTranslated.StrValueByIndex(";", idx);
            oObj.RemoveMetaData(metaDataFactoryName);
            oObj.AddMetaData(metaDataFactoryName, oObj.Name());
            oObj.Name(newName);
          }
        }
  
        if ((oObj.ValueName0() == listEntry) || (oObj.ValueName0() == "${"#listEntry#"}")) {
          var meta = oObj.MetaData(metaDataFactoryName#"_VALUE_NAME_0");
          if (!meta) {
            string newValueName0 = svTranslated.StrValueByIndex(";", idx);
            oObj.RemoveMetaData(metaDataFactoryName#"_VALUE_NAME_0");
            oObj.AddMetaData(metaDataFactoryName#"_VALUE_NAME_0", oObj.ValueName0());
            oObj.ValueName0(newValueName0);
          }
        }
  
        if ((oObj.ValueName1() == listEntry) || (oObj.ValueName1() == "${"#listEntry#"}")) {
          var meta = oObj.MetaData(metaDataFactoryName#"_VALUE_NAME_1");
          if (!meta) {
            string newValueName1 = svTranslated.StrValueByIndex(";", idx);
            oObj.RemoveMetaData(metaDataFactoryName#"_VALUE_NAME_1");
            oObj.AddMetaData(metaDataFactoryName#"_VALUE_NAME_1", oObj.ValueName1());
            oObj.ValueName1(newValueName1);
          }
        }
    
       idx = idx + 1;
      }
    }

    Write("true");
  }

  set result [hmscript $script args]
  return $result
}

# reset the system language change
set result [resetSystemLanguage [array get args]]

# set the system language to lang
if { $result == "true" } {
  set result [setSystemLanguage [array get args]]

  if { $result == "true" } {
    # create /etc/config/systemLanguage with the
    # language as a content
    set fd [open /etc/config/systemLanguage w]
    puts -nonewline $fd $args(lang)
    close $fd
  }
}

jsonrpc_response $result
