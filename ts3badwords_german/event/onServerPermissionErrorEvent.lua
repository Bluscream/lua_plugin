function onServerPermissionErrorEvent(serverConnectionHandlerID, errorMessage, errorCode, failedPermissionID)

	
	local qwe_mychannelid = ts3.getChannelOfClient(serverConnectionHandlerID, ts3.getClientID(serverConnectionHandlerID))

		msg_c(serverConnectionHandlerID, errorMessage .. " error code: " .. errorCode .. " failed perm id " .. failedPermissionID , qwe_mychannelid)


end