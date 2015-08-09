require("ts3init")
function onServerErrorEvent(serverConnectionHandlerID, errorMessage, errorCode, extraMessage)
	ts3.printMessageToCurrentTab(os.date("[%x %X]").." onServerErrorEvent: serverConnectionHandlerID="..serverConnectionHandlerID.." | errorMessage="..errorMessage.." | errorCode="..errorCode.." | extraMessage="..extraMessage)
end
function onServerPermissionErrorEvent(serverConnectionHandlerID, errorMessage, errorCode, failedPermissionID)
	-- local errormsg = ts3.getErrorMessage(errorCode)
	ts3.printMessageToCurrentTab(os.date("[%x %X]").." onServerPermissionErrorEvent: serverConnectionHandlerID="..serverConnectionHandlerID.." | errorMessage="..errorMessage.." | errorCode="..errorCode.." | failedPermissionID="..failedPermissionID)
end
function onClientNeededPermissionsEvent(serverConnectionHandlerID, permissionID, permissionValue)
	ts3.printMessageToCurrentTab(os.date("[%x %X]").." onClientNeededPermissionsEvent: serverConnectionHandlerID="..serverConnectionHandlerID.." | permissionID="..permissionID.." | permissionValue="..permissionValue)
end
function onClientNeededPermissionsFinishedEvent(serverConnectionHandlerID)
	ts3.printMessageToCurrentTab(os.date("[%x %X]").." onClientNeededPermissionsFinishedEvent: serverConnectionHandlerID="..serverConnectionHandlerID .. " | getPermissionIDByName(i_channel_join_power): "..ts3.getPermissionIDByName(serverConnectionHandlerID, "i_channel_join_power").." | getClientNeededPermission(i_channel_join_power): "..ts3.getClientNeededPermission(serverConnectionHandlerID, "i_channel_join_power"))
end
local registeredEvents = {
	onServerErrorEvent = onServerErrorEvent,
	onServerPermissionErrorEvent = onServerPermissionErrorEvent,
	onClientNeededPermissionsEvent = onClientNeededPermissionsEvent,
	onClientNeededPermissionsFinishedEvent = onClientNeededPermissionsFinishedEvent
}
ts3.printMessageToCurrentTab(os.date("[%x %X]").."errorTEST\\init.lua loaded.")
ts3RegisterModule("errorTEST", registeredEvents)