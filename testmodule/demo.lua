--
-- Some TeamSpeak 3 functions for testing and demonstration
--

require("ts3defs")
require("ts3errors")

--
-- Call these function from the TeamSpeak 3 client console via: /lua run testmodule.<function>
-- Note the serverConnectionHandlerID of the current server is always passed.
--
-- You might want to pass the "-console" option when starting the TeamSpeak 3 client to get a console where a lot
-- of plugin related debug output will appear.
--

-- Run with "/lua run testmodule.showClientLibVersion"
local function showClientLibVersion(serverConnectionHandlerID)
	local version, error = ts3.getClientLibVersion()
	if error ~= ts3errors.ERROR_ok then
		print("Error getting clientlib version: " .. error)
		return
	end
	ts3.printMessageToCurrentTab("Clientlib version: " .. version)
end

-- Run with "/lua run testmodule.showClientLibVersionNumber"
local function showClientLibVersionNumber(serverConnectionHandlerID)
	local versionNumber, error = ts3.getClientLibVersionNumber()
	if error ~= ts3errors.ERROR_ok then
		print("Error getting clientlib version number: " .. error)
		return
	end
	ts3.printMessageToCurrentTab("Clientlib version number: " .. versionNumber)
end

-- Run with "/lua run testmodule.test"
local function test(serverConnectionHandlerID)
	ts3.printMessageToCurrentTab("Test on serverConnectionHandlerID: " .. serverConnectionHandlerID)

	-- Get own client ID
	local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own client ID: " .. error)
		return
	end
	if myClientID == 0 then
		ts3.printMessageToCurrentTab("Not connected")
		return
	end
	ts3.printMessageToCurrentTab("My client ID: " .. myClientID)

	-- Get own nickname
	local myNickname, error = ts3.getClientVariableAsString(serverConnectionHandlerID, myClientID, ts3defs.ClientProperties.CLIENT_NICKNAME)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own client nickname: " .. error)
		return
	end
	ts3.printMessageToCurrentTab("My nickname: " .. myNickname)

	-- Get which channel we are in
	local myChannelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, myClientID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own channel: " .. error)
		return
	end

	-- Get the name of my channel
	local myChannelName, error = ts3.getChannelVariableAsString(serverConnectionHandlerID, myChannelID, ts3defs.ChannelProperties.CHANNEL_NAME)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting channel name: " .. error)
		return
	end
	ts3.printMessageToCurrentTab("I am in channel ID: " .. myChannelName .. " (" .. myChannelID .. ")")
end

-- Run with "/lua run testmodule.argsTest <arg1> <arg2> <arg3>", args can be numbers or strings
local function argsTest(serverConnectionHandlerID, arg1, arg2, arg3)
	ts3.printMessageToCurrentTab("argsTest: " .. serverConnectionHandlerID .. " - " .. arg1 .. " " .. arg2 .. " " .. arg3)
end

