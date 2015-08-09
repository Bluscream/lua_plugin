require("channelKicker/settings")
require("channelKicker/lang")
require("channelKicker/vars")
function CK_checkServer(serverConnectionHandlerID)
	local serverUID = ts3.getServerVariableAsString(serverConnectionHandlerID, ts3defs.VirtualServerProperties.VIRTUALSERVER_UNIQUE_IDENTIFIER, result); 
	local welcomeMessage = ts3.getServerVariableAsString(serverConnectionHandlerID, 2);
	if serverUID == UID_mtG then
		channelKickerACTIVE = true
		group_ca = 5
		group_op = 6
		group_notwelcome = 16
		client_minconnects = 2
		servergroup_guest = 8
		blocked_servergroups = { '21' }
		channelKicker.setting.send_verified_text = false
		channelKicker.setting.auto_channel_commander = true
		channelKicker.func.kick_on_default_channel.enabled = true
		return
	elseif serverUID == UID_gomme then
		channelKickerACTIVE = true
		group_ca = 9
		group_op = 10
		group_notwelcome = 12
		client_minconnects = 2
		servergroup_guest = 10
		blocked_servergroups = { '32' }
		channelKicker.setting.send_verified_text = true
		channelKicker.setting.auto_channel_commander = false
		channelKicker.func.kick_on_default_channel.enabled = false
		-- if channelKicker.setting.language == "german" then
			-- kickMSG = "Du wurdest permanent vom Channel gebannt! ID: <BL"..( IDArray[ math.random( #IDArray ) ] )..( IDArray[ math.random( #IDArray ) ] )..( IDArray[ math.random( #IDArray ) ] )..( IDArray[ math.random( #IDArray ) ] )..( IDArray[ math.random( #IDArray ) ] )..( IDArray[ math.random( #IDArray ) ] )
		-- end
		return
	elseif serverUID == UID_ts3live then
		channelKickerACTIVE = true
		group_ca = 9
		group_op = 10
		group_notwelcome = 13
		client_minconnects = 2
		servergroup_guest = 10
		blocked_servergroups = { '20' }
		channelKicker.setting.send_verified_text = false
		channelKicker.setting.auto_channel_commander = true
		channelKicker.func.kick_on_default_channel.enabled = true
		return
	elseif serverUID == UID_gronkh then
		channelKickerACTIVE = true
		group_ca = 941285
		group_op = 941286
		group_notwelcome = nil
		client_minconnects = 2
		servergroup_guest = 1413973
		blocked_servergroups = { '1416810', '1414120' }
		channelKicker.setting.send_verified_text = false
		channelKicker.setting.auto_channel_commander = true
		channelKicker.func.kick_on_default_channel.enabled = true
		return
	elseif serverUID == UID_logi then
		channelKickerACTIVE = true
		group_ca = 57
		group_op = 59
		group_notwelcome = 60
		client_minconnects = 2
		servergroup_guest = 290
		blocked_servergroups = { '' }
		channelKicker.setting.send_verified_text = false
		channelKicker.setting.auto_channel_commander = true
		channelKicker.func.kick_on_default_channel.enabled = true
		return
	else
		channelKickerACTIVE = false
		return
    end
end
function tprint(s)
	ts3.printMessageToCurrentTab(s)
end
function vcheck(s)
	if s == true then
		ts3.printMessageToCurrentTab("TRUE")
	elseif s == false then
		ts3.printMessageToCurrentTab("FALSE")
	elseif s == '' then
		ts3.printMessageToCurrentTab("EMPTY")
	elseif s == nil then
		ts3.printMessageToCurrentTab("NIL")
	else
		ts3.printMessageToCurrentTab("ELSE")
	end
end
function isempty(s)
  return s == nil or s == ''
end
function urlencode(str)
   if (str) then
      str = string.gsub (str, "\n", "\r\n")
      str = string.gsub (str, "([^%w ])",
         function (c) return string.format ("%%%02X", string.byte(c)) end)
      str = string.gsub (str, " ", "+")
   end
   return str    
end
function toggleTroll(serverConnectionHandlerID, trollTP)
	if channelKicker.func.troll_mode == true then
		channelKicker.func.troll_mode = false
		ts3.printMessageToCurrentTab("Troll mode set to \"FALSE\"")
	elseif channelKicker.func.troll_mode == false then
		channelKicker.func.troll_mode = true
		if not isempty(trollTP) then
			trollTP = trollTP
		elseif isempty(trollTP)then
			trollTP = 62
		end
		ts3.printMessageToCurrentTab("Troll mode set to \"TRUE\" MaxTP: "..trollTP)
	end
end
function addToNAME(serverConnectionHandlerID, added)
	local clientIDown  = ts3.getClientID(serverConnectionHandlerID)
	local nickName = ts3.getClientVariableAsString(serverConnectionHandlerID, clientIDown, ts3defs.ClientProperties.CLIENT_NICKNAME)
	ts3.setClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME, nickName .. added)
	local error = ts3.flushClientSelfUpdates(serverConnectionHandlerID)
	if error == ts3errors.ERROR_client_nickname_inuse then
		return
	elseif error ~= ts3errors.ERROR_ok then
		return
	end
end
function remFromNAME(serverConnectionHandlerID, removed)
	ts3.setClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME, newNick)
	local error = ts3.flushClientSelfUpdates(serverConnectionHandlerID)
	if error == ts3errors.ERROR_client_nickname_inuse then
		return
	elseif error ~= ts3errors.ERROR_ok then
		return
	end
end
function channelBanClient(group, channel, client)
	local socket = require("socket")

	local server = socket.connect(localhost, 235639)
	server:send("setclientchannelgroup cgid=".. group .." cid=".. channel .." cldbid=".. client)
	server:close()
end
function msgnotify(serverConnectionHandlerID, mode)
	mode = string.lower(mode)
	if mode == "server" then
		clientlist = ts3.getClientList(serverConnectionHandlerID)
	elseif mode == "channel" then
		local clientIDown  = ts3.getClientID(serverConnectionHandlerID)
		local channelIDown = ts3.getChannelOfClient(serverConnectionHandlerID, clientIDown)
		clientlist = ts3.getChannelClientList(serverConnectionHandlerID, channelIDown)
	else
		ts3.printMessageToCurrentTab("Usage: /lua run msgnotify {server/channel}")
	end
	for i=1, #clientlist do
		local unread = ts3.getClientVariableAsInt(serverConnectionHandlerID, clientlist[i], ts3defs.ClientProperties.CLIENT_UNREAD_MESSAGES)
		if unread > 1 then
			ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "\n\n\t[color=grey]Erinnerung[/color]: Du hast noch [[color=red]"..unread.."[/color]] ungelesene Offline Nachrichten!\n\n\t\tKlicke auf das Brief-Icon unten rechts in deinem Teamspeak Client um sie zu lesen.", clientlist[i])
		elseif unread > 0 then
			ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "\n\n\t[color=grey]Erinnerung[/color]: Du hast noch eine ungelesene Offline Nachricht!\n\n\t\tKlicke auf das Brief-Icon unten rechts in deinem Teamspeak Client um sie zu lesen.", clientlist[i])
		end
	end
	ts3.printMessageToCurrentTab("Informed Clients about their msgs!")
