--[[ 
Jeder Client der in einem Channel ist, dessen Channelnamen etwas von der Blacklist beinhaltet, wird nicht angestupst.
z.B. blacklistchannel = {"Aufnahme"}
Alle Clients die in den Aufnahme Channeln sind werden nicht angestupst.
z.B. blacklistchannel = {"Aufnahme","Micha"}
Alle Clients die in den Aufnahme Channeln oder Michas Büro sind werden nicht angestupst.
Weitere Namen müssen wie folgt hinzu gefügt werden. z.B. Packie
1. Man setzt es in Anführungszeichen: "Packie"
2. Man setzt ein Koma davor: ,"Packie"
3. Man fügt es der Blacklist hinzu: 
blacklistchannel = {"Aufnahme","Packie"}

Das wiederholt man falls man andere Channel hinzufügen will:
blacklistchannel = {"Aufnahme","Packie","Micha"}
]]--


--Standard:
--blacklistchannel = {"Aufnahme"}
blacklistchannel = {"Aufnahme"}

require("ts3defs")
require("ts3errors")

serverConnectionHandlerID = ts3.getCurrentServerConnectionHandlerID()


function xprint(msg)
	ts3.printMessageToCurrentTab(msg)
end

xprint("Konfiguration ist am Anfang der Datei: <TeamSpeak3>\\plugins\\lua_plugin\\xlife\\main.lua")
xprint("Befehle:")
--xprint("ID mit Clientname: '/lua run IDs'")
xprint("Massenanstupsen: '/lua run mapo <Nachricht>'")
xprint("z.B. /lua run mapo Event startet in 30 min!")
xprint("Massenmoven: '/lua run mamo <Passwort>'")
xprint("z.B. /lua run mamo sadfklöashödsajhf")
xprint("z.B. /lua run mamo")
xprint("© xLife | Felix")

--[[
function IDs(serverConnectionHandlerID)
	Clients = ts3.getClientList(serverConnectionHandlerID)
	for i = 1, #Clients do
		local Nickname, error = ts3.getClientVariableAsString(serverConnectionHandlerID, Clients[i], ts3defs.ClientProperties.CLIENT_NICKNAME)
		if error ~= ts3errors.ERROR_ok then
			xprint("Error getting client nickname: " .. error .. " | ID: " .. Clients[i])
			return
		end
		xprint("ID: " .. Clients[i] .. " | Nickname: " .. Nickname)
	end
end
]]

function mamo(serverConnectionHandlerID, password)
	local myClientID = ts3.getClientID(serverConnectionHandlerID)
	local Clients, error = ts3.getClientList(serverConnectionHandlerID)
	if error == ts3errors.ERROR_not_connected then
		xprint("Not connected")
		return
	elseif error ~= ts3errors.ERROR_ok then
		xprint("Error getting client list: " .. error)
		return
	end
	local ChannelIDs, error = ts3.getChannelList(serverConnectionHandlerID)
	if error ~= ts3errors.ERROR_ok then
		xprint("Error getting ChannelIDs: " .. error)
		return
	end
	local ChannelNames = {}
	local blacklistmp = {}
	for i = 1, #ChannelIDs do
		local ChannelName, error = ts3.getChannelVariableAsString(serverConnectionHandlerID, ChannelIDs[i], ts3defs.ChannelProperties.CHANNEL_NAME)
		if error ~= ts3errors.ERROR_ok then
			xprint("Error getting channel name: " .. error)
			return
		end
		ChannelNames[#ChannelNames+1] = {ChannelIDs[i], ChannelName}
	end
	for i,v in ipairs(ChannelNames) do
		for i2,v2 in ipairs(blacklistchannel) do
			if tostring(string.find(string.lower(v[2]), string.lower(v2))) ~= "nil" then
				blacklistmp[#blacklistmp+1] = v[1]
			end
		end
	end
	for i = 1, #Clients do
		if Clients[i] ~= myClientID then
			local ChannelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, Clients[i])
			if error ~= ts3errors.ERROR_ok then
				xprint("Error getting own channel: " .. error)
				return
			end
			poke = true
			for i,v in ipairs(blacklistmp) do
				if v == ChannelID then
					poke = false
				end
			end
			local Nickname, error = ts3.getClientVariableAsString(serverConnectionHandlerID, Clients[i], ts3defs.ClientProperties.CLIENT_NICKNAME)
			if error ~= ts3errors.ERROR_ok then
				xprint("Error getting client nickname: " .. error .. " | ID: " .. Clients[i])
				return
			end
			if poke == true then pokestring = "Ja" else pokestring = "Nein" end
			xprint("ID: "..tostring(Clients[i]).." | Nickname: "..Nickname.." | Gemovet: "..pokestring) 
			if poke == true then	
				local myChannelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, myClientID)
				if password ~= nil then
					local error = ts3.requestClientMove(serverConnectionHandlerID, Clients[i], myChannelID, password)
				else
					local error = ts3.requestClientMove(serverConnectionHandlerID, Clients[i], myChannelID, "")
				end
				if error ~= ts3errors.ERROR_ok then
					xprint("Error moving: " .. error)
					return
				end
			end
		end
	end
