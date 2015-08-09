require("ts3init")
require("ts3defs")
require("ts3events")
local MSGRedirect = {
	info = {
		MODULE = "MSG Redirect Module",
		MODULESHORT = "MSGR",
		MODULEFOLDER = "MSGRedirect",
		MODULEFILE = "init",
		MODULEEXT = "lua",
		MODULEVERSION = "1.0",
		MODULEAUTHOR = "Bluscream",
		DEBUG = true,
	},
	var = {
		guestServerGroup = "10",
		guestChannelGroup = "11",
		banChannelGroup = "12",
		channelAdminGroup = "9",
		channelModGroup = "10",
		channelMSGGroup = "13",
		ENABLED = false,
		LAST = "0",
	},
	loc = {
		infoMSG1 = "\n\nHallo [color=green]",
		infoMSG2 = "[/color], du bist hier [color=red]Gast[/color] aber moechtest trozdem im Channel mitschreiben?\n\nDann schreib mir einfach zurueck und ich werde die Nachricht an den Channel weiterleiten.\n\n[color=red]INFO: SPAM ODER SONSTIGER ABUSE WIRD MIT SOFORTIGEM CHANNELBAN UND BLOCK BESTRAFT![/color]",
		redirectMSG = "Weitergeleitete Nachricht von",
	},
}
BadWordArray = { 'hurensohn', 'ddos', 'wichser', 'egal', 'lizard', 'asshole', 'arschloch', 'fick', 'anus', 'scheide', 'vagina', 'fotze', 'schlampe', 'hitler', 'adolf', 'sieg', 'heil' }
LinkArray = { '%://', 'www%.', '%.net', '%.de', '%.com', '%.me', '%.tk' }
oldMSG = ""

