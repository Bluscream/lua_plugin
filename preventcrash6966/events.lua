local function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
    return receiveMessage(serverConnectionHandlerID, fromID, fromName, fromUniqueIdentifier, message)
end

local function onClientPokeEvent(serverConnectionHandlerID, pokerID, pokerName, message, ffIgnored)
	return receiveMessage(serverConnectionHandlerID, pokerID, pokerName, "", message)
end

function receiveMessage(serverConnectionHandlerID, fromID, fromName, fromUniqueIdentifier, message)
	local retVal = 0
	local exploitAlert
	for i = 1, #message do
		local c = string.byte(message, i)
		--print(i .. ":" .. c)
		if c == 225 then
			retVal = 1
			exploitAlert = "sent you an unsupported character may cause a client crash."
			break
		end
	end
	if retVal == 1 then 
		if string.len(fromUniqueIdentifier) == 0 then
			fromUniqueIdentifier, error = ts3.getClientVariableAsString(serverConnectionHandlerID, fromID, ts3defs.ClientProperties.CLIENT_UNIQUE_IDENTIFIER)
			-- if (error ~= ts3errors.ERROR_ok)
			-- 	fromUniqueIdentifier = ""
			-- end
		end
		local clientUrlOrName
		if string.len(fromUniqueIdentifier) ~= 0 then
			clientUrlOrName = "[URL=client://" .. fromID .. "/" .. fromUniqueIdentifier .. "~]" .. fromName .. "[/URL]"
		else
			clientUrlOrName = fromName
		end
		ts3.printMessageToCurrentTab("[color=purple][i]PreventCrash6966 by Energeek/Boumz[/i] :[/color] [b][color=red]" .. clientUrlOrName .. "[/color] [color=grey]" .. exploitAlert .. "[/color][/b]")
	end 
	return retVal
end

preventcrash6966_events = {
	onTextMessageEvent = onTextMessageEvent,
	onClientPokeEvent = onClientPokeEvent,
}
