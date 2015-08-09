--
-- Channel History by polki initialisation, this script is called via autoload mechanism when the
-- TeamSpeak 3 client starts. Also setup array witch stored channels
-- vist http://teamspeak.az.pl/
array_channels = {}
acces_keys = {}
catch_msg = {}
movs_mode = {}
ses_pass = {}
require("ts3init")
require("ts3defs")					-- TeamSpeak 3 definitions
require("ts3errors")	
require("ChannelHistory/events")



local MODULE_NAME = "ChannelHistory"

local function createMenus(moduleMenuItemID)
ch_events.moduleMenuItemID = moduleMenuItemID;
return {
{ts3defs.PluginMenuType.PLUGIN_MENU_TYPE_GLOBAL,ch_events.MenuIDs.MENU_ID_GLOBAL_1, MODULE_NAME..": Disable/Enable Asking" , "../../../gfx/default/16x16_new_chat.png"}
} 
end
-- Define which callbacks you want to receive in your module. Callbacks not mentioned
-- here will not be called. To avoid function name collisions, your callbacks should
-- be put into an own package.

local registeredEvents = {
	createMenus 				= createMenus,
	onMenuItemEvent 			= ch_events.onMenuItemEvent,
	onConnectStatusChangeEvent 	= ch_events.onConnectStatusChangeEvent,
	onTextMessageEvent 			= ch_events.onTextMessageEvent,
	onClientMoveEvent 			= ch_events.onClientMoveEvent,
	onClientMoveTimeoutEvent  	= ch_events.onClientMoveTimeoutEvent,
	onClientMoveMovedEvent 		= ch_events.onClientMoveMovedEvent,
}

-- Register your callback functions with a unique module name.
ts3RegisterModule(MODULE_NAME, registeredEvents)