local function ScriptLog(logMSG)
	if MSGRedirect.info.DEBUG == true then
		local tsCol = { 'Green', 'Black', 'Red', 'Blue' }
		local RANDCOL = ( tsCol[ math.random( #tsCol ) ] )
		local scriptTimestamp = os.date("%x %X")
		ts3.printMessageToCurrentTab("[color=Black][[/color][color="..RANDCOL.."]"..scriptTimestamp.."[/color][color=Black]][/color]> "..MSGRedirect.info.MODULESHORT..": "..logMSG)
		-- ts3.logMessage(logMSG, 4, 0x0002, 1)
		-- debugPrint(logMSG)
		print(logMSG)
	end
end
local function isempty(s)
  return s == nil or s == ''
end
local function urlencode(str)
   if (str) then
      str = string.gsub (str, "\n", "\r\n")
      str = string.gsub (str, "([^%w ])",
         function (c) return string.format ("%%%02X", string.byte(c)) end)
      str = string.gsub (str, " ", "+")
   end
   return str    
end

function msgredirect(serverConnectionHandlerID, mode)
	if isempty(mode) then
		if MSGRedirect.var.ENABLED == true then
			MSGRedirect.var.ENABLED = false
			ts3.printMessageToCurrentTab("MSGRedirect set to \"FALSE\"")
		else
			MSGRedirect.var.ENABLED = true
			ts3.printMessageToCurrentTab("MSGRedirect set to \"TRUE\"")
		end
	else
		local mode = string.lower(mode)
		if mode == "on" then
			MSGRedirect.var.ENABLED = true
			ts3.printMessageToCurrentTab("MSGRedirect set to \"TRUE\"")
		elseif mode == "off" then
			MSGRedirect.var.ENABLED = false
			ts3.printMessageToCurrentTab("MSGRedirect set to \"FALSE\"")
		end
	end
end

function onClientMoveEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, moveMessage)
	if MSGRedirect.var.ENABLED == true and MSGRedirect.var.LAST ~= clientID then
		local ownID = ts3.getClientID(serverConnectionHandlerID)
		local ownChannelID = ts3.getChannelOfClient(serverConnectionHandlerID, ownID)
		if newChannelID == ownChannelID and clientID ~= ownID then
			local clientServerGroups = ts3.getClientVariableAsString(serverConnectionHandlerID,clientID,34)
			if string.find(clientServerGroups, MSGRedirect.var.guestChannelGroup) then
				MSGRedirect.var.LAST = clientID
				local clientName = ts3.getClientVariableAsString(serverConnectionHandlerID,clientID,ts3defs.ClientProperties.CLIENT_NICKNAME)
				ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, MSGRedirect.loc.infoMSG1 .. clientName .. MSGRedirect.loc.infoMSG2, clientID)
			end
		end
	end
end

function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
	local ownID = ts3.getClientID(serverConnectionHandlerID)
	local ownChannelID = ts3.getChannelOfClient(serverConnectionHandlerID, ownID)
	local clientChannelID = ts3.getChannelOfClient(serverConnectionHandlerID, fromID)
	local clientChannelGroup = ts3.getClientVariableAsString(serverConnectionHandlerID,fromID,ts3defs.ClientProperties.CLIENT_CHANNEL_GROUP_ID)
	local ownChannelGroupID = ts3.getClientVariableAsString(serverConnectionHandlerID,ownID,ts3defs.ClientProperties.CLIENT_CHANNEL_GROUP_ID)
	local clientServerGroups = ts3.getClientVariableAsString(serverConnectionHandlerID,fromID,ts3defs.ClientProperties.CLIENT_SERVERGROUPS)
	if MSGRedirect.var.ENABLED == true and toID == ownID and clientChannelID == ownChannelID and ffIgnored == 0 then
		if ownChannelGroupID == MSGRedirect.var.channelMSGGroup or ownChannelGroupID == MSGRedirect.var.channelModGroup or ownChannelGroupID == MSGRedirect.var.channelAdminGroup then
			if clientChannelGroup ~= MSGRedirect.var.banChannelGroup and clientChannelGroup == MSGRedirect.var.guestChannelGroup and string.find(clientServerGroups, MSGRedirect.var.guestServerGroup ) then
				lowMessage = string.lower(message)
				if lowMessage ~= oldMSG and string.len(lowMessage) > 1 and string.len(lowMessage) < 850 then
					local clientName = ts3.getClientVariableAsString(serverConnectionHandlerID,fromID,ts3defs.ClientProperties.CLIENT_NICKNAME)
					if string.find (lowMessage, "ts3server:" ) ~= nil then
						ScriptLog(clientName .. " hat versucht einen TS3Server Link zu versenden.")
					elseif string.find (lowMessage, '%d+%.%d+%.%d+%.%d') ~= nil or string.find (lowMessage, '%w%w%w%w::%w%w%w%w::%w%w%w%w::%w%w%w%w') ~= nil or string.find (lowMessage, '%w%w%w%w:%w%w%w%w:%w%w%w%w:%w%w%w%w:%w%w%w%w:%w%w%w%w:%w%w%w%w:%w%w%w%w') ~= nil then
						ScriptLog(clientName .. " hat versucht eine IP zu versenden.")
					-- elseif then
						-- ScriptLog(clientName .. " hat versucht eine IP zu versenden.")
					else
						local uniqueID = ts3.getClientVariableAsString(serverConnectionHandlerID,fromID,ts3defs.ClientProperties.CLIENT_UNIQUE_IDENTIFIER)
						local nickNameEncoded = urlencode(clientName)
						ts3.requestSendChannelTextMsg(serverConnectionHandlerID, MSGRedirect.loc.redirectMSG .. " [URL=client://" .. fromID .. "/" .. uniqueID .. "~" .. nickNameEncoded .. "]\"" .. clientName .. "\"[/url]: " .. message, clientChannelID)
						oldMSG = lowMessage
					end
				end
			end
		end
	end
end

function onDelChannelEvent(serverConnectionHandlerID, channelID, invokerID, invokerName, invokerUniqueIdentifier)
-- ts3.printMessageToCurrentTab("onDelChannelEvent")
	local ownID = ts3.getClientID(serverConnectionHandlerID)
	local ownChannelID = ts3.getChannelOfClient(serverConnectionHandlerID, ownID)
	if channelID == ownChannelID then
		MSGRedirect.var.ENABLED = false
		ts3.printMessageToCurrentTab("[color=red]MSGRedirect was forced to shut down because our channel was deleted by "..invokerName.."![/color]")
	end
end

function onClientKickFromChannelEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, kickerID, kickerName, kickerUniqueIdentifier, kickMessage)
	-- ts3.printMessageToCurrentTab("onClientKickFromChannelEvent")
	local ownID = ts3.getClientID(serverConnectionHandlerID)
	if ownID == clientID and MSGRedirect.var.ENABLED == true then
		clientMoveReq, error = ts3.requestClientMove(serverConnectionHandlerID, clientID, oldChannelID, "")
		if error ~= ts3errors.ERROR_ok then
			MSGRedirect.var.ENABLED = false
			ts3.printMessageToCurrentTab("[color=red]MSGRedirect was forced to shut down because we were unable to rejoin old channel" .. oldChannelID .. "![/color]")
			return
		end
	end
end
		

local registeredMSGREvents = {

        onClientMoveEvent = onClientMoveEvent,
		onTextMessageEvent = onTextMessageEvent,
		onDelChannelEvent = onDelChannelEvent,
		onClientKickFromChannelEvent = onClientKickFromChannelEvent
		
}

ts3RegisterModule(MSGRedirect.info.MODULE, registeredMSGREvents)
ScriptLog("Loaded "..MSGRedirect.info.MODULE.." v"..MSGRedirect.info.MODULEVERSION.." by "..MSGRedirect.info.MODULEAUTHOR.." from "..ts3.getPluginPath().."lua_plugin/"..MSGRedirect.info.MODULEFOLDER.."/"..MSGRedirect.info.MODULEFILE.."."..MSGRedirect.info.MODULEEXT)