--require("squall/plugins/AutoChannelMakerEx")
require("squall/plugins/RoomEx")

function onClientMoveMovedEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, moverID, moverName, moverUniqueIdentifier, moveMessage)
	if AutoChannelMakerEx ~= nil then
		AutoChannelMakerEx.onMove(serverConnectionHandlerID, clientID, oldChannelID, newChannelID)
	end
	
	if RoomEx ~= nil then
		RoomEx.onMove(serverConnectionHandlerID, clientID, oldChannelID, newChannelID)
	end
end

function onClientMoveEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, moveMessage)
	if AutoChannelMakerEx ~= nil then
		AutoChannelMakerEx.onMove(serverConnectionHandlerID, clientID, oldChannelID, newChannelID)
	end
	
	if RoomEx ~= nil then
		RoomEx.onMove(serverConnectionHandlerID, clientID, oldChannelID, newChannelID)
	end
end

function onClientKickFromServerEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, kickerID, kickerName, kickerUniqueIdentifier, kickMessage)
	if AutoChannelMakerEx ~= nil then
		AutoChannelMakerEx.onLeave(serverConnectionHandlerID, clientID, oldChannelID, newChannelID)
	end
end

function onClientKickFromChannelEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, kickerID, kickerName, kickerUniqueIdentifier, kickMessage)
	if AutoChannelMakerEx ~= nil then
		AutoChannelMakerEx.onLeave(serverConnectionHandlerID, clientID, oldChannelID, newChannelID)
	end
end

function onClientMoveTimeoutEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, timeoutMessage)
	if AutoChannelMakerEx ~= nil then
		AutoChannelMakerEx.onLeave(serverConnectionHandlerID, clientID, oldChannelID, newChannelID)
	end
end

function onClientBanFromServerEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, kickerID, kickerName, kickerUniqueIdentifier, kickTime, kickMessage)
	if AutoChannelMakerEx ~= nil then
		AutoChannelMakerEx.onLeave(serverConnectionHandlerID, clientID, oldChannelID, newChannelID)
	end
end

squall_events = {
	onClientMoveEvent = onClientMoveEvent,
	onClientMoveMovedEvent = onClientMoveMovedEvent,
	onClientKickFromServerEvent = onClientKickFromServerEvent,
	onClientKickFromChannelEvent = onClientKickFromChannelEvent,
	onClientMoveTimeoutEvent = onClientMoveTimeoutEvent,
	onClientBanFromServerEvent = onClientBanFromServerEvent,
}