require("ts3init")
function onClientMoveEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, moveMessage)
	if ts3.getClientID(serverConnectionHandlerID) == clientID then
		local clientNAME = ts3.getClientDisplayName(serverConnectionHandlerID, clientID)
		ts3.printMessageToCurrentTab(os.date("[%x %X] ").."onClientMoveEvent: serverConnectionHandlerID=" .. serverConnectionHandlerID .. " | clientID=" .. clientID .. " | clientNAME="..clientNAME.." | oldChannelID=" .. oldChannelID .. " | newChannelID=" .. newChannelID .. " | visibility=" .. visibility .. " | moveMessage=" .. moveMessage)
	end
end
function onClientMoveSubscriptionEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility)
	if ts3.getClientID(serverConnectionHandlerID) == clientID then
		local clientNAME = ts3.getClientDisplayName(serverConnectionHandlerID, clientID)
		ts3.printMessageToCurrentTab(os.date("[%x %X]").." onClientMoveSubscriptionEvent:  serverConnectionHandlerID=" .. serverConnectionHandlerID .. " | clientID=" .. clientID  .. " | clientNAME="..clientNAME.." | oldChannelID=" .. oldChannelID .. " | newChannelID=" .. newChannelID .. " | visibility=" .. visibility)
	end
end
function onClientMoveTimeoutEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, timeoutMessage)
	if ts3.getClientID(serverConnectionHandlerID) == clientID then
		local clientNAME = ts3.getClientDisplayName(serverConnectionHandlerID, clientID)
		ts3.printMessageToCurrentTab(os.date("[%x %X]").." onClientMoveTimeoutEvent: serverConnectionHandlerID=" .. serverConnectionHandlerID .. " | clientID=" .. clientID .. " | clientNAME="..clientNAME.." | oldChannelID=" .. oldChannelID .. " | newChannelID=" .. newChannelID .. " | visibility=" .. visibility .. " | timeoutMessage=" .. timeoutMessage)
	end
end
function onClientMoveMovedEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, moverID, moverName, moverUniqueIdentifier, moveMessage)
	if ts3.getClientID(serverConnectionHandlerID) == clientID then
		local clientNAME = ts3.getClientDisplayName(serverConnectionHandlerID, clientID)
		ts3.printMessageToCurrentTab(os.date("[%x %X]").." onClientMoveMovedEvent: serverConnectionHandlerID=" .. serverConnectionHandlerID .. " | clientID=" .. clientID .. " | clientNAME="..clientNAME.." | oldChannelID=" .. oldChannelID .. " | newChannelID=" .. newChannelID .. " | visibility=" .. visibility .. " | moverID=" .. moverID .. " | moverName=" .. moverName .. " | moverUniqueIdentifier=" .. moverUniqueIdentifier .. " | moveMessage=" .. moveMessage)
	end
end
local registeredEvents = {
	onClientMoveEvent = onClientMoveEvent,
	onClientMoveSubscriptionEvent = onClientMoveSubscriptionEvent,
	onClientMoveTimeoutEvent = onClientMoveTimeoutEvent,
	onClientMoveMovedEvent = onClientMoveMovedEvent
}
ts3.printMessageToCurrentTab(os.date("[%x %X]").."errorMOVE\\init.lua loaded.")
ts3RegisterModule("moveTEST", registeredEvents)