local function onClientPokeEvent(serverConnectionHandlerID, pokerID, pokerName, message, ffIgnored)
	local pokemenot = "Don't poke me  " .. pokerName .. "..."
    ts3.requestClientPoke(serverConnectionHandlerID, pokerID, pokemenot)
end