--
--	Kommandos von LibNotify
--

-- Ausführen mit "/lua run addServerToList"
function addServerToList(serverConnectionHandlerID)
	local serverIdentifier = ts3.getServerVariableAsString(serverConnectionHandlerID, ts3defs.VirtualServerProperties.VIRTUALSERVER_UNIQUE_IDENTIFIER)
	print("Server-Identifier:" .. serverIdentifier)
	addListEntry(serverIdentifier)
end

-- Ausführen mit "/lua run delServerFromList"
function delServerFromList(serverConnectionHandlerID)
	local serverIdentifier = ts3.getServerVariableAsString(serverConnectionHandlerID, ts3defs.VirtualServerProperties.VIRTUALSERVER_UNIQUE_IDENTIFIER)
	print("Server-Identifier:" .. serverIdentifier)
	delListEntry(serverIdentifier)
end
