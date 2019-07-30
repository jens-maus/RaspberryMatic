/**
 * mainmenu/user.json
 * Hauptmenü für normale Anwender.
 **/

[
  {id: "menuStartPage", align: "left", action: function() { WebUI.enter(StartPage); }   , submenu: [ ]},
	{id: "menuControlPage", align: "left", action: function() { WebUI.enter(ControlPage); }, submenu:
	[
    {id: "submenuDiagramListPage", action: function() { ConfigData.check(function() { WebUI.enter(DiagramListPage);});}},
		{id: "submenuFavorites", action: function() { WebUI.enter(ControlFavoritesPage); }},
    {id: "submenuDevices"   , action: function() { WebUI.enter(ControlDevicesPage); }  },
    {id: "submenuFunction"  , action: function() { WebUI.enter(ControlFunctionsPage); }},
		{id: "submenuPrograms", action: function() { WebUI.enter(ControlProgramsPage); } },
    {id: "submenuRooms"    , action: function() { WebUI.enter(ControlRoomsPage); }    },
		{id: "submenuSysProtocol", action: function() { WebUI.enter(ControlProtocolPage); } },
		{id: "submenuSysVar" , action: function() { WebUI.enter(ControlVariablesPage); }}
	]},
  {id: "menuSettingsPage", align: "left", action: function() { ConfigData.check(function() { WebUI.enter(SystemConfigPageUser); }); }, submenu:
  [ 
    {id: "submenuUserManagement", action: function() { WebUI.enter(UserAdminPageUser); }},
    {id: "submenuCreateDiagram"     , action: function() { ConfigData.check(function() { WebUI.enter(CreateDiagramPage); } ); } },
    {id: "submenuFavorites"         , action: function() { ConfigData.check(function() { WebUI.enter(FavoriteListPage); }); } }
  ]},
  {id: "menuHelpPage", align: "right", action: function() { WebUI.enter(HelpPage); }, submenu: [ ]}
]
