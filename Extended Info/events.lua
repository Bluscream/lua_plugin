require("Extended Info/functions")
function onConnectStatusChangeEvent(serverConnectionHandlerID, status, errorNumber)
	if status ~= ts3defs.ConnectStatus.STATUS_CONNECTION_ESTABLISHED then
		return
	end	
	EI_ServerDataRequested = true
	ts3.requestServerVariables(serverConnectionHandlerID)
end

function onServerUpdatedEvent(serverConnectionHandlerID)
	if EI_ServerDataRequested == true then
		-- ts3.printMessageToCurrentTab("[[color=black]"..os.time().."[/color]] -= Extended Info Chat Frame =-")
		local server_name = ts3.getServerVariableAsString(serverConnectionHandlerID, ts3defs.VirtualServerProperties.VIRTUALSERVER_NAME)
		ScriptLog("Connected to: "..server_name)
		-- ts3.printMessageToCurrentTab("[[color=black]"..os.time().."[/color]] -= Extended Info Chat Frame =-")
		EI_ServerDataRequested = false
	end
end

function onClientMoveEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, moveMessage)
	local clientTYPE = ts3.getClientVariableAsInt(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_TYPE)
	if clientTYPE == 1 then
		if oldChannelID == 0 or oldChannelID == "0" then
			local nickName = ts3.getClientVariableAsString(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_NICKNAME)
			local uniqueID = ts3.getClientVariableAsString(serverConnectionHandlerID,clientID,ts3defs.ClientProperties.CLIENT_UNIQUE_IDENTIFIER)
			local nickNameEncoded = urlencode(nickName)
			local newChannel = ts3.getChannelVariableAsString(serverConnectionHandlerID, newChannelID, ts3defs.ChannelProperties.CHANNEL_NAME)
			local timestamp = os.date("%X")
			ts3.printMessageToCurrentTab(" [color=grey]\\_/[/color] [color=green]<" .. timestamp .. "> [URL=client://" .. clientID .. "/" .. uniqueID .. "~" .. nickNameEncoded .. "]\"" .. nickName .. "\"[/url] connected to Channel [URL=channelid://" .. newChannelID .. "]" .. newChannel .. "[/url] as Query[/color]")
		end
		if newChannelID == 0 or newChannelID == "0" then
			if isempty(moveMessage) then
				local timestamp = os.date("%X")
				ts3.printMessageToCurrentTab(" [color=grey]\\_/[/color] [color=blue]<" .. timestamp .. "> Query Client #" .. clientID .. " disconnected[/color]")
			else
				local timestamp = os.date("%X")
				ts3.printMessageToCurrentTab(" [color=grey]\\_/[/color] [color=blue]<" .. timestamp .. "> Query Client #" .. clientID .. " disconnected with message \"" .. moveMessage .. "\"[/color]")
			end
		end
-- elseif clientTYPE == 0 then
	-- local nickName = ts3.getClientVariableAsString(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_NICKNAME)
	-- local uniqueID = ts3.getClientVariableAsString(serverConnectionHandlerID,clientID,ts3defs.ClientProperties.CLIENT_UNIQUE_IDENTIFIER)
	-- local nickNameEncoded = urlencode(nickName)
	end
end

function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
	if ffIgnored == 0 and string.len(message) > 400 then
		local nickNameEncoded = urlencode(fromName)
		ts3.printMessageToCurrentTab(" [color=green]\\./[/color] [color=black]<" .. os.date("%X") .. "> Last long message posted by [URL=client://" .. fromID .. "/" .. fromUniqueIdentifier .. "~" .. nickNameEncoded .. "]\"" .. fromName .. "\"[/url]. (Length: [/color][color=blue]"..string.len(message).."[/color][color=black])[/color]")
	end
end

ei_events = {
	onConnectStatusChangeEvent = onConnectStatusChangeEvent,
	onServerUpdatedEvent = onServerUpdatedEvent,
	onClientMoveEvent = onClientMoveEvent,
	onTextMessageEvent = onTextMessageEvent
}