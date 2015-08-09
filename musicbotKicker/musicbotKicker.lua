
-- Settings --
MBK_active = true
MBK_kick_active = true
MBK_send_infotext = true

MBK_func_auto_switch_back = true
MBK_func_kick_on_ts3server_link = true
MBK_func_kick_on_ip_adress = true
MBK_func_kick_on_freeze_code = true
MBK_func_kick_on_clear_code = true
MBK_func_kick_on_bad_name = true
	MBK_func_kick_on_default_nick = false
	MBK_func_kick_on_bad_char = true
	MBK_func_kick_on_bad_nick = true
	MBK_func_kick_on_banned_nick = true
	MBK_func_kick_on_banned_uid = true
MBK_func_kick_useless_clients = true
	MBK_func_kick_on_output_muted = true
	MBK_func_kick_on_output_only_muted = true
	MBK_func_kick_on_away = false
	MBK_func_kick_on_idle = false
MBK_func_auto_channel_commander = true
MBK_func_log_auto_kicks = true

local script_language = "german"

if script_language == "german" then
        kickMSG = "Persona non grata ("..math.random(1,99)..")"
        kickMSGConnects = "Du brauchst mehr Verbindungen!"
        kickMSGServerGroup = "Du hast eine nicht erwünschte Servergruppe!"
        kickMSGts3server = "Du darfst hier keine ts3server:// links senden!"
        kickMSGipadress = "Du darfst hier keine IP's versenden!"
        kickMSGfreeze = "Hat versucht Clients einzufrieren!!!!"
        kickMSGclear = "Hat versucht den Channelchat zu leeren!!!"
		kickMSGbadname = "Unerwuenschter Nickname!"
		kickMSGOutputMuted = "Du wurdest gekickt weil deine Lautsprecher gemuted sind."
		kickMSGAway = "Du wurdest gekickt weil du AFK bist."
		kickMSGIdle = "Du warst zu lange untätig!"
        channelMSG = "Dieser Channel nutzt das LUA MusicBot Kicker Script von Bluscream"
else
        kickMSG = "Persona non grata ("..math.random(1,99)..")"
        kickMSGdefaultChan = "Dont use default channel to join here!"
        kickMSGConnects = "You need more Connections!"
        kickMSGServerGroup = "Your Server Groups are not allowed'!"
        kickMSGts3server = "Dont send ts3server links in this Channel!"
        kickMSGipadress = "Dont send ip adresses in this Channel!"
        kickMSGfreeze = "Has attempted to freeze clients!!!!"
        kickMSGclear = "Has attempted to clear everyone's chat!!!"
		kickMSGbadname = "Bad Nickname!"
		kickMSGOutputMuted = "You were kicked for muting your speakers."
		kickMSGAway = "You were AFK to long."
		kickMSGIdle = "You were idling to long!"
        channelMSG = "\n-= I am protecting you're channel with the channelKicker Script by Chriis =-"
        channelMSG_e = "Some actions are not allowed:\nStarting to record in this channel!\nJoining this channel while recording!\nConnecting here via default channel\nSending ts3server:// links in this channel\nSending IP's in this channel!\nFreezing Clients\nClearing the Channel chat!\nJoin on the first connection!\nJoin with a blacklisted nickname!\nJoin with blocked server groups!"
end

-- ****************************************************************
clientAwayWhitelistMSG = "afk"
DefaultNickArray = { 'teamspeakuser', 'android', 'iphone' }
BadCharArray = { '&#3178;', '&#21328;', '&#21325;' }
BadNickArray = { '' }
BannedNickArray = { '' }
BannedUIDArray = { '' }
bugStringfreeze = "%[img%]//"
bugStringfreeze2 = "%[img%]\\\\"
bugStringclear = 'width="999999999'
txt_oldChannelID = 0
lastKickedFaggot = 0
last_sended_vtext_target = 0

if MBK_active == false then
	return
end

function onClientKickFromChannelEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, kickerID, kickerName, kickerUniqueIdentifier, kickMessage)
	if MBK_func_auto_switch_back == true then
        kickedownID = ts3.getClientID(serverConnectionHandlerID)
        if kickedownID == clientID then
                clientMoveReq = ts3.requestClientMove(serverConnectionHandlerID, clientID, oldChannelID, "")
        end
	end
end