end
function msgoutdated(serverConnectionHandlerID, mode)
	mode = string.lower(mode)
	if mode == "server" then
		clientlist = ts3.getClientList(serverConnectionHandlerID)
	elseif mode == "channel" then
		local clientIDown  = ts3.getClientID(serverConnectionHandlerID)
		local channelIDown = ts3.getChannelOfClient(serverConnectionHandlerID, clientIDown)
		clientlist = ts3.getChannelClientList(serverConnectionHandlerID, channelIDown)
	else
		ts3.printMessageToCurrentTab("Usage: /lua run msgoutdated {server/channel}")
	end
	for i=1, #clientlist do
		local version = ts3.getClientVariableAsInt(serverConnectionHandlerID, clientlist[i], ts3defs.ClientProperties.CLIENT_VERSION)
		if version > 1 then
			ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "\n\n\t[color=grey]Erinnerung[/color]: Du hast noch [[color=red]"..version.."[/color]] ungelesene Offline Nachrichten!\n\n\t\tKlicke auf das Brief-Icon unten rechts in deinem Teamspeak Client um sie zu lesen.", clientlist[i])
		elseif version > 0 then
			ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "\n\n\t[color=grey]Erinnerung[/color]: Du hast noch eine ungelesene Offline Nachricht!\n\n\t\tKlicke auf das Brief-Icon unten rechts in deinem Teamspeak Client um sie zu lesen.", clientlist[i])
		end
	end
	ts3.printMessageToCurrentTab("Informed Clients about their msgs!")
end
channelKicker.info.MODULEFILE = "functions"
ts3.printMessageToCurrentTab("Loaded "..channelKicker.info.MODULE.." v"..channelKicker.info.MODULEVERSION.." by "..channelKicker.info.MODULEAUTHOR.." from "..ts3.getPluginPath().."lua_plugin/"..channelKicker.info.MODULEFOLDER.."/"..channelKicker.info.MODULEFILE.."."..channelKicker.info.MODULEEXT)