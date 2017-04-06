require("ts3init")
function ScriptLog(logMSG)
	if channelJOIN.setting.debug == true then
		local tsCol = { 'Green', 'Black', 'Red', 'Blue' }
		local RANDCOL = ( tsCol[ math.random( #tsCol ) ] )
		local scriptTimestamp = os.date("%x %X")
		ts3.printMessageToCurrentTab("[color=Black][[/color][color="..RANDCOL.."]"..scriptTimestamp.."[/color][color=Black]][/color]> ".. channelJOIN.info.prefix ..": "..logMSG)
	end
end
ts3.printMessageToCurrentTab("Loading Channel Join Module...")
require("channelJOIN/settings")
if channelJOIN.setting.active == false then
	ts3.printMessageToCurrentTab("Channel Join Module deactivated in settings.lua. Shutting down...")
	return
end
require("channelJOIN/functions")
local registeredEvents = {}
ScriptLog("init.lua loaded...")
ts3.printMessageToCurrentTab(channelJOIN.info.name.." v"..channelJOIN.info.ver.." by "..channelJOIN.info.author.." loaded successfully!")
ts3RegisterModule(channelJOIN.info.MODULE, registeredEvents)