end

function ChID(serverConnectionHandlerID)
	local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own ID: " .. error)
		return
	end
	local channelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, myClientID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own channel: " .. error)
		return
	end
	local channelName, error = ts3.getChannelVariableAsString(serverConnectionHandlerID, channelID, ts3defs.ChannelProperties.CHANNEL_NAME)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting channel name: " .. error)
		return
	end
	xprint("ID: "..channelID.." | "..channelName)
end

function mapo(serverConnectionHandlerID, ...)
	local myClientID = ts3.getClientID(serverConnectionHandlerID)
	local Clients, error = ts3.getClientList(serverConnectionHandlerID)
	if error == ts3errors.ERROR_not_connected then
		xprint("Not connected")
		return
	elseif error ~= ts3errors.ERROR_ok then
		xprint("Error getting client list: " .. error)
		return
	end
	local argMsg = ""
	for i,v in ipairs(arg) do
		argMsg = argMsg .. tostring(v) .. " "
	end
	if string.len(argMsg) > 0 and string.len(argMsg) <= 100 then
		local ChannelIDs, error = ts3.getChannelList(serverConnectionHandlerID)
		if error ~= ts3errors.ERROR_ok then
			xprint("Error getting ChannelIDs: " .. error)
			return
		end
		local ChannelNames = {}
		local blacklistmp = {}
		for i = 1, #ChannelIDs do
			local ChannelName, error = ts3.getChannelVariableAsString(serverConnectionHandlerID, ChannelIDs[i], ts3defs.ChannelProperties.CHANNEL_NAME)
			if error ~= ts3errors.ERROR_ok then
				xprint("Error getting channel name: " .. error)
				return
			end
			ChannelNames[#ChannelNames+1] = {ChannelIDs[i], ChannelName}
		end
		for i,v in ipairs(ChannelNames) do
			for i2,v2 in ipairs(blacklistchannel) do
				if tostring(string.find(string.lower(v[2]), string.lower(v2))) ~= "nil" then
					blacklistmp[#blacklistmp+1] = v[1]
				end
			end
		end
		for i = 1, #Clients do
			if Clients[i] ~= myClientID then
				local ChannelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, Clients[i])
				if error ~= ts3errors.ERROR_ok then
					xprint("Error getting own channel: " .. error)
					return
				end
				poke = true
				for i,v in ipairs(blacklistmp) do
					if v == ChannelID then
						poke = false
					end
				end
				local Nickname, error = ts3.getClientVariableAsString(serverConnectionHandlerID, Clients[i], ts3defs.ClientProperties.CLIENT_NICKNAME)
				if error ~= ts3errors.ERROR_ok then
					xprint("Error getting client nickname: " .. error .. " | ID: " .. Clients[i])
					return
				end
				if poke == true then pokestring = "Ja" else pokestring = "Nein" end
				xprint("ID: "..tostring(Clients[i]).." | Nickname: "..Nickname.." | Angestupst: "..pokestring) 
				if poke == true then
					-- local error = ts3.requestClientPoke(serverConnectionHandlerID, Clients[i], argMsg)
					local error = ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, argMsg, Clients[i])
					if error ~= ts3errors.ERROR_ok then
						xprint("Error poking: " .. error)
						return
					end
				end
			end
		end
	elseif string.len(argMsg) <= 0 then
		xprint("Nachricht zu kurz")
	elseif string.len(argMsg) > 100 then
		xprint("Nachricht zu lang")
	end
end

xprint("Eventmanager Massenanstupsen initialisiert!")