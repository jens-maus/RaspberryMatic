/**
 * mainmenu/admin.json
 * Hauptmenü für den Administrator
 **/

[
  {id: "menuStartPage", align: "left", action: function() { WebUI.enter(StartPage); }   , submenu: [ ]},
	{id: "menuControlPage", align: "left", action: function() { WebUI.enter(ControlPage); }, submenu:
	[
    {id: "submenuDevices"   , action: function() { WebUI.enter(ControlDevicesPage); }},
    {id: "submenuRooms"    , action: function() { WebUI.enter(ControlRoomsPage); }},
    {id: "submenuFunction"  , action: function() { WebUI.enter(ControlFunctionsPage); }},
    {id: "submenuDiagramListPage", action: function() { ConfigData.check(function() { WebUI.enter(DiagramListPage);});}},
    {id: "submenuFavorites", action: function() { WebUI.enter(ControlFavoritesPage); }},
		{id: "submenuPrograms", action: function() { WebUI.enter(ControlProgramsPage); } },
		{id: "submenuSysVar" , action: function() { WebUI.enter(ControlVariablesPage); }},
		{id: "submenuSysProtocol", action: function() { WebUI.enter(ControlProtocolPage); }}

	]},
  {id: "menuProgramsLinksPage", align: "left", action: function() { ConfigData.check(function() { WebUI.enter(LinksAndProgramsPage); }); }, submenu:
  [
    {id: "submenuDirectLinks"                , action: function() { ConfigData.check(function() { WebUI.enter(LinkListPage); }); }   },
    {id: "submenuProgramsLinks", action: function() { ConfigData.check( function() { WebUI.enter(ProgramListPage); }); }}
  ]},
  {id: "menuSettingsPage", align: "left", action: function() { ConfigData.check(function() { WebUI.enter(SystemConfigPage); }); }, submenu:
  [ 
    {id: "submenuDeviceInbox", action: function() { ConfigData.check(function() { WebUI.enter(NewDeviceListPage); }); } },
    {id: "submenuDevices"              , action: function() { ConfigData.check(function() { WebUI.enter(DeviceListPage); }); }    } ,
    {id: "submenuRooms"               , action: function() { ConfigData.check(function() { WebUI.enter(RoomListPage); }); }      },
    {id: "submenuFunction"             , action: function() { ConfigData.check(function() { WebUI.enter(FunctionListPage); }); }  },
    {id: "submenuCreateDiagram"     , action: function() { ConfigData.check(function() { WebUI.enter(CreateDiagramPage); } ); } },
    {id: "submenuCreateGroups"     , action: function() { ConfigData.check(function() { WebUI.enter(CreateGroupPage); } );  } },
    //{id: "submenuCreateTestPage"     , action: function() { ConfigData.check(function() { WebUI.enter(CreateTestPage); } );  } },
    //{id: "submenuDeviceFirmware"     , action: function() { ConfigData.check(function() { WebUI.enter(DeviceFirmware); } );  } },
    {id: "submenuDeviceFirmwareInformation"     , action: function() { ConfigData.check(function() { WebUI.enter(DeviceFirmwareInformation); } );  } },

    {id: "submenuUserManagement"  , action: function() { WebUI.enter(UserAdminPageAdmin); }},
    {id: "submenuSysVar"      , action: function() { ConfigData.check(function() { WebUI.enter(VariableListPage); }); }  },
    {id: "submenuFavorites"           , action: function() { ConfigData.check(function() { WebUI.enter(FavoriteListPage); } ); } },
    {id: "submenuSysControl"     , action: function() { WebUI.enter(SystemControlPage);  } }

  ]},
  {id: "menuHelpPage"          , align: "right", action: function() { WebUI.enter(HelpPage); }, submenu: [ ]},
  {id: "menuNewDevicesPage", align: "right", action: function() { ConfigData.check(function() { showAddDeviceCP(false);/*true activates the install mode when entering the page*/ }); }, submenu: [ ]}
]
