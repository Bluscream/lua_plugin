require("ts3init")  
lvlSaver = {
	info = {
		name = "Group Saver",
		prefix = "GS",
		folder = "lvlSaver",
		ext = "lua",
		ver = "1.0",
		author = "Bluscream",
	},
	setting = { -- Edit below this line! --
		active = true, -- Enable the script.
		debug = true, -- The script shows debug messages.
	},    -- Edit above this line! --
}
ts3.printMessageToCurrentTab("Loading "..lvlSaver.info.name)

local function onClientMoveEvent(sCHID, clientID, oldChannelID, newChannelID, visibility, moveMessage)
	ts3.printMessageToCurrentTab("aaa")
	if clientID ~= ts3.getClientID(sCHID) and oldChannelID == 0 then
		local clientUID = ts3.getClientVariableAsString(sCHID, clientID, ts3defs.ClientProperties.CLIENT_UNIQUE_IDENTIFIER)
		local clientServerGroups = ts3.getClientVariableAsString(sCHID, clientID, ts3defs.ClientProperties.CLIENT_SERVERGROUPS)
		local path = string.gsub(os.getenv("UserProfile"), "\\", "\\\\")
		path = path.."\\Desktop\\saved_groups.csv"
		local file = io.open(path, "a")
		for line in io.lines(path) do
			if string.find(""..line, ""..clientUID) then
				skipLine = true
				ts3.printMessageToCurrentTab("Skipping line for "..clientUID)
			end
		end
		if not skipLine then
			file:write(clientUID..";"..clientServerGroups.."\n")
			file:close()
			ts3.printMessageToCurrentTab("Printed "..clientUID.." to "..path)
		end
	end
end

local events = {
	onClientMoveEvent = onClientMoveEvent
}
ts3.printMessageToCurrentTab(lvlSaver.info.name.." loaded.")
ts3RegisterModule("lvlSaver", events)