require("ts3init")
require("ts3defs")
local MODULE_NAME = "msgbot"
local function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
	lowMSG = string.lower(message)
	ts3.printMessageToCurrentTab(message)
	ts3.printMessageToCurrentTab(lowMSG)
	-- if string.sub(lowMSG, 1, 1) == "!" then
		-- if string.sub(lowMSG, 2) == "help"
			-- ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "MSG Bot by [color=blue]Bluscream[/color]\n\nAvailable commands:\n\n!help - Show this message.\n!return - Return your input as my output.\n!ddos/flood/udp/tcp {clientID} - Attack selected user.", fromID)
			-- return
		-- elseif string.sub(lowMSG, 2) == "return"
			-- ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, message, fromID)
			-- return
		-- end
	-- end
end
local registeredEvents {
	onTextMessageEvent = onTextMessageEvent
}
ts3RegisterModule(MODULE_NAME, registeredEvents)