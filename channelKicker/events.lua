require("channelKicker/settings")
require("channelKicker/lang")
require("channelKicker/vars")
require("channelKicker/functions")
require("channelKicker/events/onTextMessage")
require("channelKicker/events/onClientChannelGroupChanged")
require("channelKicker/events/onClientMove")
require("channelKicker/events/onUpdateClient")
function onConnectStatusChangeEvent(serverConnectionHandlerID, status, errorNumber)
	if ts3_triggered_antiflood == true then
		debugPrint(antifloodMSG)
		return
	else
		if status == STATUS_CONNECTION_ESTABLISHED then
			clientID = ts3.getClientID(serverConnectionHandlerID)
			if channelKicker.func.autojoin_channel.enabled == true then
				local channelList = ts3.getChannelList(serverConnectionHandlerID)
				for i=1, #channelList do 
					if channelList[i] == channelKicker.func.autojoin_channel.channelName then
						clientMoveReq = ts3.requestClientMove(serverConnectionHandlerID, clientID, i, "")
						return
					end
				end
			end
			if channelKicker.func.auto_reconnect.enabled == true then
				-- ts3.requestServerVariables(serverConnectionHandlerID)
				backupserverConnectionHandlerID = serverConnectionHandlerID
				backupserverAddress = ts3.getConnectionVariableAsString(serverConnectionHandlerID, clientID, ts3defs.VirtualServerProperties.VIRTUALSERVER_IP)
				backupserverPort = ts3.getConnectionVariableAsString(serverConnectionHandlerID, clientID, ts3defs.VirtualServerProperties.VIRTUALSERVER_PORT)
				
				ts3.setClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME_PHONETIC, ( BannedNickArray[ math.random( #BannedNickArray ) ] ))
				ts3.flushClientSelfUpdates(serverConnectionHandlerID)
			end
		end
	end
end
function onClientKickFromServerEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, kickerID, kickerName, kickerUniqueIdentifier, kickMessage)
	if ts3_triggered_antiflood == true then
		debugPrint(antifloodMSG)
		return
	else
		if channelKicker.func.auto_reconnect.enabled == true then
			kickedownID = ts3.getClientID(serverConnectionHandlerID)
			if kickedownID == clientID then
				local nameArray = { 'TeamspeakUser', 'TeamSpeakUser', 'Android', 'Android_Client', 'IPhone', 'IPhone_Client' }
				local displayName = ( nameArray[ math.random( #nameArray ) ] ) .. math.random(1,9999)
				if not isempty(backupserverPort) then
					local backupadressString = backupserverAddress ..":" .. backupserverPort
				else
					local backupadressString = backupserverAddress
				end
				local serverConnectionHandlerID, error = ts3.guiConnect(1, "Anti-Kick", backupadressString, "guest", displayName, "", "", "", "", "", "", "", "", "")
				if error ~= ts3errors.ERROR_ok then
					print("Error rejoining Server: " .. error)
					return
				end
			end
		end
	end
end
function onClientKickFromChannelEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, kickerID, kickerName, kickerUniqueIdentifier, kickMessage)
	if ts3_triggered_antiflood == true then
		debugPrint(antifloodMSG)
		return
	else
		if channelKicker.func.auto_switch_back == true then
			kickedownID = ts3.getClientID(serverConnectionHandlerID)
			if kickedownID == clientID then
					clientMoveReq = ts3.requestClientMove(serverConnectionHandlerID, clientID, oldChannelID, "")
			end
		end
	end
end
function onNewChannelCreatedEvent(serverConnectionHandlerID, channelID, channelParentID, invokerID, invokerName, invokerUniqueIdentifier)
	if ts3_triggered_antiflood == true then
		debugPrint(antifloodMSG)
		return
	else
		if channelKicker.func.troll_mode == true then
			local channelPassworded = ts3.getChannelVariableAsInt(serverConnectionHandlerID, channelID, ts3defs.ChannelProperties.CHANNEL_FLAG_PASSWORD)
			if channelPassworded == 0 then
				if channelKicker.func.troll_mode_tp == true then
					local channelNeededTP = ts3.getChannelVariableAsInt(serverConnectionHandlerID, channelID, ts3defs.ChannelProperties.CHANNEL_NEEDED_TALK_POWER)
					if channelNeededTP < trollTP then
						clientID = ts3.getClientID(serverConnectionHandlerID)
						clientMoveReq = ts3.requestClientMove(serverConnectionHandlerID, clientID, channelID, "")
						randomNick(serverConnectionHandlerID)
					end
				else
					clientID = ts3.getClientID(serverConnectionHandlerID)
					clientMoveReq = ts3.requestClientMove(serverConnectionHandlerID, clientID, channelID, "")
					randomNick(serverConnectionHandlerID)
				end
			end
		end
	end
end
function onUpdateChannelEditedEvent(serverConnectionHandlerID, channelID, invokerID, invokerName, invokerUniqueIdentifier)
	if ts3_triggered_antiflood == true then
		debugPrint(antifloodMSG)
		return
	else
		if channelKicker.func.troll_mode == true then
			-- local clientID = ts3.getClientID(serverConnectionHandlerID)
			-- local myChan = ts3.getChannelOfClient(serverConnectionHandlerID, clientID)
			-- if channelID == myChan then
				local channelPassworded = ts3.getChannelVariableAsInt(serverConnectionHandlerID, channelID, ts3defs.ChannelProperties.CHANNEL_FLAG_PASSWORD)
				if channelPassworded == 0 then
					if channelKicker.func.troll_mode_tp == true then
						local channelNeededTP = ts3.getChannelVariableAsInt(serverConnectionHandlerID, channelID, ts3defs.ChannelProperties.CHANNEL_NEEDED_TALK_POWER)
						if channelNeededTP < trollTP then
							clientMoveReq = ts3.requestClientMove(serverConnectionHandlerID, clientID, channelID, "")
							randomNick(serverConnectionHandlerID)
						end
					else
						clientMoveReq = ts3.requestClientMove(serverConnectionHandlerID, clientID, channelID, "")
						randomNick(serverConnectionHandlerID)
					end
				end
			-- end
		end
	end
end
channelKicker_events = {

		onConnectStatusChangeEvent = onConnectStatusChangeEvent,
        onClientKickFromChannelEvent = onClientKickFromChannelEvent,
		onClientKickFromServerEvent = onClientKickFromServerEvent,
		onNewChannelCreatedEvent = onNewChannelCreatedEvent,
		onUpdateChannelEditedEvent = onUpdateChannelEditedEvent,
		onClientChannelGroupChangedEvent = onClientChannelGroupChangedEvent,
		onClientMoveEvent = onClientMoveEvent,
		onTextMessageEvent = onTextMessageEvent,
		onUpdateClientEvent = onUpdateClientEvent
        
}
channelKicker.info.MODULEFOLDER = "channelKicker"
channelKicker.info.MODULEFILE = "events"
ts3.printMessageToCurrentTab("Loaded "..channelKicker.info.MODULE.." v"..channelKicker.info.MODULEVERSION.." by "..channelKicker.info.MODULEAUTHOR.." from "..ts3.getPluginPath().."lua_plugin/"..channelKicker.info.MODULEFOLDER.."/"..channelKicker.info.MODULEFILE.."."..channelKicker.info.MODULEEXT)