require("ts3init")
require("ts3defs")
require("ts3events")
local listVars = {
	const = {
		MODULE = "List Vars Module",
		MODULESHORT = "LV",
		MODULEFOLDER = "listvars",
		MODULEFILE = "listVars",
		MODULEEXT = "lua",
		MODULEVERSION = "1.0",
		MODULEAUTHOR = "Bluscream",
		DEBUG = true,
	},
	var = {},
}
local function ScriptLog(logMSG)
	if listVars.const.DEBUG == true then
		local tsCol = { 'Green', 'Black', 'Red', 'Blue' }
		local RANDCOL = ( tsCol[ math.random( #tsCol ) ] )
		local scriptTimestamp = os.date("%x %X")
		ts3.printMessageToCurrentTab("[color=Black][[/color][color="..RANDCOL.."]"..scriptTimestamp.."[/color][color=Black]][/color]> "..listVars.const.MODULESHORT..": "..logMSG)
		-- ts3.logMessage(logMSG, 4, 0x0002, 1)
		-- debugPrint(logMSG)
		print(logMSG)
	end
end
local function isempty(s)
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
function vars(serverConnectionHandlerID, lv_MODE, lv_ID)
	if isempty(lv_MODE) or isempty(lv_ID) then
		ts3.printMessageToCurrentTab("["..listVars.const.MODULESHORT.."] [b][color=red]Usage: /lua run vars {client/channel/server} {0/clientID/channelID}")
		return
	end
	lv_timestamp = os.date("%d:%m:%y %H:%M:%S")
	lv_MODE = string.lower(lv_MODE)
	if lv_MODE == "client" then
		if lv_ID == 0 then
			lv_ID, error = ts3.getClientID(serverConnectionHandlerID)
			if error ~= ts3errors.ERROR_ok then
				ts3.printMessageToCurrentTab("Error getting own client ID: " .. error)
				return
			end
		end
		lv_MODENEW = lv_MODE
		ClientDataRequested = true
		requestedID = lv_ID
		ts3.requestClientVariables(serverConnectionHandlerID, lv_ID)
	elseif lv_MODE == "channel" then
		if lv_ID == 0 then
			lv_ID, error = ts3.getClientID(serverConnectionHandlerID)
			if error ~= ts3errors.ERROR_ok then
				print("Error getting own client ID: " .. error)
				return
			end
			lv_ID, error = ts3.getChannelOfClient(serverConnectionHandlerID, lv_ID)
			if error ~= ts3errors.ERROR_ok then
				print("Error getting own channel ID: " .. error)
				return
			end
			if lv_ID == 0 then
				ts3.printMessageToCurrentTab("Not connected")
				return
			end
		end
		ts3.printMessageToCurrentTab("[[color=black]"..lv_timestamp.."[/color]] -= Start of "..lv_MODE.." variables =-")
		for i=0,32 do
			local VarInt = ts3.getChannelVariableAsInt(serverConnectionHandlerID, lv_ID, i)
			local VarString = ts3.getChannelVariableAsString(serverConnectionHandlerID, lv_ID, i)
			ts3.printMessageToCurrentTab("[ [color=green]" .. i .. "[/color] ] VarInt = \"[color=red]" .. VarInt .. "[/color]\" | VarString = \"[color=red]" .. VarString .. "[/color]\"")
		end
		ts3.printMessageToCurrentTab("[[color=black]"..lv_timestamp.."[/color]] -= End of "..lv_MODE.." variables =-")
	elseif lv_MODE == "server" then
		lv_MODENEW = lv_MODE
		ServerDataRequested = true
		requestedID = lv_ID
		ts3.requestServerVariables(serverConnectionHandlerID)
	end
end
function list(serverConnectionHandlerID, lv_MODE, lv_FLAG)
	if isempty(lv_MODE) then
		ts3.printMessageToCurrentTab("["..listVars.const.MODULESHORT.."] [b][color=red]Usage: /lua run list [clients/channels] {temp/semi/perm}")
		return
	end
	lv_timestamp = os.date("%d:%m:%y %H:%M:%S")
	lv_MODE = string.lower(lv_MODE)
	if not isempty(lv_FLAG) then
		lv_FLAG = string.lower(lv_FLAG)
	end
	if lv_MODE == "clients" or lv_MODE == "queries" then
		clist = ts3.getClientList(serverConnectionHandlerID)
	elseif lv_MODE == "channels" then
		clist = ts3.getChannelList(serverConnectionHandlerID)
	end
	local msg = ""
	if not isempty(lv_FLAG) then
		ts3.printMessageToCurrentTab("[[color=black]"..lv_timestamp.."[/color]] -= Start of \""..lv_FLAG.."\" \""..lv_MODE.."\" list =-")
	else
		ts3.printMessageToCurrentTab("[[color=black]"..lv_timestamp.."[/color]] -= Start of \""..lv_MODE.."\" list =-")
	end
	for key,value in pairs(clist) do
		if lv_MODE == "queries" then
			clientTYPE = 0
			clientTYPE = ts3.getClientVariableAsInt(serverConnectionHandlerID, value, ts3defs.ClientProperties.CLIENT_TYPE)
		end
		if not isempty(lv_FLAG) then
			semi = ts3.getChannelVariableAsInt(serverConnectionHandlerID, value, ts3defs.ChannelProperties.CHANNEL_FLAG_SEMI_PERMANENT)
			perm = ts3.getChannelVariableAsInt(serverConnectionHandlerID, value, ts3defs.ChannelProperties.CHANNEL_FLAG_PERMANENT)
			-- ts3.printMessageToCurrentTab("semi="..semi.."|perm="..perm)
			if lv_FLAG == "temp" then
				if semi == 1 or perm == 1 then
					value = nil
				end
			elseif lv_FLAG == "semi" then
				if semi == 0 then
					value = nil
				end
			elseif lv_FLAG == "perm" then
				if perm == 0 then
					value = nil
				end
			end
		end
		if not isempty(value) then
			if lv_MODE == "queries" then
				if clientTYPE == 1 then
					if isempty(msg) then
						msg = value
					else
						msg = msg .. "," .. value
					end
				end
			else
				if isempty(msg) then
					msg = value
				else
					msg = msg .. "," .. value
				end
			end
		end
	end
	if not isempty(msg) then
		ts3.printMessageToCurrentTab(msg)
	end
	if not isempty(lv_FLAG) then
		ts3.printMessageToCurrentTab("[[color=black]"..lv_timestamp.."[/color]] -= End of \""..lv_FLAG.."\" \""..lv_MODE.."\" list =-")
	else
		ts3.printMessageToCurrentTab("[[color=black]"..lv_timestamp.."[/color]] -= End of \""..lv_MODE.."\" list =-")
	end
end

function description(serverConnectionHandlerID, channelID)
	local channelNAME = ts3.getChannelVariableAsString(serverConnectionHandlerID, channelID, ts3defs.ChannelProperties.CHANNEL_NAME)
	local description = ts3.getChannelVariableAsString(serverConnectionHandlerID, channelID, ts3defs.ChannelProperties.CHANNEL_DESCRIPTION)
	ts3.printMessageToCurrentTab("[color=green]Start of Description of Channel \"[color=black]" .. channelNAME .. "[/color]\" #" .. channelID .. "[/color]\n[color=blue]========================================================================================[/color]\n[color=black]" .. description .. "[/color]\n[color=blue]========================================================================================[/color]\n[color=red]End of Description of Channel \"[color=black]" .. channelNAME .. "[/color]\" #" .. channelID .. "[/color]")
end

function prnt(serverConnectionHandlerID, lv_MODE, lv_FLAG, lv_MSG) -- )
	if not isempty(lv_MSG) then
		sendMSG = true
	else
		sendMSG = false
	end
	if isempty(lv_MODE) then -- or isempty(lv_FLAG)
		ts3.printMessageToCurrentTab("["..listVars.const.MODULESHORT.."] [b][color=red]Usage: /lua run prnt [clients/channels/channel)] {channelID}")
		return
	end
	lv_timestamp = os.date("%d:%m:%y %H:%M:%S")
	lv_MODE = string.lower(lv_MODE)
	-- if not isempty(lv_FLAG) then
		-- lv_FLAG = string.lower(lv_FLAG)
	-- end
	if lv_MODE == "clients" or lv_MODE == "users" or lv_MODE == "queries" then
		clist = ts3.getClientList(serverConnectionHandlerID)
	elseif lv_MODE == "channels" then
		clist = ts3.getChannelList(serverConnectionHandlerID)
	elseif lv_MODE == "channel" then
		clist = ts3.getChannelClientList(serverConnectionHandlerID, lv_FLAG)
	end
	if isempty(lv_FLAG) then
		if sendMSG == true then
			local ownID = ts3.getClientID(serverConnectionHandlerID)
			local myChannel = ts3.getChannelOfClient(serverConnectionHandlerID, ownID)
			ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[[color=black]"..lv_timestamp.."[/color]] -= Start of \""..lv_MODE.."\" table =-", myChannel)
		else
			ts3.printMessageToCurrentTab("[[color=black]"..lv_timestamp.."[/color]] -= Start of \""..lv_MODE.."\" table =-")
		end
	else
		if sendMSG == true then
			local ownID = ts3.getClientID(serverConnectionHandlerID)
			local myChannel = ts3.getChannelOfClient(serverConnectionHandlerID, ownID)
			ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[[color=black]"..lv_timestamp.."[/color]] -= Start of \""..lv_MODE.."\" #" .. lv_FLAG .. " table =-", myChannel)
		else
			ts3.printMessageToCurrentTab("[[color=black]"..lv_timestamp.."[/color]] -= Start of \""..lv_MODE.."\" #" .. lv_FLAG .. " table =-")
		end
	end
	for key,value in pairs(clist) do
		-- if not isempty(lv_FLAG) then
			-- if lv_FLAG == "clients" then
				-- if semi == 1 or perm == 1 then
					-- value = nil
				-- end
			-- elseif lv_FLAG == "queries" then
				
			-- end
		-- end
		if lv_MODE == "clients" or lv_MODE == "channel" then
			local name = ts3.getClientVariableAsString(serverConnectionHandlerID,value,ts3defs.ClientProperties.CLIENT_NICKNAME)
			local uniqueID = ts3.getClientVariableAsString(serverConnectionHandlerID,value,ts3defs.ClientProperties.CLIENT_UNIQUE_IDENTIFIER)
			local channelID = ts3.getChannelOfClient(serverConnectionHandlerID, value)
			local channel = ts3.getChannelVariableAsString(serverConnectionHandlerID, channelID, ts3defs.ChannelProperties.CHANNEL_NAME)
			local nickNameEncoded = urlencode(name)
			local clientTYPE = ts3.getClientVariableAsInt(serverConnectionHandlerID, value, ts3defs.ClientProperties.CLIENT_TYPE)
			if clientTYPE == 0 then
				clientTYPE = "Client"
			elseif clientTYPE == 1 then
				clientTYPE = "Query"
			else
				clientTYPE = "Unkown"
			end
			MSG = "[b][[color=red]"..key.."[/color]][/b] [color=black]|[/color] #[color=green]"..value.."[/color] [color=black]|[/color] ".. clientTYPE .." [color=black]|[/color] [URL=client://" .. value .. "/" .. uniqueID .. "~" .. nickNameEncoded .. "]\"" .. name .. "\"[/url] [color=black]|[/color] [URL=channelid://" .. channelID .. "]" .. channel .. "[/url]"
		elseif lv_MODE == "channels" then
			local name = ts3.getChannelVariableAsString(serverConnectionHandlerID,value,ts3defs.ChannelProperties.CHANNEL_NAME)
			MSG = "[b][[color=red]"..key.."[/color]][/b] [color=black]|[/color] #[color=green]"..value.."[/color] [color=black]|[/color] [URL=channelid://" .. value .. "]" .. name .. "[/url]"
		elseif lv_MODE == "users" then
			local clientTYPE = ts3.getClientVariableAsInt(serverConnectionHandlerID, value, ts3defs.ClientProperties.CLIENT_TYPE)
			if clientTYPE == 0 then
				local name = ts3.getClientVariableAsString(serverConnectionHandlerID,value,ts3defs.ClientProperties.CLIENT_NICKNAME)
				local channelID = ts3.getChannelOfClient(serverConnectionHandlerID, value)
				local channel = ts3.getChannelVariableAsString(serverConnectionHandlerID, channelID, ts3defs.ChannelProperties.CHANNEL_NAME)
				local uniqueID = ts3.getClientVariableAsString(serverConnectionHandlerID,value,ts3defs.ClientProperties.CLIENT_UNIQUE_IDENTIFIER)
				local nickNameEncoded = urlencode(name)
				MSG = "[b][[color=red]"..key.."[/color]][/b] [color=black]|[/color] #[color=green]"..value.."[/color] [color=black]|[/color] [URL=client://" .. value .. "/" .. uniqueID .. "~" .. nickNameEncoded .. "]\"" .. name .. "\"[/url] [color=black]|[/color] [URL=channelid://" .. channelID .. "]" .. channel .. "[/url]"
			end
		elseif lv_MODE == "queries" then
			local clientTYPE = ts3.getClientVariableAsInt(serverConnectionHandlerID, value, ts3defs.ClientProperties.CLIENT_TYPE)
			if clientTYPE == 1 then
				local name = ts3.getClientVariableAsString(serverConnectionHandlerID,value,ts3defs.ClientProperties.CLIENT_NICKNAME)
				local channelID = ts3.getChannelOfClient(serverConnectionHandlerID, value)
				local channel = ts3.getChannelVariableAsString(serverConnectionHandlerID, channelID, ts3defs.ChannelProperties.CHANNEL_NAME)
				local uniqueID = ts3.getClientVariableAsString(serverConnectionHandlerID,value,ts3defs.ClientProperties.CLIENT_UNIQUE_IDENTIFIER)
				local nickNameEncoded = urlencode(name)
				MSG = "[b][[color=red]"..key.."[/color]][/b] [color=black]|[/color] #[color=green]"..value.."[/color] [color=black]|[/color] [URL=client://" .. value .. "/" .. uniqueID .. "~" .. nickNameEncoded .. "]\"" .. name .. "\"[/url] [color=black]|[/color] [URL=channelid://" .. channelID .. "]" .. channel .. "[/url]"
			end
		end
		if sendMSG == true then
			local ownID = ts3.getClientID(serverConnectionHandlerID)
			local myChannel = ts3.getChannelOfClient(serverConnectionHandlerID, ownID)
			ts3.requestSendChannelTextMsg(serverConnectionHandlerID, MSG, myChannel)
		else
			if isempty(MSG) then
			else
				print, error = ts3.printMessageToCurrentTab("" .. MSG .. "")
			end
		end
	end
	if not isempty(lv_FLAG) then
		if sendMSG == true then
			local ownID = ts3.getClientID(serverConnectionHandlerID)
			local myChannel = ts3.getChannelOfClient(serverConnectionHandlerID, ownID)
			ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[[color=black]"..lv_timestamp.."[/color]] -= End of \""..lv_MODE.."\" #" .. lv_FLAG .. " table =-", myChannel)
		else
			ts3.printMessageToCurrentTab("[[color=black]"..lv_timestamp.."[/color]] -= End of \""..lv_MODE.."\" #" .. lv_FLAG .. " table =-")
		end
	else
		if sendMSG == true then
			local ownID = ts3.getClientID(serverConnectionHandlerID)
			local myChannel = ts3.getChannelOfClient(serverConnectionHandlerID, ownID)
			ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "[[color=black]"..lv_timestamp.."[/color]] -= End of \""..lv_MODE.."\" table =-", myChannel)
		else
			ts3.printMessageToCurrentTab("[[color=black]"..lv_timestamp.."[/color]] -= End of \""..lv_MODE.."\" table =-")
		end
	end
	MSG = nil
