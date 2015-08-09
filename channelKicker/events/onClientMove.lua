require("channelKicker/settings")
require("channelKicker/lang")
require("channelKicker/vars")
require("channelKicker/functions")

function onClientMoveEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, moveMessage)
local clientUID = ts3.getClientVariableAsString(serverConnectionHandlerID,clientID,ts3defs.ClientProperties.CLIENT_UNIQUE_IDENTIFIER)
	if ts3_triggered_antiflood == true then
		debugPrint(antifloodMSG)
		return
	elseif whitelistUIDs[clientUID] then
		return
	else
		CK_checkServer(serverConnectionHandlerID)
		if channelKicker.setting.active == true then
				local clientIDown  = ts3.getClientID(serverConnectionHandlerID)
				local channelIDown = ts3.getChannelOfClient(serverConnectionHandlerID, clientIDown)
				local channelGroupIDown = ts3.getClientVariableAsInt(serverConnectionHandlerID,clientIDown,33)
				if newChannelID == channelIDown then
					if channelGroupIDown == group_ca or channelGroupIDown == group_op then
						if lastKickedFaggot ~= clientID then
							if channelKicker.func.kick_on_bad_servergroup.enabled == true then
								clientServerGroups = ts3.getClientVariableAsString(serverConnectionHandlerID,clientID,34)
								for i=1, #blocked_servergroups do
									if string.find(clientServerGroups, blocked_servergroups[i]) then
										if channelKicker.func.client_mute == true and channelKicker.func.kick_on_bad_servergroup.client_mute == true then
											ts3.requestMuteClients(serverConnectionHandlerID, {clientID,0})
										end
										if channelKicker.func.add_complain == true and channelKicker.func.kick_on_bad_servergroup.add_complain == true then
											ts3.requestComplainAdd(serverConnectionHandlerID, targetClientDatabaseID, kickMSGServerGroup)
										end
										if channelKicker.setting.channelban_active == true and channelKicker.func.kick_on_bad_servergroup.channelban_active == true then
											ts3.sendPluginCommand(serverConnectionHandlerID, "SET_CHANNELGROUP "..group_notwelcome.." "..clientID, 2, {clientIDown,0})
										end
										if channelKicker.setting.channelkick_active == true and channelKicker.func.kick_on_bad_servergroup.channelkick_active == true then
											ts3.requestClientKickFromChannel(serverConnectionHandlerID,clientID,kickMSGServerGroup)
											if channelKicker.func.log_auto_kicks == true then
												CK_ScriptLog("Client #"..clientID.." was kicked for having server group "..blocked_servergroups[i].." in "..clientServerGroups.." while switching from Channel "..oldChannelID.." to "..newChannelID.." visible: "..visibility.." msg: "..moveMessage)
											end
										end
										if channelKicker.setting.serverban_active == true and channelKicker.func.kick_on_bad_servergroup.serverban_active == true then
											ts3.banclient(serverConnectionHandlerID, clientID, "-1", kickMSGServerGroup)
										end
										if channelKicker.setting.serverkick_active == true and channelKicker.func.kick_on_bad_servergroup.serverkick_active == true then
											ts3.requestClientKickFromServer(serverConnectionHandlerID, clientID, kickMSGServerGroup)
										end
										lastKickedFaggot = clientID
									end					
								end
							end
							if channelKicker.func.kick_on_bad_os.enabled == true then
								clientDataREQUESTED = true
								clientDataREASON = "kick_on_bad_os"
								clientDataID = clientID
								ts3.requestClientVariables(serverConnectionHandlerID, clientID)
							end
							if channelKicker.func.kick_on_bad_country.enabled == true then
								local clientCOUNTRY = ts3.getClientVariableAsString(serverConnectionHandlerID,clientID,ts3defs.ClientProperties.CLIENT_COUNTRY)
								for i=1, #BadCountryArray do
									if BadCountryArray[i] == clientCOUNTRY then
										if channelKicker.func.client_mute == true and channelKicker.func.kick_on_bad_country.client_mute == true then
											ts3.requestMuteClients(serverConnectionHandlerID, {clientID,0})
										end
										if channelKicker.func.add_complain == true and channelKicker.func.kick_on_bad_country.add_complain == true then
											ts3.requestComplainAdd(serverConnectionHandlerID, targetClientDatabaseID, kickMSGbadCountry..clientCOUNTRY..kickMSGbadCountry2)
										end
										if channelKicker.setting.channelban_active == true and channelKicker.func.kick_on_bad_country.channelban_active == true then
											ts3.sendPluginCommand(serverConnectionHandlerID, "SET_CHANNELGROUP "..group_notwelcome.." "..clientID, 2, {clientIDown,0})
										end
										if channelKicker.setting.channelkick_active == true and channelKicker.func.kick_on_bad_country.channelkick_active == true then
											ts3.requestClientKickFromChannel(serverConnectionHandlerID, clientID, kickMSGbadCountry..clientCOUNTRY..kickMSGbadCountry2)
											if channelKicker.func.log_auto_kicks == true then
												CK_ScriptLog("Client #"..clientID.." was kicked for joining from \""..BadCountryArray[i].."\" while switching from Channel "..oldChannelID.." to "..newChannelID.." visible: "..visibility.." msg: "..moveMessage)
											end
										end
										if channelKicker.setting.serverban_active == true and channelKicker.func.kick_on_bad_country.serverban_active == true then
											ts3.banclient(serverConnectionHandlerID, clientID, "-1", kickMSGbadCountry..clientCOUNTRY..kickMSGbadCountry2)
										end
										if channelKicker.setting.serverkick_active == true and channelKicker.func.kick_on_bad_country.serverkick_active == true then
											ts3.requestClientKickFromServer(serverConnectionHandlerID, clientID, kickMSGbadCountry..clientCOUNTRY..kickMSGbadCountry2)
										end
										lastKickedFaggot = clientID
									end
								end
							end
							if channelKicker.func.kick_on_default_channel.enabled == true then
								if oldChannelID == 0 then
									if channelKicker.func.kick_on_default_channel.visibility_check == true then
										if visibility == 0 then
											CK_ScriptLog("Ignoring Client #"..clientID.." for default channel while switching from Channel "..oldChannelID.." to "..newChannelID.." visible: "..visibility.." msg: "..moveMessage)
										else
											if channelKicker.func.client_mute == true and channelKicker.func.kick_on_default_channel.client_mute == true then
												ts3.requestMuteClients(serverConnectionHandlerID, {clientID,0})
											end
											if channelKicker.func.add_complain == true and channelKicker.func.kick_on_default_channel.add_complain == true then
												ts3.requestComplainAdd(serverConnectionHandlerID, targetClientDatabaseID, kickMSGdefaultChan)
											end
											if channelKicker.setting.channelban_active == true and channelKicker.func.kick_on_default_channel.channelban_active == true then
												ts3.sendPluginCommand(serverConnectionHandlerID, "SET_CHANNELGROUP "..group_notwelcome.." "..clientID, 2, {clientIDown,0})
											end
											if channelKicker.setting.channelkick_active == true then
												ts3.requestClientKickFromChannel(serverConnectionHandlerID,clientID,kickMSGdefaultChan)
												if channelKicker.func.log_auto_kicks == true then
													CK_ScriptLog("Client #"..clientID.." was kicked for using default channel while switching from Channel "..oldChannelID.." to "..newChannelID.." visible: "..visibility.." msg: "..moveMessage)
												end
											end
											if channelKicker.setting.serverban_active == true and channelKicker.func.kick_on_default_channel.serverban_active == true then
												ts3.banclient(serverConnectionHandlerID, clientID, "-1", kickMSGdefaultChan)
											end
											if channelKicker.setting.serverkick_active == true and channelKicker.func.kick_on_default_channel.serverkick_active == true then
												ts3.requestClientKickFromServer(serverConnectionHandlerID, clientID, kickMSGdefaultChan)
											end
											lastKickedFaggot = clientID
										end
									else
										if channelKicker.func.client_mute == true and channelKicker.func.kick_on_default_channel.client_mute == true then
											ts3.requestMuteClients(serverConnectionHandlerID, {clientID,0})
										end
										if channelKicker.func.add_complain == true and channelKicker.func.kick_on_default_channel.add_complain == true then
											ts3.requestComplainAdd(serverConnectionHandlerID, targetClientDatabaseID, kickMSGdefaultChan)
										end
										if channelKicker.setting.channelban_active == true and channelKicker.func.kick_on_default_channel.channelban_active == true then
											ts3.sendPluginCommand(serverConnectionHandlerID, "SET_CHANNELGROUP "..group_notwelcome.." "..clientID, 2, {clientIDown,0})
										end
										if channelKicker.setting.channelkick_active == true then
											ts3.requestClientKickFromChannel(serverConnectionHandlerID,clientID,kickMSGdefaultChan)
											if channelKicker.func.log_auto_kicks == true then
												CK_ScriptLog("Client #"..clientID.." was kicked for using default channel while switching from Channel "..oldChannelID.." to "..newChannelID.." visible: "..visibility.." msg: "..moveMessage)
											end
										end
										if channelKicker.setting.serverban_active == true and channelKicker.func.kick_on_default_channel.serverban_active == true then
											ts3.banclient(serverConnectionHandlerID, clientID, "-1", kickMSGdefaultChan)
										end
										if channelKicker.setting.serverkick_active == true and channelKicker.func.kick_on_default_channel.serverkick_active == true then
											ts3.requestClientKickFromServer(serverConnectionHandlerID, clientID, kickMSGdefaultChan)
										end
									end
								end
							end
							if channelKicker.func.kick_on_join_recording.enabled == true then
								local clientRecStatus = ts3.getClientVariableAsInt(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_IS_RECORDING)
								if clientRecStatus == 1 then
									if channelKicker.func.client_mute == true and channelKicker.func.kick_on_join_recording.client_mute == true then
										ts3.requestMuteClients(serverConnectionHandlerID, {clientID,0})
									end
									if channelKicker.func.add_complain == true and channelKicker.func.kick_on_join_recording.add_complain == true then
										ts3.requestComplainAdd(serverConnectionHandlerID, targetClientDatabaseID, kickMSGrecord)
									end
									if channelKicker.setting.channelban_active == true and channelKicker.func.kick_on_join_recording.channelban_active == true then
										ts3.sendPluginCommand(serverConnectionHandlerID, "SET_CHANNELGROUP "..group_notwelcome.." "..clientID, 2, {clientIDown,0})
									end
									if channelKicker.setting.channelkick_active == true then
										ts3.requestClientKickFromChannel(serverConnectionHandlerID,clientID,kickMSGrecord)
										if channelKicker.func.log_auto_kicks == true then
											CK_ScriptLog("Client #"..clientID.." was kicked for joining recording while switching from Channel "..oldChannelID.." to "..newChannelID.." visible: "..visibility.." msg: "..moveMessage)
										end
									end
									if channelKicker.setting.serverban_active == true and channelKicker.func.kick_on_join_recording.serverban_active == true then
										ts3.banclient(serverConnectionHandlerID, clientID, "-1", kickMSGrecord)
									end
									if channelKicker.setting.serverkick_active == true and channelKicker.func.kick_on_join_recording.serverkick_active == true then
										ts3.requestClientKickFromServer(serverConnectionHandlerID, clientID, kickMSGrecord)
									end
									-- lastKickedFaggot = clientID
								end
							end
							if channelKicker.func.kick_on_bad_name.enabled == true then
								movedclientName = ts3.getClientVariableAsString(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_NICKNAME)
								movedclientPhoneticName = ts3.getClientVariableAsString(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_NICKNAME_PHONETIC)
								local lowName = string.lower(movedclientName)
								local lowPhoneticName = string.lower(movedclientPhoneticName)
								if channelKicker.func.kick_on_default_nick.enabled == true then
									for i=1, #DefaultNickArray do
										if string.find(lowName, DefaultNickArray[i]) then
											if channelKicker.func.client_mute == true and channelKicker.func.kick_on_default_nick.client_mute == true then
												ts3.requestMuteClients(serverConnectionHandlerID, {clientID,0})
											end
											if channelKicker.func.add_complain == true and channelKicker.func.kick_on_default_nick.add_complain == true then
												ts3.requestComplainAdd(serverConnectionHandlerID, targetClientDatabaseID, kickMSGbadname)
											end
											if channelKicker.setting.channelban_active == true and channelKicker.func.kick_on_default_nick.channelban_active == true then
												ts3.sendPluginCommand(serverConnectionHandlerID, "SET_CHANNELGROUP "..group_notwelcome.." "..clientID, 2, {clientIDown,0})
											end
											if channelKicker.setting.channelkick_active == true then
												ts3.requestClientKickFromChannel(serverConnectionHandlerID,clientID,kickMSGbadname)
												if channelKicker.func.log_auto_kicks == true then
													CK_ScriptLog("Client #"..clientID.." was kicked for joining with nick \""..movedclientName.."\" while switching from Channel "..oldChannelID.." to "..newChannelID.." visible: "..visibility.." msg: "..moveMessage)
												end
											end
											if channelKicker.setting.serverban_active == true and channelKicker.func.kick_on_default_nick.serverban_active == true then
												ts3.banclient(serverConnectionHandlerID, clientID, "-1", kickMSGbadname)
											end
											if channelKicker.setting.serverkick_active == true and channelKicker.func.kick_on_default_nick.serverkick_active == true then
												ts3.requestClientKickFromServer(serverConnectionHandlerID, clientID, kickMSGbadname)
											end											
											lastKickedFaggot = clientID
										end
									end
								end
								if channelKicker.func.kick_on_bad_char.enabled == true then
									for i=1, #BadCharArray do
										if string.find(lowName, BadCharArray[i]) then
											if channelKicker.func.client_mute == true and channelKicker.func.kick_on_bad_char.client_mute == true then
												ts3.requestMuteClients(serverConnectionHandlerID, {clientID,0})
											end
											if channelKicker.func.add_complain == true and channelKicker.func.kick_on_bad_char.add_complain == true then
												ts3.requestComplainAdd(serverConnectionHandlerID, targetClientDatabaseID, kickMSGbadname)
											end
											if channelKicker.setting.channelban_active == true and channelKicker.func.kick_on_bad_char.channelban_active == true then
												ts3.sendPluginCommand(serverConnectionHandlerID, "SET_CHANNELGROUP "..group_notwelcome.." "..clientID, 2, {clientIDown,0})
											end
											if channelKicker.setting.channelkick_active == true then
												ts3.requestClientKickFromChannel(serverConnectionHandlerID,clientID,kickMSGbadname)
												if channelKicker.func.log_auto_kicks == true then
													CK_ScriptLog("Client #"..clientID.." was kicked for joining with char \""..BadCharArray[i].."\" while switching from Channel "..oldChannelID.." to "..newChannelID.." visible: "..visibility.." msg: "..moveMessage)
												end
											end
											if channelKicker.setting.serverban_active == true and channelKicker.func.kick_on_bad_char.serverban_active == true then
												ts3.banclient(serverConnectionHandlerID, clientID, "-1", kickMSGbadname)
											end
											if channelKicker.setting.serverkick_active == true and channelKicker.func.kick_on_bad_char.serverkick_active == true then
												ts3.requestClientKickFromServer(serverConnectionHandlerID, clientID, kickMSGbadname)
											end	
											lastKickedFaggot = clientID
										end
									end
								end
								if channelKicker.func.kick_on_bad_nick.enabled == true then
									for i=1, #BadNickArray do
										if string.find(lowName, BadNickArray[i]) then
											if channelKicker.func.client_mute == true and channelKicker.func.kick_on_bad_nick.client_mute == true then
												ts3.requestMuteClients(serverConnectionHandlerID, {clientID,0})
											end
											if channelKicker.func.add_complain == true and channelKicker.func.kick_on_bad_nick.add_complain == true then
												ts3.requestComplainAdd(serverConnectionHandlerID, targetClientDatabaseID, kickMSGbadname)
											end
											if channelKicker.setting.channelban_active == true and channelKicker.func.kick_on_bad_nick.channelban_active == true then
												ts3.sendPluginCommand(serverConnectionHandlerID, "SET_CHANNELGROUP "..group_notwelcome.." "..clientID, 2, {clientIDown,0})
											end
											if channelKicker.setting.channelkick_active == true then
												ts3.requestClientKickFromChannel(serverConnectionHandlerID,clientID,kickMSGbadname)
												if channelKicker.func.log_auto_kicks == true then
													CK_ScriptLog("Client #"..clientID.." was kicked for joining with nick \""..BadNickArray[i].."\" while switching from Channel "..oldChannelID.." to "..newChannelID.." visible: "..visibility.." msg: "..moveMessage)
												end
											end
											if channelKicker.setting.serverban_active == true and channelKicker.func.kick_on_bad_nick.serverban_active == true then
												ts3.banclient(serverConnectionHandlerID, clientID, "-1", kickMSGbadname)
											end
											if channelKicker.setting.serverkick_active == true and channelKicker.func.kick_on_bad_nick.serverkick_active == true then
												ts3.requestClientKickFromServer(serverConnectionHandlerID, clientID, kickMSGbadname)
											end
											lastKickedFaggot = clientID
										end
									end
								end
							if channelKicker.func.kick_on_less_connects.enabled == true then
								clientDataREQUESTED = true
								clientDataREASON = "kick_on_less_connects"
								clientDataID = clientID
								ts3.requestClientVariables(serverConnectionHandlerID, clientID)
							end
							if channelKicker.func.kick_on_banned_nick.enabled == true then
								for i=1, #BannedNickArray do
									if BannedNickArray[i] == movedclientName or BannedNickArray[i] == movedclientPhoneticName then
										if channelKicker.func.client_mute == true and channelKicker.func.kick_on_banned_nick.client_mute == true then
											ts3.requestMuteClients(serverConnectionHandlerID, {clientID,0})
										end
										if channelKicker.func.add_complain == true and channelKicker.func.kick_on_banned_nick.add_complain == true then
											ts3.requestComplainAdd(serverConnectionHandlerID, targetClientDatabaseID, kickMSGFag)
										end
										if channelKicker.setting.channelban_active == true and channelKicker.func.kick_on_banned_nick.channelban_active == true then
											ts3.sendPluginCommand(serverConnectionHandlerID, "SET_CHANNELGROUP "..group_notwelcome.." "..clientID, 2, {clientIDown,0})
										end
										if channelKicker.setting.channelkick_active == true then
											ts3.requestClientKickFromChannel(serverConnectionHandlerID,clientID,kickMSGFag)
											if channelKicker.func.log_auto_kicks == true then
													CK_ScriptLog("Client #"..clientID.." was kicked for joining with nick \""..BannedNickArray[i].."\" while switching from Channel "..oldChannelID.." to "..newChannelID.." visible: "..visibility.." msg: "..moveMessage)
											end
										end
										if channelKicker.setting.serverban_active == true and channelKicker.func.kick_on_banned_nick.serverban_active == true then
											ts3.banclient(serverConnectionHandlerID, clientID, "-1", kickMSGFag)
										end
										if channelKicker.setting.serverkick_active == true and channelKicker.func.kick_on_banned_nick.serverkick_active == true then
											ts3.requestClientKickFromServer(serverConnectionHandlerID, clientID, kickMSGFag)
										end
										lastKickedFaggot = clientID
									end
								end
							end
							if channelKicker.func.kick_on_banned_uid.enabled == true then
								movedclientUID = ts3.getClientVariableAsString(serverConnectionHandlerID,clientID,ts3defs.ClientProperties.CLIENT_UNIQUE_IDENTIFIER)
								for i=1, #BannedUIDArray do
									if BannedUIDArray[i] == movedclientUID then
										if channelKicker.func.client_mute == true and channelKicker.func.kick_on_banned_uid.client_mute == true then
											ts3.requestMuteClients(serverConnectionHandlerID, {clientID,0})
										end
										if channelKicker.func.add_complain == true and channelKicker.func.kick_on_banned_uid.add_complain == true then
											ts3.requestComplainAdd(serverConnectionHandlerID, targetClientDatabaseID, kickMSGFag)
										end
										if channelKicker.setting.channelban_active == true and channelKicker.func.kick_on_banned_uid.channelban_active == true then
											ts3.sendPluginCommand(serverConnectionHandlerID, "SET_CHANNELGROUP "..group_notwelcome.." "..clientID, 2, {clientIDown,0})
										end
										if channelKicker.setting.channelkick_active == true then
											ts3.requestClientKickFromChannel(serverConnectionHandlerID,clientID,kickMSGFag)
											if channelKicker.func.log_auto_kicks == true then
													CK_ScriptLog("Client #"..clientID.." was kicked for joining with UID \""..BannedUIDArray[i].."\" while switching from Channel "..oldChannelID.." to "..newChannelID.." visible: "..visibility.." msg: "..moveMessage)
											end
										end
										if channelKicker.setting.serverban_active == true and channelKicker.func.kick_on_banned_uid.serverban_active == true then
											ts3.banclient(serverConnectionHandlerID, clientID, "-1", kickMSGFag)
										end
										if channelKicker.setting.serverkick_active == true and channelKicker.func.kick_on_banned_uid.serverkick_active == true then
											ts3.requestClientKickFromServer(serverConnectionHandlerID, clientID, kickMSGFag)
										end
										lastKickedFaggot = clientID
									end
								end
							end
						end
					end
				end
			end
			if channelKicker.func.auto_talk_power_request == true then
				local clientIDown = ts3.getClientID(serverConnectionHandlerID)
				if clientID == clientIDown then
					local error = ts3.setClientSelfVariableAsString(serverConnectionHandlerID, 44, tp_req_MSG)
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
end

-- channelKicker_events = {
    -- onClientMoveEvent = onClientMoveEvent
-- }

channelKicker.info.MODULEFOLDER = "channelKicker/events"
channelKicker.info.MODULEFILE = "onClientMove"
ts3.printMessageToCurrentTab("Loaded "..channelKicker.info.MODULE.." v"..channelKicker.info.MODULEVERSION.." by "..channelKicker.info.MODULEAUTHOR.." from "..ts3.getPluginPath().."lua_plugin/"..channelKicker.info.MODULEFOLDER.."/"..channelKicker.info.MODULEFILE.."."..channelKicker.info.MODULEEXT)
