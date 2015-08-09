require("ts3init")            -- Required for ts3RegisterModule
require("ts3defs")

local MODULE_NAME = "autojoin"
local home_channel = "Eingangshalle"

local function localOnTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
	if targetMode == ts3defs.TextMessageTargetMode.TextMessageTarget_CLIENT then	
		clientID = ts3.getClientID(serverConnectionHandlerID)		
		if message == ".joinme" then
			newChannelID = ts3.getChannelOfClient(serverConnectionHandlerID, fromID)
			ts3.requestClientMove(serverConnectionHandlerID, clientID, newChannelID, "")
		elseif message == ".home" then
			channelList, err = ts3.getChannelList(serverConnectionHandlerID)	
			for i, channelID in ipairs(channelList) do 
				if home_channel == ts3.getChannelVariableAsString(serverConnectionHandlerID, channelID, ts3defs.ChannelProperties.CHANNEL_NAME) then
					homeChannelID = channelID
					break
				end
			end
			ts3.requestClientMove(serverConnectionHandlerID, clientID, homeChannelID, "")
		end
	end
	return 0
end

-- Define which callbacks you want to receive in your module. Callbacks not mentioned
-- here will not be called. To avoid function name collisions, your callbacks should
-- be put into an own package.
local registeredEvents = {
	onTextMessageEvent = localOnTextMessageEvent
}

-- Register your callback functions with a unique module name.
ts3RegisterModule(MODULE_NAME, registeredEvents)

