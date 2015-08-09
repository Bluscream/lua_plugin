require("ts3init")
require("ts3defs")
require("ts3events")
local massControl = {
	const = {
		MODULE = "Extended Mass Control Module",
		MODULESHORT = "EMC",
		MODULEFOLDER = "masscontrolmodule",
		MODULEFILE = "masscontrol",
		MODULEEXT = "lua",
		MODULEVERSION = "1.0",
		MODULEAUTHOR = "Bluscream",
		DEBUG = true,
		
	},
	var = {},
}
local function ScriptLog(logMSG)
	if massControl.const.DEBUG == true then
		local tsCol = { 'Green', 'Black', 'Red', 'Blue' }
		local RANDCOL = ( tsCol[ math.random( #tsCol ) ] )
		local scriptTimestamp = os.date("%x %X")
		ts3.printMessageToCurrentTab("[color=Black][[/color][color="..RANDCOL.."]"..scriptTimestamp.."[/color][color=Black]][/color]> "..massControl.const.MODULESHORT..": "..logMSG)
		ts3.logMessage(logMSG, 4, 0x0002, 1)
		debugPrint(logMSG)
		print(logMSG)
	end
end
local function isempty(s)
  return s == nil or s == ''
end

local registeredEvents = {
}
ScriptLog("Loaded "..massControl.const.MODULE.." v"..massControl.const.MODULEVERSION.." by "..massControl.const.MODULEAUTHOR.." from "..ts3.getPluginPath().."lua_plugin/"..massControl.const.MODULEFOLDER.."/"..massControl.const.MODULEFILE.."."..massControl.const.MODULEEXT)
ts3RegisterModule("massControl", registeredEvents)