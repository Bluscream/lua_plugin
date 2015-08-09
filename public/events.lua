--
-- Public callback functions
--
-- To avoid function name collisions, you should use local functions and export them with a unique package name.
--

-- UID du serveur Teamspeak 3 public
publicUID = "LpfWDi8tO9blye3wZXZZ76uPAM8="

-- Variable générales du plugin
activePlugin = false
ownChannel = 0
oldChannel = 0
kickLink = true
autoKickBack = true
function onConnectStatusChangeEvent(serverConnectionHandlerID, newStatus, errorNumber)
	if newStatus == 4 then
		print("Connected")
		local serverUID = ts3.getServerVariableAsString(serverConnectionHandlerID, ts3defs.VirtualServerProperties.VIRTUALSERVER_UNIQUE_IDENTIFIER, result); 
		-- if serverUID == publicUID then
			print("Server OK, plugin activated")
			activePlugin = true
		-- end
	end
end

function onClientMoveEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, moveMessage)
	if activePlugin then
		-- Recup de son ID
		local ownID = getOwnID(serverConnectionHandlerID)
		
		-- Si le movement vient de soi
		if clientID == ownID then
			ownChannel = newChannelID
			oldChannel = oldChannelID
		else
			-- Pour le mouvement d'un autre
			--[[
			local clientName, error = ts3.getClientVariableAsString(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_NICKNAME)
			if error ~= ts3errors.ERROR_ok then
				print("Error OnClientMove-getClient: " .. error)
			else
				-- Si le pseudo correspond, il dégage
				if clientName == "isaac" then
					error = ts3.requestClientKickFromServer(serverConnectionHandlerID, clientID, "Unbearable!")
					if error ~= ts3errors.ERROR_ok then
						print("Error onClientMove-kickServer: " .. error)
					end
				end
			end
			]]--
		end
	end
end

-- DETECTION DU RECORD
function onUpdateClientEvent(serverConnectionHandlerID, clientID )
	if activePlugin then
		local clientRecStatus, error = ts3.getClientVariableAsInt(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_IS_RECORDING)
		print("Status : " .. clientRecStatus .. "sur client " .. clientID)
			if clientRecStatus == 1 then
				ts3.requestClientKickFromChannel(serverConnectionHandlerID, clientID, "NO RECORD!")
			end
	end	
end

-- AUTOKICKBACK (fonction sur kickChannel - avec kickChannel au retour)

function onClientKickFromChannelEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, kickerID, kickerName, kickerUniqueIdentifier, kickMessage)
	if activePlugin then
		-- Recup de son ID
		local ownID = getOwnID(serverConnectionHandlerID)
		
		
			-- Si le kick est sur moi (et pas de moi)
			if clientID == ownID  and ownID ~= kickerID then
				-- Retour dans le canal
				local error = ts3.requestClientMove(serverConnectionHandlerID, ownID, oldChannelID, "")
				if error ~= ts3errors.ERROR_ok then
					print("Error AutoKickBack-ClientMove: " .. error)
				
				else
					if autoKickBack then
						-- Une fois revenu kickChannel du kicker
						error = ts3.requestClientKickFromChannel(serverConnectionHandlerID, kickerID, "Kicker!")
						if error ~= ts3errors.ERROR_ok then
							print("Error AutoKickBack-ClientKick: " .. error)
						end
					end
				
				end
			end
	end
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

-- Fonction kickChannel lors d'un lien ts3server dans le chat
function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message)
	if activePlugin then	
		if targetMode == 2 then
			-- Recup de son ID
			local ownID = getOwnID(serverConnectionHandlerID)
			
			-- Si le lien vient d'un autre
			if ownID ~= fromID then
				-- Si le kick link est activé
				if kickLink then
					if string.find (message, "ts3server:" ) ~= nil then
						ts3.requestClientKickFromChannel(serverConnectionHandlerID, fromID, "The TS3 links are NOT ALLOWED!")
					elseif string.find (message, '%d+%.%d+%.%d+%.%d') ~= nil then
						
						-- Verification des adresses IP autorisées
						if string.find(message, '192.168') ~= nil then
							print("IP 192.168 OK")
						elseif string.find(message, '127.0.0') ~= nil then
							print("IP 127.0.0 OK")
						else
							ts3.requestClientKickFromChannel(serverConnectionHandlerID, fromID, "The IP addresses are NOT ALLOWED!")
						end
						
					end
				end
			end
		end
	end
end


public_events = {
	onClientMoveEvent = onClientMoveEvent,
	onTextMessageEvent = onTextMessageEvent,
	onConnectStatusChangeEvent = onConnectStatusChangeEvent
}
