local function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
    print("xlife: onTextMessageEvent: " .. serverConnectionHandlerID .. " " .. targetMode .. " " .. toID .. " " .. fromID .. " " .. fromName .. " " .. fromUniqueIdentifier .. " " .. message .. " " .. ffIgnored)
	return 0
end

local function onPluginCommandEvent(serverConnectionHandlerID, pluginName, pluginCommand)
	print("xlife: onPluginCommandEvent: " .. serverConnectionHandlerID .. " " .. pluginName .. " " .. pluginCommand)
end

xlife_mp_events = {
	onTextMessageEvent = onTextMessageEvent,
	onPluginCommandEvent = onPluginCommandEvent
}