function onClientChannelGroupChangedEvent(serverConnectionHandlerID, channelGroupID, channelID, clientID, invokerClientID, invokerName, invokerUniqueIdentity)
	if MBK_active == true then
		clientIDown       = ts3.getClientID(serverConnectionHandlerID)
		channelIDown      = ts3.getChannelOfClient(serverConnectionHandlerID, clientIDown)
		channelGroupIDown = ts3.getClientVariableAsInt(serverConnectionHandlerID,clientIDown,33)
		channelGroupID    = ts3.getClientVariableAsInt(serverConnectionHandlerID,clientID,33)
		if channelIDown == channelID then
			if MBK_send_infotext == true then
				if clientID == clientIDown then
					if channelGroupID == group_op then
						if txt_oldChannelID ~= channelIDown then
						-- if textSended == false then
							ts3.requestSendChannelTextMsg(serverConnectionHandlerID, channelMSG, channelIDown)
							ts3.requestSendChannelTextMsg(serverConnectionHandlerID, channelMSG_e, channelIDown)
							-- textSended = true
							txt_oldChannelID = channelIDown
							return
						end
					end
				end
			end
			if MBK_func_auto_channel_commander == true then
				if clientID == clientIDown then
					if channelID == channelIDown then
						if channelGroupIDown == group_ca then
							ts3.setClientSelfVariableAsInt(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_IS_CHANNEL_COMMANDER, 1)
							ts3.flushClientSelfUpdates(serverConnectionHandlerID)
						end
					end
				end
			end
		end
	end
end

function onClientMoveEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, moveMessage)
	if MBK_active == true then
		if lastKickedFaggot ~= clientID then
			clientIDown  = ts3.getClientID(serverConnectionHandlerID)
			channelIDown = ts3.getChannelOfClient(serverConnectionHandlerID, clientIDown)
			channelGroupIDown = ts3.getClientVariableAsInt(serverConnectionHandlerID,clientIDown,33)
			clientServerGroups = ts3.getClientVariableAsString(serverConnectionHandlerID,clientID,34)
			if newChannelID == channelIDown then
				if channelGroupIDown == group_ca or channelGroupIDown == group_op then
					if MBK_func_kick_on_bad_servergroup == true then
						for i=1, #blocked_servergroups do
							if string.find(clientServerGroups, blocked_servergroups[i]) then
								if MBK_kick_active == true then
									ts3.requestClientKickFromChannel(serverConnectionHandlerID,clientID,kickMSGServerGroup .. copy)
									if MBK_func_log_auto_kicks == true then
										CK_ScriptLog("Client #"..clientID.." was kicked for having server group "..blocked_servergroups[i].." in "..clientServerGroups.." while switching from Channel "..oldChannelID.." to "..newChannelID.." visible: "..visibility.." msg: "..moveMessage)
									end
								end
								lastKickedFaggot = clientID
							end					
						end
					end
					if MBK_func_kick_on_default_channel == true then
						if oldChannelID == 0 then
							if visibility == 0 then
								CK_ScriptLog("Ignoring Client #"..clientID.." for default channel while switching from Channel "..oldChannelID.." to "..newChannelID.." visible: "..visibility.." msg: "..moveMessage)
							else
								if MBK_kick_active == true then
									ts3.requestClientKickFromChannel(serverConnectionHandlerID,clientID,kickMSGdefaultChan .. copy)
									if MBK_func_log_auto_kicks == true then
										CK_ScriptLog("Client #"..clientID.." was kicked for using default channel while switching from Channel "..oldChannelID.." to "..newChannelID.." visible: "..visibility.." msg: "..moveMessage)
									end
								end
								-- lastKickedFaggot = clientID
							end
						end
					end
					if MBK_func_kick_on_join_recording == true then
						local clientRecStatus = ts3.getClientVariableAsInt(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_IS_RECORDING)
						if clientRecStatus == 1 then
							if MBK_kick_active == true then
								ts3.requestClientKickFromChannel(serverConnectionHandlerID, clientID, kickMSGrecord .. copy)
								if MBK_func_log_auto_kicks == true then
									CK_ScriptLog("Client #"..clientID.." was kicked for joining recording while switching from Channel "..oldChannelID.." to "..newChannelID.." visible: "..visibility.." msg: "..moveMessage)
								end
							end
							-- lastKickedFaggot = clientID
						end
					end
					if MBK_func_kick_on_bad_name == true then
						movedclientName = ts3.getClientVariableAsString(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_NICKNAME)
						local lowName = string.lower(movedclientName)
						if MBK_func_kick_on_default_nick == true then
							for i=1, #DefaultNickArray do
								if string.find(lowName, DefaultNickArray[i]) then
									if MBK_kick_active == true then
										ts3.requestClientKickFromChannel(serverConnectionHandlerID, clientID, kickMSGbadname .. copy)
										if MBK_func_log_auto_kicks == true then
											CK_ScriptLog("Client #"..clientID.." was kicked for joining with nick \""..movedclientName.."\" while switching from Channel "..oldChannelID.." to "..newChannelID.." visible: "..visibility.." msg: "..moveMessage)
										end
									end
									lastKickedFaggot = clientID
								end
							end
						end
						if MBK_func_kick_on_bad_char == true then
							for i=1, #BadCharArray do
								if string.find(lowName, BadCharArray[i]) then
									if MBK_kick_active == true then
										ts3.requestClientKickFromChannel(serverConnectionHandlerID, clientID, kickMSGbadname .. copy)
										if MBK_func_log_auto_kicks == true then
											CK_ScriptLog("Client #"..clientID.." was kicked for joining with char \""..BadCharArray[i].."\" while switching from Channel "..oldChannelID.." to "..newChannelID.." visible: "..visibility.." msg: "..moveMessage)
										end
									end
									lastKickedFaggot = clientID
								end
							end
						end
						if MBK_func_kick_on_bad_nick == true then
							for i=1, #BadNickArray do
								if string.find(lowName, BadNickArray[i]) then
									if MBK_kick_active == true then
										ts3.requestClientKickFromChannel(serverConnectionHandlerID, clientID, kickMSGbadname .. copy)
										if MBK_func_log_auto_kicks == true then
											CK_ScriptLog("Client #"..clientID.." was kicked for joining with nick \""..BadNickArray[i].."\" while switching from Channel "..oldChannelID.." to "..newChannelID.." visible: "..visibility.." msg: "..moveMessage)
										end
									end
									lastKickedFaggot = clientID
								end
							end
						end
						if MBK_func_kick_on_banned_nick == true then
							for i=1, #BannedNickArray do
								local badnicklow = string.lower(BannedNickArray[i])
								if badnicklow == lowName then
									-- ts3.sendPluginCommand(serverConnectionHandlerID, "ts3plugin.api.setChannelGroup", 4, { '28' })
									if MBK_kick_active == true then
										ts3.requestClientKickFromChannel(serverConnectionHandlerID, clientID, kickMSG .. copy)
										if MBK_func_log_auto_kicks == true then
											CK_ScriptLog("Client #"..clientID.." was kicked for joining with nick \""..BannedNickArray[i].."\" while switching from Channel "..oldChannelID.." to "..newChannelID.." visible: "..visibility.." msg: "..moveMessage)
										end
									end
									lastKickedFaggot = clientID
								end
							end
						end
						if MBK_func_kick_on_banned_uid == true then
							movedclientUID = ts3.getClientVariableAsString(serverConnectionHandlerID,clientID,ts3defs.ClientProperties.CLIENT_UNIQUE_IDENTIFIER)
							for i=1, #BannedUIDArray do
								if BannedUIDArray[i] == movedclientUID then
									-- ts3.sendPluginCommand(connectionHandlerID, pluginID, "ts3plugin.api.setChannelGroup", PluginCommandTarget_CURRENT_CHANNEL,NIL)
									if MBK_kick_active == true then
										ts3.requestClientKickFromChannel(serverConnectionHandlerID, clientID, kickMSG .. copy)
										if MBK_func_log_auto_kicks == true then
											CK_ScriptLog("Client #"..clientID.." was kicked for joining with UID \""..BannedUIDArray[i].."\" while switching from Channel "..oldChannelID.." to "..newChannelID.." visible: "..visibility.." msg: "..moveMessage)
										end
									end
									lastKickedFaggot = clientID
								end
							end
						end
					end
					if MBK_func_kick_on_less_connects == true then
						ts3.requestClientVariables(serverConnectionHandlerID, clientID)
						local clientConnects = ts3.getClientVariableAsInt(serverConnectionHandlerID,clientID,37)
						if (clientConnects < client_minconnects and clientConnects > 0) then
							if MBK_kick_active == true then
								ts3.requestClientKickFromChannel(serverConnectionHandlerID,clientID,kickMSGConnects .. copy)
							end
							if MBK_func_log_auto_kicks == true or MBK_kick_active == false then
								CK_ScriptLog("Client #"..clientID.." was kicked for joining with "..clientConnects.." connects while switching from Channel "..oldChannelID.." to "..newChannelID.." visible: "..visibility.." msg: "..moveMessage)
							end
							lastKickedFaggot = clientID
						end
					end
				end
			end
		end
		if MBK_func_auto_talk_power_request == true then
			local clientIDown = ts3.getClientID(serverConnectionHandlerID)
			if clientID == clientIDown then
				local error = ts3.setClientSelfVariableAsString(serverConnectionHandlerID, 44, tp_req_MSG .. copy)
				if error ~= ts3errors.ERROR_ok then
				ts3.printMessageToCurrentTab("Error setting CLIENT_TALK_REQUEST_MSG. Error ID: "  .. error)
				end
				local error = ts3.setClientSelfVariableAsInt(serverConnectionHandlerID, 43, 1)
				if error ~= ts3errors.ERROR_ok then
				ts3.printMessageToCurrentTab("Error setting CLIENT_TALK_REQUEST. Error ID: "  .. error)
				end
				local error = ts3.flushClientSelfUpdates(serverConnectionHandlerID)
				if error ~= ts3errors.ERROR_ok then
					ts3.printMessageToCurrentTab("Error flushing client. Error ID: "  .. error)
				end
			end
		end
	end