end

function lv.onUpdateClientEvent(serverConnectionHandlerID, clientID, invokerID, invokerName, invokerUniqueIdentifier)
	if ClientDataRequested == true and requestedID == clientID then
		ts3.printMessageToCurrentTab("[[color=black]"..lv_timestamp.."[/color]] -= Start of \""..lv_MODENEW.."\" #"..requestedID.." variables =-")
		for i=0,59 do
			local VarInt = ts3.getClientVariableAsInt(serverConnectionHandlerID, requestedID, i)
			local VarUInt64 = ts3.getClientVariableAsUInt64(serverConnectionHandlerID, requestedID, i)
			local VarString = ts3.getClientVariableAsString(serverConnectionHandlerID, requestedID, i)
			local ConnectVarUInt64 = ts3.getConnectionVariableAsUInt64(serverConnectionHandlerID, requestedID, i)
			local ConnectVarDouble = ts3.getConnectionVariableAsDouble(serverConnectionHandlerID, requestedID, i)
			local ConnectVarString, error = ts3.getConnectionVariableAsString(serverConnectionHandlerID, requestedID, i)
			if error ~= ts3errors.ERROR_ok then
				ConnectVarString = "Empty"
			end
			local selfVarInt = ts3.getClientSelfVariableAsInt(serverConnectionHandlerID, i)
			local selfVarString = ts3.getClientSelfVariableAsString(serverConnectionHandlerID, i)
			ts3.printMessageToCurrentTab("[ [color=green]" .. i .. "[/color] ] VarInt = \"[color=red]" .. VarInt .. "[/color]\" | VarUInt64 = \"[color=red]" .. VarUInt64 .. "[/color]\" | VarString = \"[color=red]" .. VarString .. "[/color]\" [color=darkorange]||[/color] ConnectVarUInt64 = \"[color=red]" .. ConnectVarUInt64 .. "[/color]\" ConnectVarDouble = \"[color=red]" .. ConnectVarDouble .. "[/color]\"  ConnectVarString = \"[color=red]" .. ConnectVarString .. "[/color]\" [color=darkorange]||[/color] selfVarInt = \"[color=red]" .. selfVarInt .. "[/color]\" | selfVarString = \"[color=red]" .. selfVarString .. "[/color]\"")
		end
		ts3.printMessageToCurrentTab("[[color=black]"..lv_timestamp.."[/color]] -= End of \""..lv_MODENEW.."\" #"..requestedID.." variables =-")
		ClientDataRequested = false
		requestedID = nil
	end
