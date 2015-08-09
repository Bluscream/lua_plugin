require("ts3init")            -- Required for ts3RegisterModule

local function onClientKickFromServerEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, kickerID, kickerName, kickerUniqueIdentifier, kickMessage)

local msg=kickerName .. " just kicked someone from the server."
ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, msg, ts3.getClientID(serverConnectionHandlerID))


end