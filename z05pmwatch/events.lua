--
-- Testmodule callback functions
--
-- To avoid function name collisions, you should use local functions and export them with a unique package name.
--
local pmMyNam = "PMWatch "

local function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
    pmwTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
	  return 0
end

local function onClientPokeEvent(serverConnectionHandlerID, pokerID, pokerName, message, ffIgnored)
    pmwClientPokeEvent(serverConnectionHandlerID, pokerID, pokerName, message, ffIgnored)
 	  return 0
end

----------------------------------------------------

pmwatch_events = {
	onTextMessageEvent = onTextMessageEvent,
	onClientPokeEvent  = onClientPokeEvent,
}
