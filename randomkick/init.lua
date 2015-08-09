local error_txtToServer = ts3.requestSendServerTextMsg(serverConnectionHandlerID, "[b]DICE ROLLED![/b]")
if error_txtToServer ~= ts3errors.ERROR_ok then
  msg("Error sending message to Server channel, chances are your not an SA so not continuing.")
  return
end
	local myClientID = getSelfID(serverConnectionHandlerID)
	local clients = getClientList(serverConnectionHandlerID)
local rand = rand(1,#clients)
local clientName, error = ts3.getClientVariableAsString(serverConnectionHandlerID, rand, ts3defs.ClientProperties.CLIENT_NICKNAME)
	if error ~= ts3errors.ERROR_ok then
			msg("Error getting client nickname for roll #"..rand..".")
			return
	end
local error_kickClient = ts3.requestClientKickFromChannel(serverConnectionHandlerID, rand, "Lady luck has struck again!")

if error_kickClient ~= ts3errors.ERROR_ok then
  msg("Error kicking client "..rand..".")
end
	ts3.requestSendServerTextMsg(serverConnectionHandlerID, "[b]Dice rolled a number "..rand.."! "..clientName.." was Kicked, unlucky![/b]")