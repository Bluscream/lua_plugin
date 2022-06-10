--
-- Testmodule initialisation, this script is called via autoload mechanism when the
-- TeamSpeak 3 client starts.
--

require("ts3init")            -- Required for ts3RegisterModule
-- require("fivem/table.save")

local MODULE_NAME = "fivem"

local clients_muted = {}
local clients_name = {}

function urlencode(str)
	if (str) then
	   str = string.gsub (str, "\n", "\r\n")
	   str = string.gsub (str, "([^%w ])",
		  function (c) return string.format ("%%%02X", string.byte(c)) end)
	   str = string.gsub (str, " ", "+")
	end
	return str    
 end
local function getTimeStamp()
	return "[color=#33597D]<"..os.date("%X")..">[/color]"
end
ts3.printMessageToCurrentTab(getTimeStamp() .. "loading fivem/init.lua")
local function getClientLink(clid, uid, name)
	return "[b][color=#002F5D]\"[URL=client://"..clid.."/"..uid.."~"..urlencode(name).."]"..name.."[/URL]\"[/color][/b]"
end

local function onConnectStatusChangeEvent(serverConnectionHandlerID, status, errorNumber)
    ts3.printMessageToCurrentTab("TestModule: onConnectStatusChangeEvent: " .. serverConnectionHandlerID .. " " .. ts3defs.ConnectStatus[status].name .. " " .. errorNumber)
end

local function onTalkStatusChangeEvent(serverConnectionHandlerID, status, isReceivedWhisper, clientID)
    ts3.printMessageToCurrentTab("TestModule: onTalkStatusChangeEvent: " .. serverConnectionHandlerID .. " " .. ts3defs.TalkStatus[status].name .. " " .. isReceivedWhisper .. " " .. clientID)
end

local function onClientMoveEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, moveMessage)
	if oldChannelID ~= 0 then return end
	local clientName, error = ts3.getClientVariableAsString(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_NICKNAME)
	if error == ts3errors.ERROR_ok and not string.match(clientName, "^[%d]+ ") then clients_name[clientID] = clientName	end
end

local function onUpdateClientEvent(serverConnectionHandlerID, clid, invokerID, invokerName, invokerUniqueIdentifier)
	if invokerID ~= clid then return end

	local myId = ts3.getClientID(serverConnectionHandlerID)
	local myChannel, error = ts3.getChannelOfClient(serverConnectionHandlerID, myId)
	local theirChannel, error = ts3.getChannelOfClient(serverConnectionHandlerID, clid)
	if theirChannel ~= myChannel then return end

	local client_isMuted, error = ts3.getClientVariableAsInt(serverConnectionHandlerID,clid,ts3defs.ClientProperties.CLIENT_IS_MUTED)
	local client_wasMuted = clients_muted[clid]
	clients_muted[clid] = client_isMuted
	if client_wasMuted  == nil then return end
	local name, error = ts3.getClientVariableAsString(serverConnectionHandlerID, clid, ts3defs.ClientProperties.CLIENT_NICKNAME)
	local uid, error = ts3.getClientVariableAsString(serverConnectionHandlerID, clid, ts3defs.ClientProperties.CLIENT_UNIQUE_IDENTIFIER)
	if clients_name[clid]  ~= nil then
		name = clients_name[clid]
	end
	txt = getTimeStamp() .. " " .. getClientLink(clid, uid, name) .. " "
	if client_isMuted == 1 then
		txt = txt .. "[color=red]has gone out of range[/color]"
	else
		txt = txt .. "[color=green]has gone in range[/color]"
	end
	ts3.printMessageToCurrentTab(txt)
end

local function onMenuItemEvent(serverConnectionHandlerID, menuType, menuItemID, selectedItemID)
	if menuItemID == 0 then
		ts3.printMessageToCurrentTab("match: " .. string.match(clientName, "^[%d+] "))
	end
end

function test(serverConnectionHandlerID, ...)
	ts3.printMessageToCurrentTab("test1")
	local argMsg = ""
	ts3.printMessageToCurrentTab("test2")
	ts3.printMessageToCurrentTab("test3")
	ts3.printMessageToCurrentTab(argMsg .. " match: " .. string.match(arg[0], "^[%d+] "))
end

function muteall(serverConnectionHandlerID)
	local clients, error = ts3.getClientList(serverConnectionHandlerID)
	ts3.requestMuteClients(serverConnectionHandlerID, clients)
end
function unmuteall(serverConnectionHandlerID)
	local clients, error = ts3.getClientList(serverConnectionHandlerID)
	ts3.requestUnmuteClients(serverConnectionHandlerID, clients)
end

local function createMenus(moduleMenuItemID)
	-- Store value added to menuIDs to be able to calculate menuIDs for this module again for setPluginMenuEnabled (see demo.lua)
	testmodule_events.moduleMenuItemID = moduleMenuItemID

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
		{ts3defs.PluginMenuType.PLUGIN_MENU_TYPE_CLIENT,  0,  "Check Name",  "../test_plugin/1.png"},
	}
end

-- Define which callbacks you want to receive in your module. Callbacks not mentioned
-- here will not be called. To avoid function name collisions, your callbacks should
-- be put into an own package.
local registeredEvents = {
	createMenus = createMenus,
	onConnectStatusChangeEvent = onConnectStatusChangeEvent,
	onTalkStatusChangeEvent = onTalkStatusChangeEvent,
	onUpdateClientEvent = onUpdateClientEvent,
	onClientMoveEvent = onClientMoveEvent,
	onMenuItemEvent = onMenuItemEvent
}

-- Register your callback functions with a unique module name.
ts3RegisterModule(MODULE_NAME, registeredEvents)

ts3.printMessageToCurrentTab(getTimeStamp() .. "loaded fivem/init.lua")