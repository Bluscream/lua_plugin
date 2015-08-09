--[[ ===== FUNC SECTION ======]]
local baname = "BadWords "

	function onConnectStatusChangeEvent(serverConnectionHandlerID, status, errorNumber)
    print(baname .. "Lua: onConnectStatusChangeEvent: " .. serverConnectionHandlerID .. " " .. status .. " " .. errorNumber)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onConnectStatusChangeEvent ~= nil then
			events.onConnectStatusChangeEvent(serverConnectionHandlerID, status, errorNumber)
		end
	end
end
local function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
    print(baname .. ": onTextMessageEvent: " .. serverConnectionHandlerID .. " " .. targetMode .. " " .. toID .. " " .. fromID .. " " .. fromName .. " " .. fromUniqueIdentifier .. " " .. message .. " " .. ffIgnored)

end

local function onUpdateClientEvent(serverConnectionHandlerID, clientID)
	print(baname .. "==== UPDATE CLIENT(" .. clientID .. ") EVENT ====")
end

local function onChannelMoveEvent(serverConnectionHandlerID, channelID, newParentChannelID, invokerID, invokerName, invokerUniqueIdentifier)
    print(baname .. ": onTextMessageEvent: " .. serverConnectionHandlerID .. " " .. channelID .. " " .. newParentChannelID .. " " .. invokerID .. " " .. invokerName .. " " .. invokerUniqueIdentifier .. " " .. message .. " " .. ffIgnored)
end	
local function onChannelMove(serverConnectionHandlerID, channelID, channelParentID)
    print(baname .. ": onTextMessageEvent: " .. serverConnectionHandlerID .. " " .. channelID .. " " .. channelParentID .."")
end	
badwords_events = {	
onServerPermissionErrorEvent = onServerPermissionErrorEvent,
onTextMessageEvent = onTextMessageEvent,
					onUpdateClientEvent = onUpdateClientEvent,
					onChannelMove = onChannelMove,
					}

