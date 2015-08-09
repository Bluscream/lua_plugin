require("ts3init")
ColArray = { 'Green', 'Yellow', 'Red', 'Blue' }
RANDCOL = ( ColArray[ math.random( #ColArray ) ] )
require("channelKicker/settings")
SCRIPT_PREFIX = "[color=grey][[/color][color="..RANDCOL.."]"..channelKicker.info.MODULESHORT.."[/color][color=grey]][/color]"
function CK_ScriptLog(logMSG)
	if channelKicker.setting.DEBUG == true then
		local tsCol = { 'Green', 'Black', 'Red', 'Blue' }
		local RANDCOL = ( tsCol[ math.random( #tsCol ) ] )
		local scriptTimestamp = os.date("%x %X")
		ts3.printMessageToCurrentTab("[color=Black][[/color][color="..RANDCOL.."]"..scriptTimestamp.."[/color][color=Black]][/color]> "..SCRIPT_PREFIX..": "..logMSG)
		-- ts3.logMessage(logMSG, severity, channel, logID)
		-- debugPrint(logMSG)
	end
end
-- -----------------------------=LOGGING=-------------------------------------
CK_ScriptLog("[color=".. RANDCOL .."]_-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-_[/color]")
CK_ScriptLog("[color=darkgreen]".. channelKicker.info.MODULE .."[/color] [color=white][[/color][color=orange]".. channelKicker.info.MODULEVERSION .."[/color][color=white]][/color] loading...")
-- ____________________________-=LOGGING=-____________________________________
channelKicker.info.MODULEFILE = "settings"
ts3.printMessageToCurrentTab("Loaded "..channelKicker.info.MODULE.." v"..channelKicker.info.MODULEVERSION.." by "..channelKicker.info.MODULEAUTHOR.." from "..ts3.getPluginPath().."lua_plugin/"..channelKicker.info.MODULEFOLDER.."/"..channelKicker.info.MODULEFILE.."."..channelKicker.info.MODULEEXT)
require("channelKicker/lang")
require("channelKicker/vars")
require("channelKicker/functions")
require("channelKicker/events")
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Installation Instructions:
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- %ts3dir%: "c:\program files (x68)\teamspeak 3 client" OR "c:\program files\teamspeak 3 client" OR "C:\Users\YOUR USERNAME\AppData\Roaming\TS3Client"
-- a) If you want to use the full plugin:
-- a1) Download the plugin here: <coming soon>
-- a2) Install the plugin
-- a3) Goto step c)
-- b) If you want to run this script seperatly: 
-- b1) Save this script as "channelCreator.lua" in your "%ts3dir%\plugins\lua_plugin" folder.
-- b2) In teamspeak, any window, where chat would be enter: "/lua load channelCreator.lua" -- Response will be: "Lua script loaded"
-- b3) Now go to step c)
-- c) In Teamspeak press [CTRL]+[SHIFT]+[P] or go to 'Settings -> Plugins' and check the 'Lua Plugin' Checkbox.
-- c1) Click on Reload all then mark 'Lua Plugin' and click on Settings.
-- c2) Uncheck 'testmodule' and restart Teamspeak 3 Client or click on 'Reload all'
-- d) Call everything in here named "function TEXTHERE" from the TeamSpeak 3 chat via: /lua run <function>
-- Note that the serverConnectionHandlerID of the current server is always passed.
--

local registeredCKEvents = {

	onConnectStatusChangeEvent = channelKicker_events.onConnectStatusChangeEvent,
	onNewChannelCreatedEvent = channelKicker_events.onNewChannelCreatedEvent,
	onClientChannelGroupChangedEvent = channelKicker_events.onClientChannelGroupChangedEvent,
	onClientMoveEvent = channelKicker_events.onClientMoveEvent,
	onUpdateClientEvent = channelKicker_events.onUpdateClientEvent,
	onTextMessageEvent = channelKicker_events.onTextMessageEvent,
	onClientKickFromChannelEvent = channelKicker_events.onClientKickFromChannelEvent,
	onClientKickFromServerEvent = channelKicker_events.onClientKickFromServerEvent
}

ts3RegisterModule(channelKicker.info.MODULE, registeredCKEvents)
-- -----------------------------=LOGGING=-------------------------------------
CK_ScriptLog("[color=darkgreen]".. channelKicker.info.MODULE .."[/color] [color=white][[/color][color=orange]".. channelKicker.info.MODULEVERSION .."[/color][color=white]][/color] loaded...")
CK_ScriptLog("[color=".. RANDCOL .."]_-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-_[/color]")
-- ____________________________-=LOGGING=-____________________________________