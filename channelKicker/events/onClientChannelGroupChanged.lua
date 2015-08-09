require("channelKicker/settings")
require("channelKicker/lang")
require("channelKicker/vars")
require("channelKicker/functions")

function onClientChannelGroupChangedEvent(serverConnectionHandlerID, channelGroupID, channelID, clientID, invokerClientID, invokerName, invokerUniqueIdentity)
local clientUID = ts3.getClientVariableAsString(serverConnectionHandlerID,clientID,ts3defs.ClientProperties.CLIENT_UNIQUE_IDENTIFIER)
	if ts3_triggered_antiflood == true then
		debugPrint(antifloodMSG)
		return
	elseif whitelistUIDs[clientUID] then
		return
	else
		CK_checkServer(serverConnectionHandlerID)
		if channelKicker.setting.active == true then
			clientIDown       = ts3.getClientID(serverConnectionHandlerID)
			channelIDown      = ts3.getChannelOfClient(serverConnectionHandlerID, clientIDown)
			channelGroupIDown = ts3.getClientVariableAsInt(serverConnectionHandlerID,clientIDown,33)
			channelGroupID    = ts3.getClientVariableAsInt(serverConnectionHandlerID,clientID,33)
			-- ts3.printMessageToCurrentTab(clientID.." "..channelIDown.." "..channelGroupIDown.." "..channelGroupID.." ")
			if channelIDown == channelID then
				if channelKicker.func.kick_on_not_welcome.enabled == true then
					if channelGroupID == group_notwelcome then
						if channelGroupIDown == group_ca or channelGroupIDown == group_op then
							channelName = ts3.getChannelVariableAsString(serverConnectionHandlerID, channelID, ts3defs.ChannelProperties.CHANNEL_NAME)
							if channelKicker.setting.channelkick_active == true and channelKicker.func.kick_on_not_welcome.channelkick_active == true then
								-- invokerINIT = string.sub(invokerName,0,2)
								-- invokerINIT = string.upper( invokerINIT )
								if invokerClientID == clientIDown then
									kickMSG = "Du wurdest permanent vom Channel gebannt!"
								else
									kickMSG = invokerName .. " hat dich permanent vom Channel gebannt!"
								end
								-- ID: <".. invokerINIT ..( IDArray[ math.random( #IDArray ) ] )..( IDArray[ math.random( #IDArray ) ] )..( IDArray[ math.random( #IDArray ) ] )..( IDArray[ math.random( #IDArray ) ] )..( IDArray[ math.random( #IDArray ) ] )..( IDArray[ math.random( #IDArray ) ] )
								ts3.requestClientKickFromChannel(serverConnectionHandlerID,clientID,kickMSG)
							end
							if channelKicker.setting.log_not_welcome_kicks == true then
								nickName = ts3.getClientVariableAsString(serverConnectionHandlerID, clientID, 1)
								nickNameEncoded = urlencode(nickName)
								invokerNameEncoded = urlencode(invokerName)
								-- dataBaseID = ts3.getClientVariableAsString(serverConnectionHandlerID, clientID, 32)
								uniqueID = ts3.getClientVariableAsString(serverConnectionHandlerID,clientID,ts3defs.ClientProperties.CLIENT_UNIQUE_IDENTIFIER)
								clientTYPE = ts3.getClientVariableAsUInt64(serverConnectionHandlerID,clientID,ts3defs.ClientProperties.CLIENT_TYPE)
								-- if clientTYPE == "0"
										-- clientTYPE = "CLIENT"
								-- elseif clientTYPE == "1"
										-- clientTYPE = "QUERY"
								-- else
										-- clientTYPE = "UNKNOWN"
								-- end
								dateNow = os.date("%d.%m.%Y")
								timeNow = os.date("%H:%M:%S")
								datei   = io.open("xKickedUser.csv", "r")
								dateia  = io.open("xKickedUser.csv", "a")
								-- for line in datei:lines() do
									-- stringgSub = string.gsub(line,nickName,"X")
									-- stringgSub1 = string.gsub(line,uniqueID,"X")
									-- stringgSub2 = string.gsub(line,clientTYPE,"X")
									-- stringgSub3 = string.gsub(line,dataBaseID,"X")
									-- if stringgSub ~= line or stringgSub1 ~= line or stringgSub2 ~= line then
											-- ts3.printMessageToCurrentTab(nickName .." | ".. line)
									-- end
								-- end
								if channelKicker.setting.msg_instead_of_log == true then
									if invokerClientID == clientIDown then
										ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=red]hat [URL=client://" .. clientID .. "/" .. uniqueID .. "~" .. nickNameEncoded .. "]\"" .. nickName .. "\"[/url] permanent aus dem [URL=channelid://" .. channelID .. "]Channel[/url] gebannt![/color]", channelIDown)
									else
										ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[color=red][URL=client://" .. clientID .. "/" .. uniqueID .. "~" .. nickNameEncoded .. "]\"" .. nickName .. "\"[/url] wurde von [URL=client://" .. invokerClientID .. "/" .. invokerUniqueIdentity .. "~" .. invokerNameEncoded .. "]\"" .. invokerName .. "\"[/url] permanent aus dem [URL=channelid://" .. channelID .. "]Channel[/url] gebannt![/color]", channelIDown)
									end 
								else
									CK_ScriptLog("[URL=client://" .. clientID .. "/" .. uniqueID .. "~" .. nickNameEncoded .. "]" .. nickName .. "[/url] wurde von [URL=client://" .. invokerClientID .. "/" .. invokerUniqueIdentity .. "~" .. invokerNameEncoded .. "]" .. invokerName .. "[/url] permanent aus dem Channel [URL=channelid://" .. channelID .. "]" .. channelName .. "[/url] gebannt!")
								end
								dateia:write(dateNow .. ";" .. timeNow .. ";" .. clientTYPE .. ";" .. nickName .. ";" .. uniqueID .. "\n")--;" .. dataBaseID .. "
								dateia:close()
								datei:close()
							end
						end
					end
				end
				if channelKicker.setting.ck_send_infotext == true then
					if clientID == clientIDown then
						if channelGroupID == group_op then
							-- ts3.printMessageToCurrentTab("onClientChannelGroupChangedEvent: #" .. invokerClientID .. " \"" .. invokerName .. "\"")
							if invokerClientID ~= 0 and invokerName ~= "Server" then
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
				end
				if channelKicker.func.auto_channel_commander == true then
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
end

-- channelKicker_events = {
	-- onClientChannelGroupChangedEvent = onClientChannelGroupChangedEvent
-- }

channelKicker.info.MODULEFOLDER = "channelKicker/events"
channelKicker.info.MODULEFILE = "onClientChannelGroupChanged"
ts3.printMessageToCurrentTab("Loaded "..channelKicker.info.MODULE.." v"..channelKicker.info.MODULEVERSION.." by "..channelKicker.info.MODULEAUTHOR.." from "..ts3.getPluginPath().."lua_plugin/"..channelKicker.info.MODULEFOLDER.."/"..channelKicker.info.MODULEFILE.."."..channelKicker.info.MODULEEXT)