end

function onUpdateClientEvent(serverConnectionHandlerID, clientID)
	if MBK_active == true then
		clientIDown  = ts3.getClientID(serverConnectionHandlerID)
		channelIDown = ts3.getChannelOfClient(serverConnectionHandlerID, clientIDown)
		channelID = ts3.getChannelOfClient(serverConnectionHandlerID, clientID)
		if channelID == channelIDown then
			local channelGroupIDown = ts3.getClientVariableAsInt(serverConnectionHandlerID,clientIDown,33)
			if channelGroupIDown == group_ca or channelGroupIDown == group_op then
				ts3.requestClientVariables(serverConnectionHandlerID, clientID)
				if MBK_func_kick_on_recording_started == true then
					local channelGroupIDown = ts3.getClientVariableAsInt(serverConnectionHandlerID,clientIDown,33)
					if channelGroupIDown == group_ca or channelGroupIDown == group_op then
						local clientRecStatus = ts3.getClientVariableAsInt(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_IS_RECORDING)
						if clientRecStatus == 1 then
							if MBK_kick_active == true then
								ts3.requestClientKickFromChannel(serverConnectionHandlerID, clientID, kickMSGrecord .. copy)
										if MBK_func_log_auto_kicks == true then
											CK_ScriptLog("Client #"..clientID.." was kicked for starting a record here")
										end
							end
						end
					end
				end
				if MBK_func_send_verified_text == true then
					if last_sended_vtext_target ~= clientID then
						clientTPStatus, error = ts3.getClientVariableAsInt(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_TALK_REQUEST)
						if error ~= ts3errors.ERROR_ok then
							ts3.printMessageToCurrentTab("Error getClientVariableAsInt CLIENT_TALK_REQUEST. Error ID: "  .. error)
						end
						if clientTPStatus ~= 0 then
							clientServerGroups, error = ts3.getClientVariableAsString(serverConnectionHandlerID,clientID,34)
							if error ~= ts3errors.ERROR_ok then
								ts3.printMessageToCurrentTab("Error getClientVariableAsString CLIENT_SERVER_GROUPS. Error ID: "  .. error)
							end
							if clientServerGroups == servergroup_guest then
								ts3.printMessageToCurrentTab(clientServerGroups.." "..servergroup_guest)			
								nickName, error = ts3.getClientVariableAsString(serverConnectionHandlerID, clientID, 1)
								if error ~= ts3errors.ERROR_ok then
									ts3.printMessageToCurrentTab("Error getClientVariableAsInt CLIENT_TALK_REQUEST. Error ID: "  .. error)
								end
								uniqueID, error = ts3.getClientVariableAsString(serverConnectionHandlerID,clientID,ts3defs.ClientProperties.CLIENT_UNIQUE_IDENTIFIER)
								if error ~= ts3errors.ERROR_ok then
									ts3.printMessageToCurrentTab("Error getClientVariableAsInt CLIENT_UNIQUE_IDENTIFIER. Error ID: "  .. error)
								end
								channelIDown, error = ts3.getChannelOfClient(serverConnectionHandlerID, clientIDown)
								if error ~= ts3errors.ERROR_ok then
									ts3.printMessageToCurrentTab("Error getChannelOfClient. Error ID: "  .. error)
								end
								-- ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "Um [URL=client://" .. clientID .. "/" .. uniqueID .. "]" .. nickName .. "[/url] zu verifizieren gebe \"[color=green]/teamspeak add "..uniqueID.."[/color]\" in deinen Minecraft Chat auf GommeHD.net ein.", channelIDown)
								ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[URL=client://" .. clientID .. "/" .. uniqueID .. "]" .. nickName .. "[/url], um dich zu verifizieren gib \"[color=green]/teamspeak add "..uniqueID.."[/color]\" in deinen Minecraft Chat auf GommeHD.net ein.", clientID)
								last_sended_vtext_target = clientID
							end
						end
					end
				end
				if MBK_func_kick_useless_clients == true then
					if lastKickedFaggot ~= clientID then
						if MBK_func_kick_on_output_muted == true then
							local clientOutputMuted = ts3.getClientVariableAsInt(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_OUTPUT_MUTED)
							if clientOutputMuted == 1 then
								ts3.requestClientKickFromChannel(serverConnectionHandlerID, clientID, kickMSGOutputMuted .. copy)
								if MBK_func_log_auto_kicks == true then
									CK_ScriptLog("Client #"..clientID.." was kicked for Output Muted")
								end
									lastKickedFaggot = clientID
							end
						end
						if MBK_func_kick_on_output_only_muted == true then
							local clientOutputOnlyMuted = ts3.getClientVariableAsInt(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_OUTPUTONLY_MUTED)
							if clientOutputOnlyMuted == 1 then
								ts3.requestClientKickFromChannel(serverConnectionHandlerID, clientID, kickMSGOutputMuted .. copy)
								if MBK_func_log_auto_kicks == true then
									CK_ScriptLog("Client #"..clientID.." was kicked for Output only Muted")
								end
									lastKickedFaggot = clientID
							end
						end
						if MBK_func_kick_on_away == true then
							local clientAway = ts3.getClientVariableAsInt(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_AWAY)
							if clientAway == 1 then
								local clientAwayMSG = ts3.getClientVariableAsString(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_AWAY_MESSAGE)
								if clientAwayMSG == clientAwayWhitelistMSG then
									ts3.printMessageToCurrentTab("Client ("..clientID..") is using whitelisted away message: "..clientAwayWhitelistMSG)
								else
								ts3.requestClientKickFromChannel(serverConnectionHandlerID, clientID, kickMSGAway .. copy)
								if MBK_func_log_auto_kicks == true then
									CK_ScriptLog("Client #"..clientID.." was kicked for Away")
								end
									lastKickedFaggot = clientID
								end
							end
						end
						if MBK_func_kick_on_idle == true then
							local clientIdleTime = ts3.getClientVariableAsInt(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_IDLE_TIME)
							if clientIdleTime > 120 then
								ts3.requestClientKickFromChannel(serverConnectionHandlerID, clientID, kickMSGIdle .. copy)
								if MBK_func_log_auto_kicks == true then
									CK_ScriptLog("Client #"..clientID.." was kicked for Idle Time Exceeded")
								end
									lastKickedFaggot = clientID
							end
						end
					end
				end
			end
		end
	end
end

function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message)
	
	if MBK_active == true then
		clientIDown = ts3.getClientID(serverConnectionHandlerID)
		channelGroupIDown = ts3.getClientVariableAsInt(serverConnectionHandlerID,clientIDown,33)
		channelGroupID    = ts3.getClientVariableAsInt(serverConnectionHandlerID,clientIDown,33)
		ipchannelGroupID = ts3.getClientVariableAsInt(serverConnectionHandlerID,fromID,33)
		if channelGroupIDown == group_ca or channelGroupIDown == group_op then
			if targetMode == 2 then
				if clientIDown ~= fromID then
					targetClientDatabaseID = ts3.getClientVariableAsInt(serverConnectionHandlerID,fromID,ts3defs.ClientProperties.CLIENT_DATABASE_ID)
					if ipchannelGroupID ~= group_ca or ipchannelGroupID ~= group_op then
						local lowMessage = string.lower(message)
						if MBK_func_kick_on_freeze_code == true then
							if string.find(lowMessage, bugStringfreeze) ~= nil or string.find(lowMessage, bugStringfreeze2) ~= nil then
								ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[URL=client://" .. fromID .. "/" .. fromUniqueIdentifier .. "]" .. fromName .. " (CID=" .. fromID .. ") [UID=" .. fromUniqueIdentifier .. "][/URL] [b][color=red]" .. kickMSGfreeze .."[/color][/b]", channelIDown)
								if MBK_kick_active == true then
									ts3.requestClientKickFromChannel(serverConnectionHandlerID, fromID, kickMSGfreeze .. copy)
								end
								if MBK_func_log_auto_kicks == true then
									CK_ScriptLog("Client \""..fromName.."\" #"..fromID.." was kicked for "..kickMSGfreeze)
								end
								ts3.requestComplainAdd(serverConnectionHandlerID, targetClientDatabaseID, kickMSGfreeze)
							end
						end
						if MBK_func_kick_on_clear_code == true then
							if string.find(lowMessage, bugStringclear) ~= nil then
								ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[URL=client://" .. fromID .. "/" .. fromUniqueIdentifier .. "]" .. fromName .. " (CID=" .. fromID .. ") [UID=" .. fromUniqueIdentifier .. "][/URL] [b][color=red]" .. kickMSGclear .."[/color][/b]", channelIDown)
								if MBK_kick_active == true then
									ts3.requestClientKickFromChannel(serverConnectionHandlerID, fromID, kickMSGclear .. copy)
								end
								if MBK_func_log_auto_kicks == true then
									CK_ScriptLog("Client \""..fromName.."\" #"..fromID.." was kicked for "..kickMSGclear)
								end
								ts3.requestComplainAdd(serverConnectionHandlerID, targetClientDatabaseID, kickMSGclear)
							end
						end
						if MBK_func_kick_on_ts3server_link == true then
							if string.find (lowMessage, "ts3server:" ) ~= nil then
								if MBK_kick_active == true then
									ts3.requestClientKickFromChannel(serverConnectionHandlerID, fromID, kickMSGts3server .. copy)
								end
								if MBK_func_log_auto_kicks == true then
									CK_ScriptLog("Client \""..fromName.."\" #"..fromID.." was kicked for "..kickMSGts3server)
								end
							end
						end
						if MBK_func_kick_on_ip_adress == true then
							if string.find (lowMessage, '%d+%.%d+%.%d+%.%d') ~= nil then
								if string.find(message, '192.168') ~= nil then
										print("IP 192.168 OK")
								elseif string.find(message, '127.0.0') ~= nil then
										print("IP 127.0.0 OK")
								else
									if MBK_kick_active == true then
										ts3.requestClientKickFromChannel(serverConnectionHandlerID, fromID, kickMSGipadress .. copy)
									end
									if MBK_func_log_auto_kicks == true then
										CK_ScriptLog("Client \""..fromName.."\" #"..fromID.." was kicked for "..kickMSGipadress)
									end
								end
							end
						end
					end
					local selfID = ts3.getClientID(serverConnectionHandlerID)
					local str = string.match(message, '(m%d%d%-%d%d%d%-%d%d%d)')
					if str and fromID ~= selfID then
						ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[url=tvjoinv8://go.teamviewer.com?mid=" .. lastMeeting .. "] Join " .. fromName .. "'s meeting [/url]", channelIDown)
						return
					end
				end
			end
		end
	end
end

channelKicker_events = {

        onClientChannelGroupChangedEvent = onClientChannelGroupChangedEvent,
        onClientKickFromChannelEvent = onClientKickFromChannelEvent,
        onClientMoveEvent = onClientMoveEvent,
        onUpdateClientEvent = onUpdateClientEvent,
        onTextMessageEvent = onTextMessageEvent
        
}
