require("ts3defs")
require("ts3errors")

--[[
Erstellt von Lil-rich @2009

Ohne ausdrückliche Genehmigung ist die Publikation untersagt!
Änderungen für eigenen Gebrauch sind erlaubt, Weitergabe des modifizierten Files jedoch nicht.

Dieser Copyrighthinweis darf keinesfalls entfernt werden!
]]

-- HELP-FUNCTIONS
function getClientList(serverConnectionHandlerID)
	local clients, error = ts3.getClientList(serverConnectionHandlerID)
	if error == ts3errors.ERROR_not_connected then
		ts3.printMessage(serverConnectionHandlerID, "Not connected")
		return
	elseif error ~= ts3errors.ERROR_ok then
		print("Error getting client list: " .. error)
		return
	end
	return clients
end

function getOwnID(serverConnectionHandlerID)
  local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
	if error ~= ts3errors.ERROR_ok then
		return
	elseif myClientID == 0 then
		return
	end
	return myClientID
end

function getUserChannelID(serverConnectionHandlerID, userID)
  local channelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, userID)
	if error ~= ts3errors.ERROR_ok then
		return 1
	end
	return channelID
end

function getUsernameByID(serverConnectionHandlerID, userID)
  local clientName, clientNameError = ts3.getClientVariableAsString(serverConnectionHandlerID, userID, ts3defs.ClientProperties.CLIENT_NICKNAME)
	if clientNameError ~= ts3errors.ERROR_ok then
		return "Unknown"
	end
	return clientName
end