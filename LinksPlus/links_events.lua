local function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
	-- Calls receiveMsg to check if there is a link
	receiveMsg(message)
	return 0
end

links_events = {
onTextMessageEvent = onTextMessageEvent
}
