require("NoX/settings")
require("NoX/functions")
function onClientChannelGroupChangedEvent(serverConnectionHandlerID, channelGroupID, channelID, clientID, invokerClientID, invokerName, invokerUniqueIdentity)
	local clientIDown = ts3.getClientID(serverConnectionHandlerID)
	if clientIDown == clientID then
		for i=1, #nox.setting.BanGroups do
			if nox.setting.BanGroups[i] == channelGroupID then
				KickedChannelID = channelID
				KickedChannelNAME = ts3.getChannelVariableAsString(serverConnectionHandlerID, channelID, 0)
				ScriptLog("Saved Last Channel as \"".. KickedChannelNAME .. "\" ".."#"..KickedChannelID)
				setID(serverConnectionHandlerID)
			end
		end
		for i=1, #nox.setting.SpamGroups do
			if nox.setting.SpamGroups[i] == channelGroupID then
				KickedChannelID = channelID
				KickedChannelNAME = ts3.getChannelVariableAsString(serverConnectionHandlerID, channelID, 0)
				ScriptLog("Saved Last Channel as \"".. KickedChannelNAME .. "\" ".."#"..KickedChannelID)
				setID(serverConnectionHandlerID)
			end
		end
	end
end
function onClientKickFromChannelEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, kickerID, kickerName, kickerUniqueIdentifier, kickMessage)
	if nox.var.checkForKick == true then
		local clientIDown = ts3.getClientID(serverConnectionHandlerID)
		if oldChannelID == KickedChannelID and clientID == clientIDown then
			reJoin(serverConnectionHandlerID)
			nox.var.checkForKick = false
		end	
	end
end
function onServerUpdatedEvent(serverConnectionHandlerID)
	if nox.var.variables_Requested == "true" then
		reJoin(serverConnectionHandlerID)
		nox.var.variables_Requested = "false"
	end
end
function onConnectStatusChangeEvent(serverConnectionHandlerID, status, errorNumber)
	if status == ts3defs.ConnectStatus.STATUS_CONNECTION_ESTABLISHED then
		if nox.var.checkChannel == true then
			local ownID = ts3.getClientID(serverConnectionHandlerID)
			local ownCID = ts3.getChannelOfClient(serverConnectionHandlerID, ownID)
			if KickedChannelID ~= ownCID then
				ts3.requestClientMove(serverConnectionHandlerID, ownID, KickedChannelID, "")
				ScriptLog("[Flood] Requested Client Move.")
				KickedChannelID = nil
				KickedChannelNAME = nil
			end
			nox.var.checkChannel = false
		end
	end
end
function onClientMoveEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, moveMessage)
	if nox.func.checkForSwitch == true then
		local clientIDown = ts3.getClientID(serverConnectionHandlerID)
		if clientID == clientIDown then
			nox.setting.slowmode = false
			nox.var.bancount = 0
			nox.func.checkForSwitch = false
			local channelGroupID = ts3defs.ClientProperties.CLIENT_CHANNEL_GROUP_ID
			for i=1, #nox.setting.BanGroups do
				if nox.setting.BanGroups[i] == channelGroupID then
					setID(serverConnectionHandlerID)
				end
			end
			for i=1, #nox.setting.SpamGroups do
				if nox.setting.SpamGroups[i] == channelGroupID then
					setID(serverConnectionHandlerID)
				end
			end
		end
	end
end
antiX_events = {
	onClientChannelGroupChangedEvent = onClientChannelGroupChangedEvent,
	onServerUpdatedEvent = onServerUpdatedEvent,
	onConnectStatusChangeEvent = onConnectStatusChangeEvent,
	onClientKickFromChannelEvent = onClientKickFromChannelEvent,
	onClientMoveEvent = onClientMoveEvent
}
ScriptLog("events.lua loaded...")