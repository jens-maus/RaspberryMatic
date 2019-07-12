/**
 * mainmenu/admin.json
 * Hauptmenü für den Administrator
 **/

[
  {id: "menuStartPage", align: "left", action: function() { WebUI.enter(StartPage); }   , submenu: [ ]},
	{id: "menuControlPage", align: "left", action: function() { WebUI.enter(ControlPage); }, submenu:
	[
    {id: "submenuDiagramListPage", action: function() { ConfigData.check(function() { WebUI.enter(DiagramListPage);});}},
    {id: "submenuFavorites", action: function() { WebUI.enter(ControlFavoritesPage); }},
    {id: "submenuDevices"   , action: function() { WebUI.enter(ControlDevicesPage); }},
    {id: "submenuFunction"  , action: function() { WebUI.enter(ControlFunctionsPage); }},
		{id: "submenuPrograms", action: function() { WebUI.enter(ControlProgramsPage); } },
    {id: "submenuRooms"    , action: function() { WebUI.enter(ControlRoomsPage); }},
		{id: "submenuSysProtocol", action: function() { WebUI.enter(ControlProtocolPage); }},
		{id: "submenuSysVar" , action: function() { WebUI.enter(ControlVariablesPage); }}

	]},
  {id: "menuProgramsLinksPage", align: "left", action: function() { ConfigData.check(function() { WebUI.enter(LinksAndProgramsPage); }); }, submenu:
  [
    {id: "submenuDirectLinks"                , action: function() { ConfigData.check(function() { WebUI.enter(LinkListPage); }); }   },
    {id: "submenuProgramsLinks", action: function() { ConfigData.check( function() { WebUI.enter(ProgramListPage); }); }}
  ]},
  {id: "menuSettingsPage", align: "left", action: function() { ConfigData.check(function() { WebUI.enter(SystemConfigPage); }); }, submenu:
  [ 
    {id: "submenuUserManagement"  , action: function() { WebUI.enter(UserAdminPageAdmin); }},
    {id: "submenuCreateDiagram"     , action: function() { ConfigData.check(function() { WebUI.enter(CreateDiagramPage); } ); } },
    {id: "submenuFavorites"           , action: function() { ConfigData.check(function() { WebUI.enter(FavoriteListPage); } ); } },
    {id: "submenuDevices"              , action: function() { ConfigData.check(function() { WebUI.enter(DeviceListPage); }); }    } ,
    {id: "submenuDeviceFirmwareInformation"     , action: function() { ConfigData.check(function() { WebUI.enter(DeviceFirmwareInformation); } );  } },
    {id: "submenuDeviceInbox", action: function() { ConfigData.check(function() { WebUI.enter(NewDeviceListPage); }); } },
    {id: "submenuFunction"             , action: function() { ConfigData.check(function() { WebUI.enter(FunctionListPage); }); }  },
    {id: "submenuCreateGroups"     , action: function() { ConfigData.check(function() { WebUI.enter(CreateGroupPage); } );  } },
    {id: "submenuRooms"               , action: function() { ConfigData.check(function() { WebUI.enter(RoomListPage); }); }      },
    //{id: "submenuCreateTestPage"     , action: function() { ConfigData.check(function() { WebUI.enter(CreateTestPage); } );  } },
    //{id: "submenuDeviceFirmware"     , action: function() { ConfigData.check(function() { WebUI.enter(DeviceFirmware); } );  } },
    {id: "submenuSysControl"     , action: function() { WebUI.enter(SystemControlPage);  } },
    {id: "submenuSysVar"      , action: function() { ConfigData.check(function() { WebUI.enter(VariableListPage); }); }  }

  ]},
  {id: "menuHelpPage"          , align: "right", action: function() { WebUI.enter(HelpPage); }, submenu: [ ]},
  {id: "menuNewDevicesPage", align: "right", action: function() { ConfigData.check(function() { showAddDeviceCP(false);/*true activates the install mode when entering the page*/ }); }, submenu: [ ]}
]
