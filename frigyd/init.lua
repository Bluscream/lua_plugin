--=======================================--
--============== Frigyd Init ==============--
--=======================================--

require("ts3init")
require("frigyd/core")
require("frigyd/events")

commandList = {}
loadedMods = {}

frigDir = "plugins/lua_plugin/frigyd"

local dirs = ts3.getDirectories(ts3.getResourcesPath() .. frigDir .. "/modules")

local fModules = {}

if(dirs ~= nil) then
	local dirSplit = Split(dirs, " ")
	for k, dir in pairs(dirSplit) do
		local f = io.open(ts3.getResourcesPath().. frigDir .."/modules/"..dir.."/init.lua", "r")
		
		if(f ~= nil) then
			--init.lua file found, add it.
			table.insert(fModules, dir)
		end
		
	end
	
	print("==|==|==|==|==|==|==|==|==|==|==|==|==|==|==")
	print("==| :: Frigyd ::  Loading Modules   ::   |==")
	print("==|==|==|==|==|==|==|==|==|==|==|==|==|==|==")
	
	if(#fModules > 0) then
		for k,v in pairs(fModules) do
			local myDir = "frigyd/modules/".. v .."/init"
			
			--print(myDir)
			if(pcall(require, myDir) ~= true) then
				print("==| :: Module ::  '"..v.."' Failed ::")
				loadedMods[v] = false
			else
				print("==| :: Module ::  '"..v.."' Loaded ::")
				loadedMods[v] = true
			end
			
		end
	else
		print("==|  ::  No Modules to Load  ::")
	end
	print("==|==|==|==|==|==|==|==|==|==|==|==|==|==|==")
end

-- Define which callbacks you want to receive in your module. Callbacks not mentioned
-- here will not be called. To avoid function name collisions, your callbacks should
-- be put into an own package.
local registeredEvents = {
	onConnectStatusChangeEvent = frig_events.onConnectStatusChangeEvent,
	onTextMessageEvent = frig_events.onTextMessageEvent,
	onTalkStatusChangeEvent = frig_events.onTalkStatusChangeEvent,
	onClientMoveEvent = frig_events.onClientMoveEvent,
	onClientMoveMovedEvent = frig_events.onClientMoveMovedEvent,
	onClientMoveTimeoutEvent = frig_events.onClientMoveTimeoutEvent,
	onUpdateClientEvent = frig_events.onUpdateClientEvent
}

-- Register your callback functions with a unique module name.
ts3RegisterModule("frigyd", registeredEvents)

