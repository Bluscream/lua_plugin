require("ts3init")
require("Extended Info/events")
require("Extended Info/functions")
local ExtendedInfo = {
	const = {
		MODULE = "Extended Info Module",
		MODULESHORT = "EI",
		MODULEFOLDER = "Extended Info",
		MODULEFILE = "init",
		MODULEEXT = "lua",
		MODULEVERSION = "1.0",
		MODULEAUTHOR = "Bluscream",
		DEBUG = true,
	},
}
local registeredEvents = {
	onConnectStatusChangeEvent = ei_events.onConnectStatusChangeEvent,
	onServerUpdatedEvent = ei_events.onServerUpdatedEvent,
	onClientMoveEvent = ei_events.onClientMoveEvent,
	onTextMessageEvent = ei_events.onTextMessageEvent
}
ts3.printMessageToCurrentTab("Extended Info loaded.")
-- ScriptLog("Loaded "..ExtendedInfo.const.MODULE.." v"..ExtendedInfo.const.MODULEVERSION.." by "..ExtendedInfo.const.MODULEAUTHOR.." from "..ts3.getPluginPath().."lua_plugin/"..ExtendedInfo.const.MODULEFOLDER.."/"..ExtendedInfo.const.MODULEFILE.."."..ExtendedInfo.const.MODULEEXT)
ts3RegisterModule("ExtendedInfo", registeredEvents)