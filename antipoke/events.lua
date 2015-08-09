function ignorepokes(serverConnectionHandlerID, Zahl)
        id = Zahl
        if id == 1 then
                ts3.printMessageToCurrentTab("Du hast Poke Ignore aktiviert")
        elseif id == 0 then
                ts3.printMessageToCurrentTab("Du hast Poke Ignore deaktiviert")
        end
end
 
function onClientPokeEvent(serverConnectionHandlerID, pokerID, pokerName, message, ffIgnored)
    ts3.printMessageToCurrentTab("Du wurdest von " .. pokerName .. " mit der Nachricht \"" .. message .. "\" angestupst.")
        local retVal = id
    for script,events in pairs(ts3RegisteredModules) do
        if events.onClientPokeEvent ~= nil then
            local result = events.onClientPokeEvent(serverConnectionHandlerID, pokerID, pokerName, message, ffIgnored)
            if result > 0 then
                retVal = 1  -- If at least one Lua module returns 1, this function will also return 1 and let the client ignore the poke
            end
        end
    end
        return retVal  -- Return 0: Client will handle the poke as usual. Return 1: Client will ignore the poke.
end

antipoke_events = {
	onClientPokeEvent = onClientPokeEvent
}