end
function onServerUpdatedEvent(serverConnectionHandlerID)
	if ServerDataRequested == true then
		ts3.printMessageToCurrentTab("[[color=black]"..lv_timestamp.."[/color]] -= Start of "..lv_MODENEW.." variables =-")
		for i=0,78 do
			local VarInt = ts3.getServerVariableAsInt(serverConnectionHandlerID, i)
			local VarUInt64 = ts3.getServerVariableAsUInt64(serverConnectionHandlerID, i)
			local VarString = ts3.getServerVariableAsString(serverConnectionHandlerID, i)
			ts3.printMessageToCurrentTab("[ [color=green]" .. i .. "[/color] ] VarInt = \"[color=red]" .. VarInt .. "[/color]\" | VarUInt64 = \"[color=red]" .. VarUInt64 .. "[/color]\" | VarString = \"[color=red]" .. VarString .. "[/color]\"")
		end
		ts3.printMessageToCurrentTab("[[color=black]"..lv_timestamp.."[/color]] -= End of "..lv_MODENEW.." variables =-")
		ServerDataRequested = false
		requestedID = nil
	end
end

local registeredLVEvents = {

        onUpdateClientEvent = lv.onUpdateClientEvent,
		onServerUpdatedEvent = onServerUpdatedEvent
		
}

ts3RegisterModule(listVars.const.MODULE, registeredLVEvents)
ScriptLog("Loaded "..listVars.const.MODULE.." v"..listVars.const.MODULEVERSION.." by "..listVars.const.MODULEAUTHOR.." from "..ts3.getPluginPath().."lua_plugin/"..listVars.const.MODULEFOLDER.."/"..listVars.const.MODULEFILE.."."..listVars.const.MODULEEXT)