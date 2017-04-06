require("ts3init")  
Kick2Ban = {
	info = {
		name = "Kick2Ban",
		prefix = "K2B",
		folder = "Kick2Ban",
		ext = "lua",
		ver = "1.0",
		author = "Bluscream",
	},
	setting = { -- Edit below this line! --
		active = true, -- Enable the script.
		debug = true, -- The script shows debug messages.
	},		    -- Edit above this line! --
	bannedUIDs = { "e6z1ATxBRnhuZmzQI/p+Rft6SRk=" },
	bannedNicks = { "Skippo" }
}

local function dbg(msg)	if Kick2Ban.setting.debug then ts3.printMessageToCurrentTab(msg) end end

local function serverKick(sCHID, targetID, msg)
	--ts3.requestClientKickFromServer(serverConnectionHandlerID, targetID, msg)
	ts3.printMessageToCurrentTab("Client Kicked")
end

local function checkClientUID(sCHID, targetID)
	local targetUID = ts3.getClientVariableAsString(sCHID, targetID, ts3defs.ClientProperties.CLIENT_UNIQUE_IDENTIFIER)
	for i, UID in ipairs(Kick2Ban.bannedUIDs) do
		dbg(targetUID..": "..UID)
		if targetUID == UID then
			serverKick(sCHID, targetID, "Kick2Ban")
		end
	end
	local targetNick = ts3.getClientDisplayN
end
local function checkClientNick(sCHID, targetID)
	local targetNick = ts3.getClientDisplayName(sCHID, targetID)
	targetNick = string.lower(targetNick)
	for i, name in ipairs(Kick2Ban.bannedNicks) do
		local name = string.lower(name)
		dbg(targetNick..": "..name)
		if targetNick.tolower().find(name) then
			serverKick(sCHID, targetID, "Kick2Ban")
		end
	end
end
local function onClientMoveEvent(sCHID, clientID, oldChannelID, newChannelID, visibility, moveMessage)
	if Kick2Ban.setting.active then
		if newChannelID ~= 0 then
			checkClientUID(sCHID, clientID)
			checkClientNick(sCHID, clientID)
		end
	end
end

local events = {
	onClientMoveEvent = onClientMoveEvent
}
ts3.printMessageToCurrentTab(Kick2Ban.info.name.." loaded.")
ts3RegisterModule("Kick2Ban", events)