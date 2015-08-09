require("channelKicker/settings")
require("channelKicker/lang")
require("channelKicker/vars")
require("channelKicker/functions")

local function textlog(msg)
	if channelKicker.setting.textdebug == true then
		ts3.printMessageToCurrentTab(msg)
	end
end

function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
	textlog("-= START: onTextMessageEvent =-")
	local clientUID = ts3.getClientVariableAsString(serverConnectionHandlerID,fromID,ts3defs.ClientProperties.CLIENT_UNIQUE_IDENTIFIER)
		textlog("clientUID = "..clientUID)
	if ts3_triggered_antiflood == true then
		textlog("ANTIFLOOD")
		debugPrint(antifloodMSG)
		return
	elseif whitelistUIDs[clientUID] then
		textlog("WHITELISTED")
		return
	else
		textlog("ELSE")
		CK_checkServer(serverConnectionHandlerID)
		if channelKicker.setting.active == true then
			local clientIDown = ts3.getClientID(serverConnectionHandlerID)
			local channelGroupIDown = ts3.getClientVariableAsInt(serverConnectionHandlerID,clientIDown,33)
			local channelGroupID    = ts3.getClientVariableAsInt(serverConnectionHandlerID,clientIDown,33)
			local ipchannelGroupID = ts3.getClientVariableAsInt(serverConnectionHandlerID,fromID,33)
			if channelGroupIDown == group_ca or channelGroupIDown == group_op then
				textlog("channelGroupIDown == group_ca or channelGroupIDown == group_op")
				if targetMode == 2 then
					textlog("targetMode == 2")
					if clientIDown ~= fromID then
						textlog("clientIDown ~= fromID")
						targetClientDatabaseID = ts3.getClientVariableAsInt(serverConnectionHandlerID,fromID,ts3defs.ClientProperties.CLIENT_DATABASE_ID)
						if ipchannelGroupID ~= group_ca and ipchannelGroupID ~= group_op then
							textlog("ipchannelGroupID ~= group_ca and ipchannelGroupID ~= group_op")
							local lowMessage = string.lower(message)
							-- local channelID = ts3.getChannelOfClient(serverConnectionHandlerID, fromID)
							if channelKicker.func.kick_on_blocked_msg.enabled == true then
								if ffIgnored == 1 then
									if channelKicker.func.client_mute == true and channelKicker.func.kick_on_blocked_msg.client_mute == true then
										ts3.requestMuteClients(serverConnectionHandlerID, {fromID,0})
									end
									if channelKicker.func.add_complain == true and channelKicker.func.kick_on_blocked_msg.add_complain == true then
										ts3.requestComplainAdd(serverConnectionHandlerID, targetClientDatabaseID, kickMSGblocked)
									end
									if channelKicker.setting.channelban_active == true and channelKicker.func.kick_on_freeze_code.channelban_active == true then
										ts3.sendPluginCommand(serverConnectionHandlerID, "SET_CHANNELGROUP "..group_notwelcome.." "..fromID, 2, {clientIDown,0})
									end
									if channelKicker.setting.channelkick_active == true then
										ts3.requestClientKickFromChannel(serverConnectionHandlerID,fromID,kickMSGblocked)
										if channelKicker.func.log_auto_kicks == true then
											CK_ScriptLog("Client \""..fromName.."\" #"..fromID.." was kicked for "..kickMSGblocked)
										end
									end
									if channelKicker.setting.serverban_active == true and channelKicker.func.kick_on_blocked_msg.serverban_active == true then
										ts3.banclient(serverConnectionHandlerID, fromID, "-1", kickMSGblocked)
									end
									if channelKicker.setting.serverkick_active == true and channelKicker.func.kick_on_blocked_msg.serverkick_active == true then
										ts3.requestClientKickFromServer(serverConnectionHandlerID, fromID, kickMSGblocked)
									end
									lastKickedFaggot = fromID
								end
							end
							if channelKicker.func.kick_on_freeze_code.enabled == true then
								if string.find(lowMessage, bugStringfreeze) ~= nil then
									ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[URL=client://" .. fromID .. "/" .. fromUniqueIdentifier .. "]" .. fromName .. " (CID=" .. fromID .. ") [UID=" .. fromUniqueIdentifier .. "][/URL] [b][color=red]" .. kickMSGfreeze .."[/color][/b]", channelIDown)
									if channelKicker.func.client_mute == true and channelKicker.func.kick_on_freeze_code.client_mute == true then
										ts3.requestMuteClients(serverConnectionHandlerID, {fromID,0})
									end
									if channelKicker.func.add_complain == true and channelKicker.func.kick_on_freeze_code.add_complain == true then
										ts3.requestComplainAdd(serverConnectionHandlerID, targetClientDatabaseID, kickMSGfreeze)
									end
									if channelKicker.setting.channelban_active == true and channelKicker.func.kick_on_freeze_code.channelban_active == true then
										ts3.sendPluginCommand(serverConnectionHandlerID, "SET_CHANNELGROUP "..group_notwelcome.." "..fromID, 2, {clientIDown,0})
									end
									if channelKicker.setting.channelkick_active == true then
										ts3.requestClientKickFromChannel(serverConnectionHandlerID,fromID,kickMSGfreeze)
										if channelKicker.func.log_auto_kicks == true then
											CK_ScriptLog("Client \""..fromName.."\" #"..fromID.." was kicked for "..kickMSGfreeze)
										end
									end
									if channelKicker.setting.serverban_active == true and channelKicker.func.kick_on_freeze_code.serverban_active == true then
										ts3.banclient(serverConnectionHandlerID, fromID, "-1", kickMSGfreeze)
									end
									if channelKicker.setting.serverkick_active == true and channelKicker.func.kick_on_freeze_code.serverkick_active == true then
										ts3.requestClientKickFromServer(serverConnectionHandlerID, fromID, kickMSGfreeze)
									end
									lastKickedFaggot = fromID
								end
							end
							if channelKicker.func.kick_on_clear_code.enabled == true then
								if string.find(lowMessage, bugStringclear) ~= nil then
									ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[URL=client://" .. fromID .. "/" .. fromUniqueIdentifier .. "]" .. fromName .. " (CID=" .. fromID .. ") [UID=" .. fromUniqueIdentifier .. "][/URL] [b][color=red]" .. kickMSGclear .."[/color][/b]", channelIDown)
									if channelKicker.func.client_mute == true and channelKicker.func.kick_on_clear_code.client_mute == true then
										ts3.requestMuteClients(serverConnectionHandlerID, {fromID,0})
									end
									if channelKicker.func.add_complain == true and channelKicker.func.kick_on_clear_code.add_complain == true then
										ts3.requestComplainAdd(serverConnectionHandlerID, targetClientDatabaseID, kickMSGclear)
									end
									if channelKicker.setting.channelban_active == true and channelKicker.func.kick_on_clear_code.channelban_active == true then
										ts3.sendPluginCommand(serverConnectionHandlerID, "SET_CHANNELGROUP "..group_notwelcome.." "..fromID, 2, {clientIDown,0})
									end
									if channelKicker.setting.channelkick_active == true then
										ts3.requestClientKickFromChannel(serverConnectionHandlerID,fromID,kickMSGclear)
										if channelKicker.func.log_auto_kicks == true then
											CK_ScriptLog("Client \""..fromName.."\" #"..fromID.." was kicked for "..kickMSGclear)
										end
									end
									if channelKicker.setting.serverban_active == true and channelKicker.func.kick_on_clear_code.serverban_active == true then
										ts3.banclient(serverConnectionHandlerID, fromID, "-1", kickMSGclear)
									end
									if channelKicker.setting.serverkick_active == true and channelKicker.func.kick_on_clear_code.serverkick_active == true then
										ts3.requestClientKickFromServer(serverConnectionHandlerID, fromID, kickMSGclear)
									end
								end
							end
							if channelKicker.func.kick_on_ts3server_link.enabled == true then
								if string.find (lowMessage, "ts3server:" ) ~= nil then
									if channelKicker.func.client_mute == true and channelKicker.func.kick_on_ts3server_link.client_mute == true then
										ts3.requestMuteClients(serverConnectionHandlerID, {fromID,0})
									end
									if channelKicker.func.add_complain == true and channelKicker.func.kick_on_ts3server_link.add_complain == true then
										ts3.requestComplainAdd(serverConnectionHandlerID, targetClientDatabaseID, kickMSGts3server)
									end
									if channelKicker.setting.channelban_active == true and channelKicker.func.kick_on_ts3server_link.channelban_active == true then
										ts3.sendPluginCommand(serverConnectionHandlerID, "SET_CHANNELGROUP "..group_notwelcome.." "..fromID, 2, {clientIDown,0})
									end
									if channelKicker.setting.channelkick_active == true then
										ts3.requestClientKickFromChannel(serverConnectionHandlerID,fromID,kickMSGts3server)
										if channelKicker.func.log_auto_kicks == true then
											CK_ScriptLog("Client \""..fromName.."\" #"..fromID.." was kicked for "..kickMSGts3server)
										end
									end
									if channelKicker.setting.serverban_active == true and channelKicker.func.kick_on_ts3server_link.serverban_active == true then
										ts3.banclient(serverConnectionHandlerID, fromID, "-1", kickMSGts3server)
									end
									if channelKicker.setting.serverkick_active == true and channelKicker.func.kick_on_ts3server_link.serverkick_active == true then
										ts3.requestClientKickFromServer(serverConnectionHandlerID, fromID, kickMSGts3server)
									end
								end
							end
							if channelKicker.func.kick_on_ip_adress.enabled == true then
								if string.find (lowMessage, '%d+%.%d+%.%d+%.%d') ~= nil or string.find (lowMessage, '%w%w%w%w::%w%w%w%w::%w%w%w%w::%w%w%w%w') ~= nil or string.find (lowMessage, '%w%w%w%w:%w%w%w%w:%w%w%w%w:%w%w%w%w:%w%w%w%w:%w%w%w%w:%w%w%w%w:%w%w%w%w') ~= nil then
									if string.find(message, '192.168.') ~= nil then
											print("IP 192.168. OK")
									elseif string.find(message, '127.0.0.') ~= nil then
											print("IP 127.0.0. OK")
									else
										if channelKicker.func.client_mute == true and channelKicker.func.kick_on_ip_adress.client_mute == true then
											ts3.requestMuteClients(serverConnectionHandlerID, {fromID,0})
										end
										if channelKicker.func.add_complain == true and channelKicker.func.kick_on_ip_adress.add_complain == true then
											ts3.requestComplainAdd(serverConnectionHandlerID, targetClientDatabaseID, kickMSGipadress)
										end
										if channelKicker.setting.channelban_active == true and channelKicker.func.kick_on_ip_adress.channelban_active == true then
											ts3.sendPluginCommand(serverConnectionHandlerID, "SET_CHANNELGROUP "..group_notwelcome.." "..fromID, 2, {clientIDown,0})
										end
										if channelKicker.setting.channelkick_active == true then
											ts3.requestClientKickFromChannel(serverConnectionHandlerID,fromID,kickMSGipadress)
											if channelKicker.func.log_auto_kicks == true then
												CK_ScriptLog("Client \""..fromName.."\" #"..fromID.." was kicked for "..kickMSGipadress)
											end
										end
										if channelKicker.setting.serverban_active == true and channelKicker.func.kick_on_ip_adress.serverban_active == true then
											ts3.banclient(serverConnectionHandlerID, fromID, "-1", kickMSGipadress)
										end
										if channelKicker.setting.serverkick_active == true and channelKicker.func.kick_on_ip_adress.serverkick_active == true then
											ts3.requestClientKickFromServer(serverConnectionHandlerID, fromID, kickMSGipadress)
										end
									end
								end
							end
							if channelKicker.func.kick_on_bad_words.enabled == true then
								textlog("if channelKicker.func.kick_on_bad_words.enabled == true then")
								for i=1, #BadWordArray do
									if string.find(lowMessage, BadWordArray[i]) then
										textlog("if string.find(lowMessage, BadWordArray[i]) then")
										if channelKicker.func.client_mute == true and channelKicker.func.kick_on_bad_words.client_mute == true then
											ts3.requestMuteClients(serverConnectionHandlerID, {fromID,0})
										end
										if channelKicker.func.add_complain == true and channelKicker.func.kick_on_bad_words.add_complain == true then
											ts3.requestComplainAdd(serverConnectionHandlerID, targetClientDatabaseID, kickMSGBadWord)
										end
										if channelKicker.setting.channelban_active == true and channelKicker.func.kick_on_bad_words.channelban_active == true then
											ts3.sendPluginCommand(serverConnectionHandlerID, "SET_CHANNELGROUP "..group_notwelcome.." "..fromID, 2, {clientIDown,0})
										end
										if channelKicker.setting.channelkick_active == true then
											ts3.requestClientKickFromChannel(serverConnectionHandlerID,fromID,kickMSGBadWord)
											if channelKicker.func.log_auto_kicks == true then
												CK_ScriptLog("Client [URL=client://" .. fromID .. "/" .. fromUniqueIdentifier .. "]" .. fromName .. "[/url] #"..fromID.." was kicked for using bad word: "..BadWordArray[i])
											end
										end
										if channelKicker.setting.serverban_active == true and channelKicker.func.kick_on_bad_words.serverban_active == true then
											ts3.banclient(serverConnectionHandlerID, fromID, "-1", kickMSGBadWord)
										end
										if channelKicker.setting.serverkick_active == true and channelKicker.func.kick_on_bad_words.serverkick_active == true then
											ts3.requestClientKickFromServer(serverConnectionHandlerID, fromID, kickMSGBadWord)
										end
									end
								end
							end
							if channelKicker.func.kick_on_links.enabled == true then
								for i=1, #LinkArray do
									if string.find(lowMessage, LinkArray[i]) then
										if channelKicker.func.client_mute == true and channelKicker.func.kick_on_links.client_mute == true then
											ts3.requestMuteClients(serverConnectionHandlerID, {fromID,0})
										end
										if channelKicker.func.add_complain == true and channelKicker.func.kick_on_links.add_complain == true then
											ts3.requestComplainAdd(serverConnectionHandlerID, targetClientDatabaseID, kickMSGLink)
										end
										if channelKicker.setting.channelban_active == true and channelKicker.func.kick_on_links.channelban_active == true then
											ts3.sendPluginCommand(serverConnectionHandlerID, "SET_CHANNELGROUP "..group_notwelcome.." "..fromID, 2, {clientIDown,0})
										end
										if channelKicker.setting.channelkick_active == true then
											ts3.requestClientKickFromChannel(serverConnectionHandlerID,fromID,kickMSGLink)
											if channelKicker.func.log_auto_kicks == true then
												CK_ScriptLog("Client [URL=client://" .. fromID .. "/" .. fromUniqueIdentifier .. "]" .. fromName .. "[/url] #"..fromID.." was kicked for using link: "..LinkArray[i])
											end
										end
										if channelKicker.setting.serverban_active == true and channelKicker.func.kick_on_links.serverban_active == true then
											ts3.banclient(serverConnectionHandlerID, fromID, "-1", kickMSGLink)
										end
										if channelKicker.setting.serverkick_active == true and channelKicker.func.kick_on_links.serverkick_active == true then
											ts3.requestClientKickFromServer(serverConnectionHandlerID, fromID, kickMSGLink)
										end
									end
								end
							end
							if channelKicker.func.kick_on_spam.enabled == true then
								textlog("if channelKicker.func.kick_on_spam.enabled == true then")
								if message == oldMSG then
									ts3.printMessageToCurrentTab("if message == oldMSG then")
									if channelKicker.func.client_mute == true and channelKicker.func.kick_on_spam.client_mute == true then
										ts3.requestMuteClients(serverConnectionHandlerID, {fromID,0})
									end
									if channelKicker.func.add_complain == true and channelKicker.func.kick_on_spam.add_complain == true then
										ts3.requestComplainAdd(serverConnectionHandlerID, targetClientDatabaseID, kickMSGspam)
									end
									if channelKicker.setting.channelban_active == true and channelKicker.func.kick_on_spam.channelban_active == true then
										ts3.sendPluginCommand(serverConnectionHandlerID, "SET_CHANNELGROUP "..group_notwelcome.." "..fromID, 2, {clientIDown,0})
									end
									if channelKicker.setting.channelkick_active == true then
										ts3.requestClientKickFromChannel(serverConnectionHandlerID,fromID,kickMSGspam)
										if channelKicker.func.log_auto_kicks == true then
											CK_ScriptLog("Client [URL=client://" .. fromID .. "/" .. fromUniqueIdentifier .. "]" .. fromName .. "[/url] #"..fromID.." was kicked for spamming!")
										end
									end
									if channelKicker.setting.serverban_active == true and channelKicker.func.kick_on_spam.serverban_active == true then
										ts3.banclient(serverConnectionHandlerID, fromID, "-1", kickMSGspam)
									end
									if channelKicker.setting.serverkick_active == true and channelKicker.func.kick_on_spam.serverkick_active == true then
										ts3.requestClientKickFromServer(serverConnectionHandlerID, fromID, kickMSGspam)
									end
								else
									oldMSG = lowMessage
								end
							end
						end
						if channelKicker.func.inform_spoofed_link.enabled == true then
							textlog("channelKicker.func.inform_spoofed_link.enabled == true")
							-- nBeginn, nEnde = string.find("Hello Lua user", "Lua")
							-- if string.find(lowMessage, "%") ~= nil then
							local str = string.match(message, '(%[url=%]%[/url]%)')
							if str then
								textlog("string.find(lowMessage, \'%[url=%]%[/url]%\') ~= nil")
								ts3.printMessageToCurrentTab("Spoofed Link found!")
								ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "WARNUNG: Der von [URL=client://" .. fromID .. "/" .. fromUniqueIdentifier .. "]" .. fromName .. "[/url] gesendete Link fuehrt zu einer anderen als im Link angegebenen Adresse.", toID)
							end
						end
						if channelKicker.func.convert_tv_meetings.enabled == true then
							local str = string.match(message, '(m%d%d%-%d%d%d%-%d%d%d)')
							if str then
								ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[url=tvjoinv8://go.teamviewer.com?mid=" .. str .. "] Join " .. fromName .. "'s meeting [/url]", toID)
							end
						end
					end
				end
			end
		end
	end
	textlog("-= END: onTextMessageEvent =-")
end

-- channelKicker_events = {
	-- onTextMessageEvent = onTextMessageEvent
-- }

channelKicker.info.MODULEFOLDER = "channelKicker/events"
channelKicker.info.MODULEFILE = "onTextMessage"
ts3.printMessageToCurrentTab("Loaded "..channelKicker.info.MODULE.." v"..channelKicker.info.MODULEVERSION.." by "..channelKicker.info.MODULEAUTHOR.." from "..ts3.getPluginPath().."lua_plugin/"..channelKicker.info.MODULEFOLDER.."/"..channelKicker.info.MODULEFILE.."."..channelKicker.info.MODULEEXT)