-- Run with "/lua run testmodule.showClients"
local function showClients(serverConnectionHandlerID)
	local clients, error = ts3.getClientList(serverConnectionHandlerID)
	if error == ts3errors.ERROR_not_connected then
		ts3.printMessageToCurrentTab("Not connected")
		return
	elseif error ~= ts3errors.ERROR_ok then
		print("Error getting client list: " .. error)
		return
	end

	local msg = ("There are currently " .. #clients .. " visible clients:")
	for i=1, #clients do
		local clientName, error = ts3.getClientVariableAsString(serverConnectionHandlerID, clients[i], ts3defs.ClientProperties.CLIENT_NICKNAME)
		if error == ts3errors.ERROR_ok then
			msg = msg .. "\n " .. clients[i] .. " " .. clientName
		else
			clientName = "Error getting client name"
		end
	end
	ts3.printMessageToCurrentTab(msg)
end

-- Run with "/lua run testmodule.complainAboutMyself <complainReason>"
local function complainAboutMyself(serverConnectionHandlerID, complainReason)
	-- Add a complain about own client. Makes no sense, but hey, it's a demo. :-)
	
	-- Get own client ID
	local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own client ID: " .. error)
		return
	end
	if myClientID == 0 then
		ts3.printMessageToCurrentTab("Not connected")
		return
	end
	
	-- As we need the databaseID for complains, get own database ID from own client ID
	local myDatabaseID, error = ts3.getClientVariableAsUInt64(serverConnectionHandlerID, myClientID, ts3defs.ClientProperties.CLIENT_DATABASE_ID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own client database ID: " .. error)
		return
	end
	
	-- Send complain
	local error = ts3.requestComplainAdd(serverConnectionHandlerID, myDatabaseID, complainReason)
	if error ~= ts3errors.ERROR_ok then
		print("Error adding complain: " .. error)
		return
	end
	ts3.printMessageToCurrentTab("Complain about myself added with reason: " .. complainReason)
end

-- Run with "/lua run testmodule.showClientsInChannel <channelID>"
local function showClientsInChannel(serverConnectionHandlerID, channelID)
	-- Get list of clients in channelID passes as parameter
	local clientList, error = ts3.getChannelClientList(serverConnectionHandlerID, channelID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting channel client list: " .. error)
		return
	end

	-- Get name of this channel
	local channelName, error = ts3.getChannelVariableAsString(serverConnectionHandlerID, channelID, ts3defs.ChannelProperties.CHANNEL_NAME)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting channel name: " .. error)
		return
	end

	-- Loop through all clients in list and assemble message from their clientID and nickname
	msg = "Visible clients in channel " .. channelName
	for i=1, #clientList do
		local clientName, error = ts3.getClientVariableAsString(serverConnectionHandlerID, clientList[i], ts3defs.ClientProperties.CLIENT_NICKNAME)
		if error == ts3errors.ERROR_ok then
			msg = msg .. "\n " .. clientList[i] .. " " .. clientName
		else
			clientName = "Error getting client name"
		end
	end	
	ts3.printMessageToCurrentTab(msg)
end

-- Run with "/lua run testmodule.muteClient <clientID>"
local function muteClient(serverConnectionHandlerID, clientID)
	local clientIDs = { clientID }  -- Array of clientIDs to mute. You can define multiple clientIDs here, like: clientIds = { 1, 2, 3 }
	local error = ts3.requestMuteClients(serverConnectionHandlerID, clientIDs)
	if error == ts3errors.ERROR_ok then
		ts3.printMessageToCurrentTab("Client " .. clientID .. " muted")
	else
		print("Error requesting client mute: " .. error)
	end
end

-- Run with "/lua run testmodule.unmuteClient <clientID>"
local function unmuteClient(serverConnectionHandlerID, clientID)
	local clientIDs = { clientID }  -- Array of clientIDs to unmute. You can define multiple clientIDs here, like: clientIds = { 1, 2, 3 }
	local error = ts3.requestUnmuteClients(serverConnectionHandlerID, clientIDs)
	if error == ts3errors.ERROR_ok then
		ts3.printMessageToCurrentTab("Client " .. clientID .. " unmuted")
	else
		print("Error requesting client unmute: " .. error)
	end
end

-- Run with "/lua run testmodule.sendCommand <command>"
local function sendCommand(serverConnectionHandlerID, command)
	--[[
	Target Mode: 
	0 = send to all clients in current channel (targetIDs ignored)
	1 = send to all clients on server (targetIDs ignored)
	2 = send to all given client targetIDs
	3 = send to all subscribed clients in current channel (targetIDs ignored)
	]]--
	local targetMode = 0
	local targetIDs = {}
	local error = ts3.sendPluginCommand(serverConnectionHandlerID, command, targetMode, targetIDs)
	if error ~= ts3errors.ERROR_ok then
		print("Error sending plugin command: " .. error)
	end
	-- Monitor onPluginCommandEvent to see the incoming event
end

-- Run with "/lua run testmodule.getClientDisplayName <clientID>"
local function getClientDisplayName(serverConnectionHandlerID, clientID)
	local displayName, error = ts3.getClientDisplayName(serverConnectionHandlerID, clientID)
	if error == ts3errors.ERROR_ok then
		ts3.printMessageToCurrentTab("Client display name: " .. displayName)
	else
		print("Error getting client display name: " .. error)
	end
end

-- Run with "/lua run testmodule.setPluginMenuEnabled <menuID> <1|0>"
local function setPluginMenuEnabled(serverConnectionHandlerID, menuID, enabled)
	-- To get the correct menuID, add testmodule_events.moduleMenuItemID to the given menuID (MENU_ID_CLIENT_1 etc.)
	print("setPluginMenuEnabled: " .. menuID .. " " .. enabled .. " mult: " .. testmodule_events.moduleMenuItemID)
	ts3.setPluginMenuEnabled(testmodule_events.moduleMenuItemID + menuID, enabled)
end

-- Run with "/lua run testmodule.setClientVolumeModifier <clientID> <float value>"
local function setClientVolumeModifier(serverConnectionHandlerID, clientID, value)
	local error = ts3.setClientVolumeModifier(serverConnectionHandlerID, clientID, value)
	if error ~= ts3errors.ERROR_ok then
		print("Error setting client volume modifier: " .. error)
	end
end

-- Run with "/lua run testmodule.getPermissionIDByName <permissionName>, e.g. "b_serverinstance_modify_settings"
local function getPermissionIDByName(serverConnectionHandlerID, permissionName)
	local permissionID, error = ts3.getPermissionIDByName(serverConnectionHandlerID, permissionName)
	if error == ts3errors.ERROR_ok then
		ts3.printMessageToCurrentTab("Permission ID of '" .. permissionName .. "': " .. permissionID)
	else
		print("Error getting permission ID by name: " .. error)
	end
end

-- Run with "/lua run testmodule.getClientNeededPermission <permissionName>, e.g. "b_serverinstance_modify_settings"
local function getClientNeededPermission(serverConnectionHandlerID, permissionName)
	local result, error = ts3.getClientNeededPermission(serverConnectionHandlerID, permissionName)
	if error == ts3errors.ERROR_ok then
		ts3.printMessageToCurrentTab("Client needed permission value of '" .. permissionName .. "': " .. result)
	else
		print("Error getting client needed permission: " .. error)
	end
end

-- Run with "/lua run testmodule.guiConnect <serverAddress> <serverPassword> <nickname>
local function guiConnect(serverConnectionHandlerID, serverAddress, serverPassword, nickname)
	local serverConnectionHandlerID, error = ts3.guiConnect(1, "Lua Test Connection", serverAddress, serverPassword, nickname, "", "", "", "", "", "", "", "", "")
	if error == ts3errors.ERROR_ok then
		ts3.printMessageToCurrentTab("serverConnectionHandlerID: " .. serverConnectionHandlerID)
	else
		print("Error connecting: " .. error)
	end
end

testmodule = {
	showClientLibVersion = showClientLibVersion,
	showClientLibVersionNumber = showClientLibVersionNumber,
	test = test,
	argsTest = argsTest,
	showClients = showClients,
	complainAboutMyself = complainAboutMyself,
	showClientsInChannel = showClientsInChannel,
	muteClient = muteClient,
	unmuteClient = unmuteClient,
	sendCommand = sendCommand,
	getClientDisplayName = getClientDisplayName,
	setPluginMenuEnabled = setPluginMenuEnabled,
	setClientVolumeModifier = setClientVolumeModifier,
	getPermissionIDByName = getPermissionIDByName,
	getClientNeededPermission = getClientNeededPermission,
	guiConnect = guiConnect
}
