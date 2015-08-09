require("channelKicker/settings")
require("channelKicker/lang")
require("channelKicker/vars")
require("channelKicker/functions")

function onUpdateClientEvent(serverConnectionHandlerID, clientID, invokerID, invokerName, invokerUniqueIdentifier)
local clientUID = ts3.getClientVariableAsString(serverConnectionHandlerID,clientID,ts3defs.ClientProperties.CLIENT_UNIQUE_IDENTIFIER)
	if ts3_triggered_antiflood == true then
		debugPrint(antifloodMSG)
		return
	elseif whitelistUIDs[clientUID] then
		return
	else
		CK_checkServer(serverConnectionHandlerID)
		if channelKicker.setting.active == true then
			clientIDown  = ts3.getClientID(serverConnectionHandlerID)
			channelIDown = ts3.getChannelOfClient(serverConnectionHandlerID, clientIDown)
			channelID = ts3.getChannelOfClient(serverConnectionHandlerID, clientID)
			if channelID == channelIDown then
				local channelGroupIDown = ts3.getClientVariableAsInt(serverConnectionHandlerID,clientIDown,33)
				if channelGroupIDown == group_ca or channelGroupIDown == group_op then
					if lastKickedFaggot ~= clientID then
						if clientDataREQUESTED == true then
							if clientDataREASON == "kick_on_bad_os" then
								if clientDataID == clientID then
									local clientOS = ts3.getClientVariableAsString(serverConnectionHandlerID,clientID,ts3defs.ClientProperties.CLIENT_PLATFORM)
									if isempty(clientOS) then
										local clientOS = ts3.getClientVariableAsString(serverConnectionHandlerID,clientID,3)
									end
									for i=1, #BadOSArray do
										if BadOSArray[i] == clientOS then
											if channelKicker.func.add_complain == true and channelKicker.func.kick_on_bad_os.add_complain == true then
												ts3.requestComplainAdd(serverConnectionHandlerID, targetClientDatabaseID, kickMSGbadOS..clientOS..kickMSGbadOS2)
											end
											if channelKicker.func.client_mute == true and channelKicker.func.kick_on_bad_os.client_mute == true then
												ts3.requestMuteClients(serverConnectionHandlerID, {clientID,0})
											end
											if channelKicker.func.add_complain == true and channelKicker.func.kick_on_bad_os.add_complain == true then
												ts3.requestComplainAdd(serverConnectionHandlerID, targetClientDatabaseID, kickMSGServerGroup)
											end
											if channelKicker.setting.channelban_active == true and channelKicker.func.kick_on_bad_os.channelban_active == true then
												ts3.sendPluginCommand(serverConnectionHandlerID, "SET_CHANNELGROUP "..group_notwelcome.." "..clientID, 2, {clientIDown,0})
											end
											if channelKicker.setting.channelkick_active == true and channelKicker.func.kick_on_bad_os.channelkick_active == true then
												ts3.requestClientKickFromChannel(serverConnectionHandlerID, clientID, kickMSGbadOS..clientOS..kickMSGbadOS2)
												if channelKicker.func.log_auto_kicks == true then
													CK_ScriptLog("Client #"..clientID.." was kicked for joining with \""..BadOSArray[i].."\" while switching from Channel "..oldChannelID.." to "..newChannelID.." visible: "..visibility.." msg: "..moveMessage)
												end
											end
											if channelKicker.setting.serverban_active == true and channelKicker.func.kick_on_bad_os.serverban_active == true then
												ts3.banclient(serverConnectionHandlerID, clientID, "-1", kickMSGbadOS..clientOS..kickMSGbadOS2)
											end
											if channelKicker.setting.serverkick_active == true and channelKicker.func.kick_on_bad_os.serverkick_active == true then
												ts3.requestClientKickFromServer(serverConnectionHandlerID, clientID, kickMSGbadOS..clientOS..kickMSGbadOS2)
											end
											lastKickedFaggot = clientID
											clientDataREQUESTED = false
											clientDataREASON = ""
											clientDataID = 0
										end
									end
								end
							elseif clientDataREASON == "kick_on_less_connects" then
								if clientDataID == clientID then
									local clientConnects = ts3.getClientVariableAsInt(serverConnectionHandlerID,clientID,37)
									if (clientConnects < client_minconnects and clientConnects > 0) then
										if channelKicker.func.client_mute == true and channelKicker.func.kick_on_less_connects.client_mute == true then
											ts3.requestMuteClients(serverConnectionHandlerID, {clientID,0})
										end
										if channelKicker.func.add_complain == true and channelKicker.func.kick_on_less_connects.add_complain == true then
											ts3.requestComplainAdd(serverConnectionHandlerID, targetClientDatabaseID, kickMSGConnects)
										end
										if channelKicker.setting.channelban_active == true and channelKicker.func.kick_on_less_connects.channelban_active == true then
											ts3.sendPluginCommand(serverConnectionHandlerID, "SET_CHANNELGROUP "..group_notwelcome.." "..clientID, 2, {clientIDown,0})
										end
										if channelKicker.setting.channelkick_active == true then
											ts3.requestClientKickFromChannel(serverConnectionHandlerID,clientID,kickMSGConnects)
											if channelKicker.func.log_auto_kicks == true then
												CK_ScriptLog("Client #"..clientID.." was kicked for joining with "..clientConnects.." connects while switching from Channel "..oldChannelID.." to "..newChannelID.." visible: "..visibility.." msg: "..moveMessage)
											end
										end
										if channelKicker.setting.serverban_active == true and channelKicker.func.kick_on_less_connects.serverban_active == true then
											ts3.banclient(serverConnectionHandlerID, clientID, "-1", kickMSGConnects)
										end
										if channelKicker.setting.serverkick_active == true and channelKicker.func.kick_on_less_connects.serverkick_active == true then
											ts3.requestClientKickFromServer(serverConnectionHandlerID, clientID, kickMSGConnects)
										end
										lastKickedFaggot = clientID
										clientDataREQUESTED = false
										clientDataREASON = ""
										clientDataID = 0
									end
								end
							end
						end
						if channelKicker.func.kick_on_recording_started.enabled == true then
							local channelGroupIDown = ts3.getClientVariableAsInt(serverConnectionHandlerID,clientIDown,33)
							if channelGroupIDown == group_ca or channelGroupIDown == group_op then
								local clientRecStatus = ts3.getClientVariableAsInt(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_IS_RECORDING)
								if clientRecStatus == 1 then
									if channelKicker.func.client_mute == true and channelKicker.func.kick_on_recording_started.client_mute == true then
										ts3.requestMuteClients(serverConnectionHandlerID, {clientID,0})
									end
									if channelKicker.func.add_complain == true and channelKicker.func.kick_on_recording_started.add_complain == true then
										ts3.requestComplainAdd(serverConnectionHandlerID, targetClientDatabaseID, kickMSGrecord)
									end
									if channelKicker.setting.channelban_active == true and channelKicker.func.kick_on_recording_started.channelban_active == true then
										ts3.sendPluginCommand(serverConnectionHandlerID, "SET_CHANNELGROUP "..group_notwelcome.." "..clientID, 2, {clientIDown,0})
									end
									if channelKicker.setting.channelkick_active == true then
										ts3.requestClientKickFromChannel(serverConnectionHandlerID,clientID,kickMSGrecord)
										if channelKicker.func.log_auto_kicks == true then
											CK_ScriptLog("Client #"..clientID.." was kicked for starting a record here")
										end
									end
									if channelKicker.setting.serverban_active == true and channelKicker.func.kick_on_recording_started.serverban_active == true then
										ts3.banclient(serverConnectionHandlerID, clientID, "-1", kickMSGrecord)
									end
									if channelKicker.setting.serverkick_active == true and channelKicker.func.kick_on_recording_started.serverkick_active == true then
										ts3.requestClientKickFromServer(serverConnectionHandlerID, clientID, kickMSGrecord)
									end
								end
							end
						end
						if channelKicker.func.send_verified_text == true then
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
										nickName, error = ts3.getClientVariableAsInt(serverConnectionHandlerID, clientID, 1)
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
										ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "[URL=client://" .. clientID .. "/" .. uniqueID .. "]" .. nickName .. "[/url], um dich zu verifizieren gib \"[color=green]/teamspeak add "..uniqueID.."[/color]\" in deinen Minecraft Chat auf GommeHD.net ein.", clientID)
										last_sended_vtext_target = clientID
									end
								end
							end
						end
						if channelKicker.func.kick_useless_clients.enabled == true then
							if lastKickedFaggot ~= clientID then
								if channelKicker.func.kick_on_output_muted.enabled == true then
									local clientOutputMuted = ts3.getClientVariableAsInt(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_OUTPUT_MUTED)
									if clientOutputMuted == 1 then
										if channelKicker.func.client_mute == true and channelKicker.func.kick_on_output_muted.client_mute == true then
											ts3.requestMuteClients(serverConnectionHandlerID, {clientID,0})
										end
										if channelKicker.func.add_complain == true and channelKicker.func.kick_on_output_muted.add_complain == true then
											ts3.requestComplainAdd(serverConnectionHandlerID, targetClientDatabaseID, kickMSGOutputMuted)
										end
										if channelKicker.setting.channelban_active == true and channelKicker.func.kick_on_output_muted.channelban_active == true then
											ts3.sendPluginCommand(serverConnectionHandlerID, "SET_CHANNELGROUP "..group_notwelcome.." "..clientID, 2, {clientIDown,0})
										end
										if channelKicker.setting.channelkick_active == true then
											ts3.requestClientKickFromChannel(serverConnectionHandlerID,clientID,kickMSGOutputMuted)
											if channelKicker.func.log_auto_kicks == true then
												CK_ScriptLog("Client #"..clientID.." was kicked for Output Muted")
											end
										end
										if channelKicker.setting.serverban_active == true and channelKicker.func.kick_on_output_muted.serverban_active == true then
											ts3.banclient(serverConnectionHandlerID, clientID, "-1", kickMSGOutputMuted)
										end
										if channelKicker.setting.serverkick_active == true and channelKicker.func.kick_on_output_muted.serverkick_active == true then
											ts3.requestClientKickFromServer(serverConnectionHandlerID, clientID, kickMSGOutputMuted)
										end
										lastKickedFaggot = clientID
									end
								end
								if channelKicker.func.kick_on_output_only_muted.enabled == true then
									local clientOutputOnlyMuted = ts3.getClientVariableAsInt(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_OUTPUTONLY_MUTED)
									if clientOutputOnlyMuted == 1 then
										if channelKicker.func.client_mute == true and channelKicker.func.kick_on_output_only_muted.client_mute == true then
											ts3.requestMuteClients(serverConnectionHandlerID, {clientID,0})
										end
										if channelKicker.func.add_complain == true and channelKicker.func.kick_on_output_only_muted.add_complain == true then
											ts3.requestComplainAdd(serverConnectionHandlerID, targetClientDatabaseID, kickMSGOutputMuted)
										end
										if channelKicker.setting.channelban_active == true and channelKicker.func.kick_on_output_only_muted.channelban_active == true then
											ts3.sendPluginCommand(serverConnectionHandlerID, "SET_CHANNELGROUP "..group_notwelcome.." "..clientID, 2, {clientIDown,0})
										end
										if channelKicker.setting.channelkick_active == true then
											ts3.requestClientKickFromChannel(serverConnectionHandlerID,clientID,kickMSGOutputMuted)
											if channelKicker.func.log_auto_kicks == true then
											CK_ScriptLog("Client #"..clientID.." was kicked for Output only Muted")
											end
										end
										if channelKicker.setting.serverban_active == true and channelKicker.func.kick_on_output_only_muted.serverban_active == true then
											ts3.banclient(serverConnectionHandlerID, clientID, "-1", kickMSGOutputMuted)
										end
										if channelKicker.setting.serverkick_active == true and channelKicker.func.kick_on_output_only_muted.serverkick_active == true then
											ts3.requestClientKickFromServer(serverConnectionHandlerID, clientID, kickMSGOutputMuted)
										end
										lastKickedFaggot = clientID
									end
								end
								if channelKicker.func.kick_on_away.enabled == true then
									local clientAway = ts3.getClientVariableAsInt(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_AWAY)
									local clientName = ts3.getClientVariableAsString(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_NICKNAME)
									if clientAway == 1 then
										local clientAwayMSG = ts3.getClientVariableAsString(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_AWAY_MESSAGE)
										if clientAwayMSG == clientAwayWhitelistMSG or clientAwayMSG == clientName then
											ts3.printMessageToCurrentTab("Client "..clientName.." #"..clientID.." is using whitelisted away message: "..clientAwayWhitelistMSG)
										else
											if channelKicker.func.client_mute == true and channelKicker.func.kick_on_output_only_muted.client_mute == true then
												ts3.requestMuteClients(serverConnectionHandlerID, {clientID,0})
											end
											if channelKicker.func.add_complain == true and channelKicker.func.kick_on_output_only_muted.add_complain == true then
												ts3.requestComplainAdd(serverConnectionHandlerID, targetClientDatabaseID, kickMSGAway)
											end
											if channelKicker.setting.channelban_active == true and channelKicker.func.kick_on_output_only_muted.channelban_active == true then
												ts3.sendPluginCommand(serverConnectionHandlerID, "SET_CHANNELGROUP "..group_notwelcome.." "..clientID, 2, {clientIDown,0})
											end
											if channelKicker.setting.channelkick_active == true then
												ts3.requestClientKickFromChannel(serverConnectionHandlerID,clientID,kickMSGAway)
												if channelKicker.func.log_auto_kicks == true then
													CK_ScriptLog("Client #"..clientID.." was kicked for Away")
												end
											end
											if channelKicker.setting.serverban_active == true and channelKicker.func.kick_on_output_only_muted.serverban_active == true then
												ts3.banclient(serverConnectionHandlerID, clientID, "-1", kickMSGAway)
											end
											if channelKicker.setting.serverkick_active == true and channelKicker.func.kick_on_output_only_muted.serverkick_active == true then
												ts3.requestClientKickFromServer(serverConnectionHandlerID, clientID, kickMSGAway)
											end
										end
									end
								end
								if channelKicker.func.kick_on_idle.enabled == true then
									local clientIdleTime = ts3.getClientVariableAsInt(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_IDLE_TIME)
									if clientIdleTime > 120 then
										if channelKicker.func.client_mute == true and channelKicker.func.kick_on_idle.client_mute == true then
											ts3.requestMuteClients(serverConnectionHandlerID, {clientID,0})
										end
										if channelKicker.func.add_complain == true and channelKicker.func.kick_on_idle.add_complain == true then
											ts3.requestComplainAdd(serverConnectionHandlerID, targetClientDatabaseID, kickMSGIdle)
										end
										if channelKicker.setting.channelban_active == true and channelKicker.func.kick_on_idle.channelban_active == true then
											ts3.sendPluginCommand(serverConnectionHandlerID, "SET_CHANNELGROUP "..group_notwelcome.." "..clientID, 2, {clientIDown,0})
										end
										if channelKicker.setting.channelkick_active == true then
											ts3.requestClientKickFromChannel(serverConnectionHandlerID,clientID,kickMSGIdle)
											if channelKicker.func.log_auto_kicks == true then
										CK_ScriptLog("Client #"..clientID.." was kicked for Idle Time Exceeded")
											end
										end
										if channelKicker.setting.serverban_active == true and channelKicker.func.kick_on_idle.serverban_active == true then
											ts3.banclient(serverConnectionHandlerID, clientID, "-1", kickMSGIdle)
										end
										if channelKicker.setting.serverkick_active == true and channelKicker.func.kick_on_idle.serverkick_active == true then
											ts3.requestClientKickFromServer(serverConnectionHandlerID, clientID, kickMSGIdle)
										end
										lastKickedFaggot = clientID
									end
								end
							end
						end
					end
				end
				-- if channelKicker.func.welcome_to_teamspeak == true then
					-- /soundboard button 97
				-- end
			end
		end
	end
end

-- channelKicker_events = {
    -- onUpdateClientEvent = onUpdateClientEvent
-- }

channelKicker.info.MODULEFOLDER = "channelKicker/events"
channelKicker.info.MODULEFILE = "onUpdateClient"
ts3.printMessageToCurrentTab("Loaded "..channelKicker.info.MODULE.." v"..channelKicker.info.MODULEVERSION.." by "..channelKicker.info.MODULEAUTHOR.." from "..ts3.getPluginPath().."lua_plugin/"..channelKicker.info.MODULEFOLDER.."/"..channelKicker.info.MODULEFILE.."."..channelKicker.info.MODULEEXT)
