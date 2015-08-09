pluginCMD = 1

ts3.printMessageToCurrentTab("Loading CMD Send Test Script")

-- function cmdsend(serverConnectionHandlerID, pluginCMD)
function cmdsend(serverConnectionHandlerID)
	ts3.printMessageToCurrentTab("Sending Plugin Command: "..pluginCMD.." on schID: "..serverConnectionHandlerID)
	ts3.sendPluginCommand(serverConnectionHandlerID, pluginCMD, 4, NIL)
	ts3.printMessageToCurrentTab("Sended Plugin Command: "..pluginCMD.." on schID: "..serverConnectionHandlerID)
end

ts3.printMessageToCurrentTab("Loading of CMD Send Script finished!")