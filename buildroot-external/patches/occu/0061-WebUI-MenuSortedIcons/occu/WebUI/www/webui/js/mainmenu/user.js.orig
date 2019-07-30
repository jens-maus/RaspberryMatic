/**
 * mainmenu/user.json
 * Hauptmenü für normale Anwender.
 **/

[
  {id: "menuStartPage", align: "left", action: function() { WebUI.enter(StartPage); }   , submenu: [ ]},
	{id: "menuControlPage", align: "left", action: function() { WebUI.enter(ControlPage); }, submenu:
	[
    {id: "submenuDevices"   , action: function() { WebUI.enter(ControlDevicesPage); }  },
    {id: "submenuRooms"    , action: function() { WebUI.enter(ControlRoomsPage); }    },
    {id: "submenuFunction"  , action: function() { WebUI.enter(ControlFunctionsPage); }},
    {id: "submenuDiagramListPage", action: function() { ConfigData.check(function() { WebUI.enter(DiagramListPage);});}},
		{id: "submenuFavorites", action: function() { WebUI.enter(ControlFavoritesPage); }},
		{id: "submenuPrograms", action: function() { WebUI.enter(ControlProgramsPage); } },
		{id: "submenuSysVar" , action: function() { WebUI.enter(ControlVariablesPage); }},
		{id: "submenuSysProtocol", action: function() { WebUI.enter(ControlProtocolPage); } }
	]},
  {id: "menuSettingsPage", align: "left", action: function() { ConfigData.check(function() { WebUI.enter(SystemConfigPageUser); }); }, submenu:
  [ 
    {id: "submenuUserManagement", action: function() { WebUI.enter(UserAdminPageUser); }},
    {id: "submenuCreateDiagram"     , action: function() { ConfigData.check(function() { WebUI.enter(CreateDiagramPage); } ); } },
    {id: "submenuFavorites"         , action: function() { ConfigData.check(function() { WebUI.enter(FavoriteListPage); }); } }
  ]},
  {id: "menuHelpPage", align: "right", action: function() { WebUI.enter(HelpPage); }, submenu: [ ]}
]
