
local function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
    local gChan = ts3.getChannelOfClient(serverConnectionHandlerID, fromID)
    ts3.requestSendChannelTextMsg(serverConnectionHandlerID, message, gChan)
end

chatbot_events = {
    onTextMessageEvent = onTextMessageEvent