--
-- Testmodule callback functions
--
-- To avoid function name collisions, you should use local functions and export them with a unique package name.
--
local buMyNam = "BackupMyTs3 "

local function onUpdateClientEvent(serverConnectionHandlerID, clientID)
    buCheckToBackup(serverConnectionHandlerID, clientID)
 	  return 0
end

local function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
    buCheckToBackup(serverConnectionHandlerID, clientID)
    buTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
	  return 0
end

local function onClientMoveEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, moveMessage)
    buCheckToBackup(serverConnectionHandlerID, clientID)
 	  return 0
end

backupmyts3_events = {
	onUpdateClientEvent = onUpdateClientEvent,
	onTextMessageEvent = onTextMessageEvent,
	onClientMoveEvent = onClientMoveEvent,
}
