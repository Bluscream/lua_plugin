require("ts3init")

function onClientMoveEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, moveMessage)
	if oldChannelID == 0 then
		requestedclientvars = true
		requestedclientvarsclid = clientID
		ts3.requestClientVariables(serverConnectionHandlerID, clientID)
	end
end

function onUpdateClientEvent(serverConnectionHandlerID, clientID, invokerID, invokerName, invokerUniqueIdentifier)
	if requestedclientvars and requestedclientvarsclid == clientID then
		local platform = ts3.getClientVariableAsString(serverConnectionHandlerID,clientID,ts3defs.ClientProperties.CLIENT_PLATFORM)
		local version = ts3.getClientVariableAsString(serverConnectionHandlerID,clientID,ts3defs.ClientProperties.CLIENT_VERSION)
		appendtofile(platform, version)
		requestedclientvars = false
		requestedclientvarsclid = nil
	end
end

function appendtofile(platform, version)
	local path = string.gsub(os.getenv("UserProfile"), "\\", "\\\\")
	local path = path.."\\Desktop\\builds_"..platform..".csv"
	local file = io.open(path, "a")
	for line in io.lines(path) do
		if line == version then
			skipLine = true
		end
	end
	if not skipLine then
		file:write(version.."\n")
		file:close()
		ts3.printMessageToCurrentTab("Printed "..version.." to "..path)
	end
	skipLine = false
end

local registeredEvents = {
	onClientMoveEvent = onClientMoveEvent,
	onUpdateClientEvent = onUpdateClientEvent
}
ts3.printMessageToCurrentTab("buildSaver loaded successfully!")
ts3RegisterModule("buildSaver", registeredEvents)
