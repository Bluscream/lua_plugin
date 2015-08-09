--
-- Mass Control Module Init
-- Version: 1.0
-- Author: Willy_Sunny
-- Website: http://www.ts3chinese.com
-- E-Mail: willy_sunny@ts3chinese.com
--

require("ts3init")
require("masscontrolmodule/events")  -- Forwarded TeamSpeak 3 callbacks
require("masscontrolmodule/masscontrol")

local function createMenus(moduleMenuItemID)
	-- Store value added to menuIDs to be able to calculate menuIDs for this module again for setPluginMenuEnabled (see demo.lua)
	moduleMenuItemID = moduleMenuItemID

	-- Create the menus
	-- There are three types of menu items:
	--   ts3defs.PluginMenuType.PLUGIN_MENU_TYPE_CLIENT:  Client context menu
	--   ts3defs.PluginMenuType.PLUGIN_MENU_TYPE_CHANNEL: Channel context menu
	--   ts3defs.PluginMenuType.PLUGIN_MENU_TYPE_GLOBAL:  "Plugins" menu in menu bar of main window
	--
	-- Menu IDs are used to identify the menu item when onMenuItemEvent is called, see testmodule/events.lua for the implementation of onMenuItemEvent
	-- Valid menu IDs are 0 to 999.
	--
	-- The menu text is required, max length is 128 characters
	--
	-- The icon is optional, max length is 128 characters. When not using icons, just pass an empty string.
	-- Icons are loaded from a subdirectory in the TeamSpeak client plugins folder. The subdirectory must be named like the
	-- plugin filename, without dll/so/dylib suffix
	-- e.g. for "test_plugin.dll", icon "1.png" is loaded from <TeamSpeak 3 Client install dir>\plugins\test_plugin\1.png
	-- In this example we reuse the existing icons from the plugins\test_plugin\ directory, which resides as "..\test_plugin" relative to
	-- the lua_plugin directory.

	return {
		     {ts3defs.PluginMenuType.PLUGIN_MENU_TYPE_CHANNEL, ccrash, "Crash Channel", "../test_plugin/1.png"},
		     {ts3defs.PluginMenuType.PLUGIN_MENU_TYPE_GLOBAL,  mcrash,  "Crash all Clients",  "../test_plugin/1.png"},
	}
end

local registeredEvents = {
	createMenus = createMenus,
	onMenuItemEvent = onMenuItemEvent
}

ts3RegisterModule("masscontrolmodule", registeredEvents)
