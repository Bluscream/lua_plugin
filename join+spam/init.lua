require("ts3init")
require("ts3defs")
require("ts3events")
local myMSG = "FÜGE HIER DEINE NACHRICHT EIN!"
troll_mode = false
troll_mode2 = false
function troll(serverConnectionHandlerID)
	if troll_mode == true then
		troll_mode = false
		ts3.printMessageToCurrentTab("Troll mode set to \"FALSE\"")
	else
		troll_mode = true
		ts3.printMessageToCurrentTab("Troll mode set to \"TRUE\"")
	end
end
function troll2(serverConnectionHandlerID)
	if troll_mode2 == true then
		troll_mode2 = false
		ts3.printMessageToCurrentTab("Troll mode 2 set to \"FALSE\"")
	else
		troll_mode2 = true
		ts3.printMessageToCurrentTab("Troll mode 2 set to \"TRUE\"")
	end
end
function randomNick(serverConnectionHandlerID)
	local nameArray = { 'TeamspeakUser', 'TeamSpeakUser', 'Android', 'Android_Client', 'IPhone', 'IPhone_Client' }
	local RANDNAME = ( nameArray[ math.random( #nameArray ) ] )
	local newNick = RANDNAME .. math.random(1,99)
	ts3.printMessageToCurrentTab("Renaming self to "..newNick..".")
	ts3.setClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME, newNick)
	local error = ts3.flushClientSelfUpdates(serverConnectionHandlerID)
	if error ~= ts3errors.ERROR_ok then
		ts3.printMessageToCurrentTab("Error renaming to "..newnick..", ErrorID: "  .. error)
		return
	end
end
function onNewChannelCreatedEvent(serverConnectionHandlerID, channelID, channelParentID, invokerID, invokerName, invokerUniqueIdentifier)
	if troll_mode == true then
		local channelPassworded = ts3.getChannelVariableAsInt(serverConnectionHandlerID, channelID, ts3defs.ChannelProperties.CHANNEL_FLAG_PASSWORD)
		if channelPassworded == 0 then
			local clientID = ts3.getClientID(serverConnectionHandlerID)
			ts3.requestClientMove(serverConnectionHandlerID, clientID, channelID, myMSG)
			ts3.requestSendChannelTextMsg(serverConnectionHandlerID, myMSG, channelID)
			randomNick(serverConnectionHandlerID)
		end
	end
end
function onClientMoveEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, moveMessage)
	if troll_mode2 == true then
		local clientIDown = ts3.getClientID(serverConnectionHandlerID)
		if clientID == clientIDown then
			ts3.requestSendChannelTextMsg(serverConnectionHandlerID, myMSG, channelID)
			randomNick(serverConnectionHandlerID)
		end
	end
end
local registeredEvents = {
	onNewChannelCreatedEvent = onNewChannelCreatedEvent,
	onClientMoveEvent = onClientMoveEvent
}

ts3RegisterModule(joinplusspam, registeredEvents)