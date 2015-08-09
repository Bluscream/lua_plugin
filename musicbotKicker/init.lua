
require("ts3init") 
require("musicbotKicker/musicbotKicker")  

local MODULE_NAME = "musicbotKicker"
local SCRIPT = "LUA MusicBot Kicker"
local SCRIPTSHORT = "MBK"
local VERSION = "0.1"
local AUTHOR = "B1uscr34m"
local EMAIL = "piracy@teamspeakusa.com"
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Installation Instructions:
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- %ts3dir%: "c:\program files (x68)\teamspeak 3 client" OR "c:\program files\teamspeak 3 client" OR "%appdata%\TS3Client"
-- Settings
MBK_DEBUG = true
ColArray = { 'Green', 'Yellow', 'Red', 'Blue' }
RANDCOL = ( ColArray[ math.random( #ColArray ) ] )
MBK_PREFIX = "[color=grey][[/color][color="..RANDCOL.."]"..SCRIPTSHORT.."[/color][color=grey]][/color]"
function MBK_ScriptLog(logMSG)
	if CC_DEBUG == true then
		local tsCol = { 'Green', 'Black', 'Red', 'Blue' }
		local RANDCOL = ( tsCol[ math.random( #tsCol ) ] )
		local scriptTimestamp = os.date("%x %X")
		ts3.printMessageToCurrentTab("[color=Black][[/color][color="..RANDCOL.."]"..scriptTimestamp.."[/color][color=Black]][/color]> "..SCRIPT_PREFIX..": "..logMSG)
		-- ts3.logMessage(logMSG, severity, channel, logID)
		-- debugPrint(logMSG)
	end
end
-- -----------------------------=LOGGING=-------------------------------------
MBK_ScriptLog("[color=".. RANDCOL .."]_-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-_[/color]")
MBK_ScriptLog("[color=darkgreen]".. SCRIPT .."[/color] [color=white][[/color][color=orange]".. VERSION .."[/color][color=white]][/color] loading...")
-- ____________________________-=LOGGING=-____________________________________

local registeredEvents = {

	onClientKickFromChannelEvent = channelKicker_events.onClientKickFromChannelEvent,
	onClientChannelGroupChangedEvent = channelKicker_events.onClientChannelGroupChangedEvent,
	onClientMoveEvent = channelKicker_events.onClientMoveEvent,
	onUpdateClientEvent = channelKicker_events.onUpdateClientEvent,
	onTextMessageEvent = channelKicker_events.onTextMessageEvent
}

ts3RegisterModule(MODULE_NAME, registeredEvents)
-- -----------------------------=LOGGING=-------------------------------------
MBK_ScriptLog("[color=darkgreen]".. SCRIPT .."[/color] [color=white][[/color][color=orange]".. VERSION .."[/color][color=white]][/color] loaded...")
MBK_ScriptLog("[color=".. RANDCOL .."]_-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-_[/color]")
-- ____________________________-=LOGGING=-____________________________________
