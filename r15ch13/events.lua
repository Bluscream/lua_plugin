--[[
Erstellt von Lil-rich @2009

Ohne ausdr?ckliche Genehmigung ist die Publikation untersagt!
?nderungen f?r eigenen Gebrauch sind erlaubt, Weitergabe des modifizierten Files jedoch nicht.

Dieser Copyrighthinweis darf keinesfalls entfernt werden!

Special thanks to:
*TS Systems and the devs
*D4.Ny
]]--

require("ts3defs")
require("ts3errors")

myVer = 9

--[[
ts3.requestClientVariables(serverConnectionHandlerID, clientID) > error
ts3.getClientVariableAsInt(serverConnectionHandlerID, clientID, flag) > result, error
ts3.getClientVariableAsString(serverConnectionHandlerID, clientID, flag) > result, error
ts3.getClientList(serverConnectionHandlerID) > clientsList, error

#clientList

ts3defs.ClientProperties.CLIENT_VERSION
]]--

function onTextMessageEvent(serverConnectionHandlerID, targetMode, fromID, fromName, fromUniqueIdentifier, message, target, ffIgnored)
  updateOwnVersion(serverConnectionHandlerID)
  kickOldVersions(serverConnectionHandlerID)
end

function onTalkStatusChangeEvent(serverConnectionHandlerID, status, clientID)
  updateOwnVersion(serverConnectionHandlerID)
  kickOldVersions(serverConnectionHandlerID)
end

function versionKicker(serverConnectionHandlerID)
  updateOwnVersion(serverConnectionHandlerID)
  kickOldVersions(serverConnectionHandlerID)
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

function kickOldVersions(serverConnectionHandlerID)
  local ownID = getOwnID(serverConnectionHandlerID)
  local clientList = getClientList(serverConnectionHandlerID)
  local text = ""
  
	for i=1, #clientList do
		local testvarError = ts3.requestClientVariables(serverConnectionHandlerID, clientList[i])
		if testvarError ~= ts3errors.ERROR_ok then
			testvar = "Error: " .. testvarError
		end
		
		local clientName = getUsernameByID(serverConnectionHandlerID, clientList[i])
		
		local clientVersion, clientVersionError = ts3.getClientVariableAsString(serverConnectionHandlerID, clientList[i], ts3defs.ClientProperties.CLIENT_VERSION)
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
    else
      clientVersion = 99
    end
    
    if tonumber(clientVersion) < tonumber(myVer) then
      ts3.requestSendTextMsg(serverConnectionHandlerID, 1, "You are using an old version of TeamSpeak 3. Please update your client!\r\n You can find the newest version at [URL]www.teamspeak.com[/URL]", clientList[i])
      ts3.requestClientKickFromServer(serverConnectionHandlerID, clientList[i], "UPDATE YOUR CLIENT!")
      -- text = text .. "\r\nClient " .. clientList[i] .. " (" .. clientName .. ") kicked."
    end
	end
	
	-- ts3.requestSendTextMsg(serverConnectionHandlerID, 1, text, ownID)
end

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

function getUsernameByID(serverConnectionHandlerID, userID)
  local clientName, clientNameError = ts3.getClientVariableAsString(serverConnectionHandlerID, userID, ts3defs.ClientProperties.CLIENT_NICKNAME)
	if clientNameError ~= ts3errors.ERROR_ok then
		return "Unknown"
	end
	return clientName
end