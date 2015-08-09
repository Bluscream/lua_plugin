--
--	Funktionen von LibNotify
--

require("ts3errors")
require("libnotify/def")

nickNameList = {}
lastChanID = 0

-- Prüfen, ob Tabelle für entsprechenden Server vorhanden ist
function _checkSubTable(tableName)
	for key, value in pairs(nickNameList) do
		if key == tableName then
			return true
		end
	end
	return false
end

-- Nickname in Tabelle speichern
function addNickName(serverID, clientID, clientName)
	local check = _checkSubTable(serverID)
	local infos = { ID = clientID, NAME = clientName}
	if  check ~= true then
		nickNameList[serverID] = {infos}
	else
		if clientName == getNickName(serverID, clientID) then
			return
		else
			table.insert(nickNameList[serverID], infos)
		end
	end
end

-- Nickname auslesen
function getNickName(serverID, clientID)
	for key, value in pairs(nickNameList[serverID]) do
		if value.ID == clientID then
			return value.NAME
		end
	end
	return false
end

-- Sende Notification für Windows
function sendWindowsNotification(title, text, icon)
	local formattedTitle = string.format('%q', title)
	local formattedText = string.format('%q', text)
	local formattedIcon = string.format('%q', icon)
	
	-- Sende Notification über Growl
	if libNotifySystemConfig.OSConfig.WINDOWS.GROWL_Exec.ACTIVE == true then
		os.execute(libNotifySystemConfig.OSConfig.WINDOWS.GROWL_Exec.PATH .. " /t:" .. formattedTitle .. " " .. formattedText)
	end
end

-- Sende Notification für Linux
function sendLinuxNotification(title, text, icon)
	local formattedTitle = string.format('%q', title)
	local formattedText = string.format('%q', text)
	
	--Sende Notification über LibNotify
	if libNotifySystemConfig.OSConfig.LINUX.LIBNOTIFY_Exec.ACTIVE == true then
		os.execute(libNotifySystemConfig.OSConfig.LINUX.LIBNOTIFY_Exec.PATH .. " -i " .. icon .. " " .. formattedTitle .. " " .. formattedText)
	end
end

-- Sende Notification
function sendNotification(title, text, icon)
	print("Sending notification: " .. icon .. " " .. title .. " " .. text)
	
	if libNotifySystemConfig.activeOS == libNotifySystemConfig.supportedOS.WINDOWS then
		sendWindowsNotification(title, text, icon)
	end
	
	if libNotifySystemConfig.activeOS == libNotifySystemConfig.supportedOS.LINUX then
		sendLinuxNotification(title, text, icon)
	end
end

-- Generiere Notification-Message
function notificationText(messageName, values)
	local text = ""
	if notificationConfig.language == "DE" then
		text = notificationMessages.DE[messageName]
	end
	if notificationConfig.language == "EN" then
		text = notificationMessages.EN[messageName]
	end
	for varname, value in pairs(values) do
		text, count = string.gsub(text, "{" .. varname .. "}", value)
	end
	return text
end

-- Auslesen der eigenen Client-ID
function getClientID(serverConnectionHandlerID)
	local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own client ID: " .. error)
		return
	end
	return myClientID
end

-- Auslesen der ID des Channels des Clients
function getChannelID(serverConnectionHandlerID, clientID, own)
	local channelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, clientID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting ChannelID: " .. error)
		return
	end
	if own == true then
		lastChanID = channelID
	end
	return channelID
end

-- Auslesen des Server-Namens, von dem die Nachricht kommt
function getServerName(serverConnectionHandlerID)
	local serverName, error = ts3.getServerVariableAsString(serverConnectionHandlerID, ts3defs.VirtualServerProperties.VIRTUALSERVER_NAME)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting ServerName: " .. error)
		return
	end
	return serverName
end

-- Auslesen des Client-Namens, der das Event verursacht
function getClientName(serverConnectionHandlerID, clientID)
	local joinNickname, error = ts3.getClientVariableAsString(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_NICKNAME)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting client nickname: " .. error)
		return getNickName(serverConnectionHandlerID, clientID)
		--return
	end
	addNickName(serverConnectionHandlerID, clientID, joinNickname)
	return joinNickname
end

-- Auslesen aller ClientNamen im Channel
function readChannelClients(serverConnectionHandlerID, channelID)
	clientList, error = ts3.getChannelClientList(serverConnectionHandlerID, channelID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting channel client list: " .. error)
		return
	end
	for i=1, #clientList do
		local clientName, error = ts3.getClientVariableAsString(serverConnectionHandlerID, clientList[i], ts3defs.ClientProperties.CLIENT_NICKNAME)
		if error == ts3errors.ERROR_ok then
			print("libNotify: DEBUG: " .. clientList[i] .. " " .. clientName .. "\n")
			addNickName(serverConnectionHandlerID, clientList[i], clientName)
		else
			clientName = "Error getting client name"
		end
	end
end

-- Setzen des Servers auf die Liste
function addListEntry(entry)
	local content = readList()
	local entries = {}
	if content ~= nil then
		local sep = string.find(content, ",")
		if sep ~= nil then
			entries = string.split(content, ",")
		else
			entries = {content}
		end
	end
	table.insert(entries, entry)
	writeList(table.concat(entries, ","))
end

-- Löschen eines Server-Eintrages
function delListEntry(entry)
	local content = readList()
	local entries = {}
	if content ~= nil then
		local sep = string.find(content, ",")
		if sep ~= nil then
			entries = string.split(content, ",")
		else
			entries = {content}
		end
	end
	for key, value in pairs(entries) do
		if value == entry then
			table.remove(entries, key)
		end
	end
	writeList(table.concat(entries, ","))
end

-- Prüfen, ob Server in der Liste
function checkEntry(serverConnectionHandlerID)
	local entry = ts3.getServerVariableAsString(serverConnectionHandlerID, ts3defs.VirtualServerProperties.VIRTUALSERVER_UNIQUE_IDENTIFIER)
	local content = readList()
	local entries = {}
	if content ~= nil then
		local sep = string.find(content, ",")
		if sep ~= nil then
			entries = string.split(content, ",")
		else
			entries = {content}
		end
	end
	for key, value in pairs(entries) do
		if value == entry then
			return true
		end
	end
	return false
end

-- Liste auslesen
function readList()
	local file, error = io.open(notificationConfig.listFile, "rb")
	if file == nil then
		return nil
	end
	local listContent = file:read("*a")
	file:close()
	return listContent
end

-- Liste schreiben
function writeList(content)
	local file = io.open(notificationConfig.listFile, "wb")
	file:write(content)
	file:close()
end
