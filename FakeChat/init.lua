require("ts3defs")
require("ts3errors")

local SCRIPT = "LUA FakeChat"
local SCRIPTSHORT = "FC"
local FILENAME = "init.lua"
local FILEDIR = "%ts3dir%\plugins\lua_plugin\FakeChat"
local VERSION = "0.1"
local AUTHOR = "registrator"
local EMAIL = "piracy@teamspeakusa.com"

-- Settings
FC_DEBUG = true
ColArray = { 'Green', 'Yellow', 'Red', 'Blue' }
RANDCOL = ( ColArray[ math.random( #ColArray ) ] )
SCRIPT_PREFIX = "[color=grey][[/color][color="..RANDCOL.."]"..SCRIPTSHORT.."[/color][color=grey]][/color]"
function ScriptLog(logMSG)
	if FC_DEBUG == true then
		local tsCol = { 'Green', 'Black', 'Red', 'Blue' }
		local RANDCOL = ( tsCol[ math.random( #tsCol ) ] )
		local scriptTimestamp = os.date("%x %X")
		ts3.printMessageToCurrentTab("[color=Black][[/color][color="..RANDCOL.."]"..scriptTimestamp.."[/color][color=Black]][/color]> "..SCRIPT_PREFIX..": "..logMSG)
		-- ts3.logMessage(logMSG, severity, channel, logID)
		-- debugPrint(logMSG)
	end
end
-- -----------------------------=LOGGING=-------------------------------------
ScriptLog("[color=".. RANDCOL .."]_-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-_[/color]")
ScriptLog("[color=darkgreen]".. SCRIPT .."[/color] [color=white][[/color][color=orange]".. VERSION .."[/color][color=white]][/color] loading...")
-- ____________________________-=LOGGING=-____________________________________
-- Variables
clock = os.clock
function sleep(n)  -- seconds
  local t0 = clock()
  while clock() - t0 <= n do end
end
function wsleep(n)
  if n > 0 then os.execute("ping -n " .. tonumber(n+1) .. " localhost > NUL") end
end
function testlog(serverConnectionHandlerID, text)
	ScriptLog(text)
end
function cc(serverConnectionHandlerID)
	local emcCol = { 'Green', 'Yellow', 'Red', 'Blue' }
	local RANDCOL = ( emcCol[ math.random( #emcCol ) ] )
	ts3.printMessageToCurrentTab("[u][color=".. RANDCOL .."]".. SCRIPT ..": [b]Commands[/b][/color][/u]")
	ts3.printMessageToCurrentTab("Show all Channel Variables: [color=red]/lua run channelCreationInfo[/color]")
	ts3.printMessageToCurrentTab("Start creating a pre-defined channel: [color=red]/lua run createChannel {channelMODE}[/color]")
	ts3.printMessageToCurrentTab("Show all available channelMODEs: [color=red]/lua run ccchannelModes[/color]")
end
function colrandomizer()
	local myTable = { 'Green', 'Yellow', 'Red', 'Blue' }
	local RANDCOL = ( myTable[ math.random( #myTable ) ] )
end
function isempty(s)
  return s == nil or s == ''
end
-- -----------------------------=LOGGING=-------------------------------------
if CC_DEBUG == true then
	ScriptLog("Core functions loaded...")
end
-- ____________________________-=LOGGING=-____________________________________
function fakechat(serverConnectionHandlerID, fc_name, fc_msg, fc_cid, fc_uid, fc_timestamp)

	if isempty(fc_name) then
		fc_name = "Test"
	end
	if isempty(fc_msg) then
		fc_msg = "Test Message"
	end
	if isempty(fc_cid) then
		fc_cid = "1"
	end
	if isempty(fc_uid) then
		fc_uid = "test="
	end
	if isempty(fc_timestamp) then
		fc_timestamp = os.date("%X")
	end
	
	chatString = "[color=#33597D]<"..fc_timestamp..">[/color] [b][color=#002F5D]\"[URL=client://"..fc_cid.."/"..fc_uid.."~"..fc_name.."]"..fc_name.."[/URL]\":[/color][/b] [color=black]"..fc_msg.."[/color]" 
	
	ts3.printMessageToCurrentTab(chatString)
	
end

function fakemsg(serverConnectionHandlerID, ...)

	if isempty(mode) then
		ts3.printMessageToCurrentTab("You have to select a mode to use this feature \(channel/private\) ")
	end
	if isempty(fc_name) then
		fc_name = "Test"
	end
	if isempty(targetID) then
		if mode == "private" then
			targetID, error = ts3.getClientID(serverConnectionHandlerID)
			if error ~= ts3errors.ERROR_ok then
				print("Error getting own client ID: " .. error)
				return
			end
			if targetID == 0 then
				ts3.printMessageToCurrentTab("Not connected")
				return
			end
		elseif mode == "channel" then
			myClientID, error = ts3.getClientID(serverConnectionHandlerID)
			if error ~= ts3errors.ERROR_ok then
				print("Error getting own client ID: " .. error)
				return
			end
			if myClientID == 0 then
				ts3.printMessageToCurrentTab("Not connected")
				return
			end
			local targetID, error = ts3.getChannelOfClient(serverConnectionHandlerID, myClientID)
			if error ~= ts3errors.ERROR_ok then
				print("Error getting own channel: " .. error)
				return
			end
		end
	if isempty(fc_msg) then
		fc_msg = "Test Message"
	end
	if isempty(fc_cid) then
		fc_cid = "1"
	end
	if isempty(fc_uid) then
		fc_uid = "test="
	end
	if isempty(fc_timestamp) then
		fc_timestamp = os.date("%X")
	end

	local fc_msg = ""
	for i,v in ipairs(arg) do
		fc_msg = fc_msg .. tostring(v) .. " "
	end
	argMsg = string.gsub(fc_msg, "\\s", " ")
	
	msgString = "[color=#33597D]<"..fc_timestamp..">[/color] [b][color=#002F5D]\"[URL=client://"..fc_cid.."/"..fc_uid.."~"..fc_name.."]"..fc_name.."[/URL]\":[/color][/b] [color=black]"..fc_msg.."[/color]"
	if mode == "private" then
		sendPrivateMSG, error = ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, msgString, targetID)
		if not isempty(error) then
			if error ~= ts3errors.ERROR_ok then
				print("Error sending private MSG: " .. error)
				return
			end
		end
	elseif mode == "channel" then
		sendChannelMSG, error = ts3.requestSendChannelTextMsg(serverConnectionHandlerID, msgString, targetID)
		if not isempty(error) then
			if error ~= ts3errors.ERROR_ok then
				print("Error sending Channel MSG: " .. error)
				return
			end
		end
	end
 end
end