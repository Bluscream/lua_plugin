--
-- Testmodule callback functions
--
-- To avoid function name collisions, you should use local functions and export them with a unique package name.
--
local agMyNam = "AnnounceGroup "

local function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
    agTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
	  return 0
end

local function onClientMoveEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, moveMessage)
--    ts3.printMessageToCurrentTab("EVENT agMove")
    agClientMoveEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, moveMessage)
 	  return 0
end

local function onClientMoveMovedEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, moverID, moverName, moverUniqueIdentifier, moveMessage)
    agClientMoveMovedEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, moverID, moverName, moverUniqueIdentifier, moveMessage)
 	  return 0
end

announcegrp_events = {
	onTextMessageEvent = onTextMessageEvent,
	onClientMoveEvent = onClientMoveEvent,
	onClientMoveMovedEvent = onClientMoveMovedEvent,
}
