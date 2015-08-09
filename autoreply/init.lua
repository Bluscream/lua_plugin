require("ts3init")

local function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
    local myClient = ts3.getClientID(serverConnectionHandlerID)
    local  response = "I am currently Away from Keyboard. Please try again later!"
    if targetMode = ts3defs.TextMessageTargetMode.TextMessageTarget_CLIENT and fromID ~= myClient then
        ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, response, fromID)
    end
end

ts3RegisterModule("autoreply", registeredEvents)