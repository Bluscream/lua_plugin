--=======================================--
--============= Frigyd Events =============--
--=======================================--


local function onConnectStatusChangeEvent(serverConnectionHandlerID, status, errorNumber)
	
	for k,v in pairs(connectHandlers) do
		k(serverConnectionHandlerID, status, errorNumber)
	end
	
end

local function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
	for k,v in pairs(chatHandlers) do
		k(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
	end
	
    return 0
end

local function onTalkStatusChangeEvent(serverConnectionHandlerID, status, isReceivedWhisper, clientID)
	for k,v in pairs(speechHandlers) do
		k(serverConnectionHandlerID, status, isReceivedWhisper, clientID)
	end
	
end

local function onClientMoveEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, moveMessage)

	for k,v in pairs(moveHandlers) do
		k(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, moveMessage)
	end
	
end

local function onClientMoveMovedEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, moverID, moverName, moverUniqueIdentifier, moveMessage)
	
	for k,v in pairs(adMoveHandlers) do
		k(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, moverID, moverName, moverUniqueIdentifier, moveMessage)
	end
	
end

local function onClientMoveTimeoutEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, timeoutMessage)
	
	for k,v in pairs(timeoutMoveHandlers) do
		k(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, timeoutMessage)
	end
	
end

local function onUpdateClientEvent(serverConnectionHandlerID, clientID)
	print("==== UPDATE CLIENT EVENT ====")
	
	
end

frig_events = {
	onConnectStatusChangeEvent = onConnectStatusChangeEvent,
	onTextMessageEvent = onTextMessageEvent,
	onTalkStatusChangeEvent = onTalkStatusChangeEvent,
	onClientMoveEvent = onClientMoveEvent,
	onClientMoveMovedEvent = onClientMoveMovedEvent,
	onClientMoveTimeoutEvent = onClientMoveTimeoutEvent,
	onUpdateClientEvent = onUpdateClientEvent
}


