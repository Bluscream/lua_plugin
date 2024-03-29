--
-- Testmodule initialisation, this script is called via autoload mechanism when the
-- TeamSpeak 3 client starts.
--

require("ts3init")            -- Required for ts3RegisterModule
-- require("fivem/table.save")

local MODULE_NAME = "saltychat"

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
	return "[color=#1a91d0] (ℹ️)[color=#507d70]<"..os.date("%X")..">"
end
-- ts3.printMessageToCurrentTab(getTimeStamp() .. "loading saltychat/init.lua")
local function getClientLink(clid, uid, name)
	return "[b][color=#1cb0f4]\"[URL=client://"..clid.."/"..uid.."~"..urlencode(name).."]"..name.."[/URL]\"[/color][/b]"
end

local function onClientMoveEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, moveMessage)
	if oldChannelID ~= 0 then return end
	local clientName, error = ts3.getClientVariableAsString(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_NICKNAME)
	if error == ts3errors.ERROR_ok and not string.match(clientName, "^[%d]+ ") then clients_name[clientID] = clientName	end
end

local function onUpdateClientEvent(serverConnectionHandlerID, clid, invokerID, invokerName, invokerUniqueIdentifier)
	if invokerID ~= 0 then return end
	local myId = ts3.getClientID(serverConnectionHandlerID)
	if clid == myId then return end

	local client_isMuted, error = ts3.getClientVariableAsInt(serverConnectionHandlerID,clid,ts3defs.ClientProperties.CLIENT_IS_MUTED)
	local client_wasMuted = clients_muted[clid]
	clients_muted[clid] = client_isMuted
	if client_wasMuted  == nil then return end

	
	local myChannel, error = ts3.getChannelOfClient(serverConnectionHandlerID, myId)
	local theirChannel, error = ts3.getChannelOfClient(serverConnectionHandlerID, clid)
	if theirChannel ~= myChannel then return end

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

function muteall(serverConnectionHandlerID)
	local clients, error = ts3.getClientList(serverConnectionHandlerID)
	ts3.requestMuteClients(serverConnectionHandlerID, clients)
end
function unmuteall(serverConnectionHandlerID)
	local clients, error = ts3.getClientList(serverConnectionHandlerID)
	ts3.requestUnmuteClients(serverConnectionHandlerID, clients)
end

-- Define which callbacks you want to receive in your module. Callbacks not mentioned
-- here will not be called. To avoid function name collisions, your callbacks should
-- be put into an own package.
local registeredEvents = {
	onUpdateClientEvent = onUpdateClientEvent,
	onClientMoveEvent = onClientMoveEvent
}

-- Register your callback functions with a unique module name.
ts3RegisterModule(MODULE_NAME, registeredEvents)

-- ts3.printMessageToCurrentTab(getTimeStamp() .. "loaded saltychat/init.lua")