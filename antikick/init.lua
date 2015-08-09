--
-- test plugin
--

local password = nil

--local channelID = 0

require("ts3init")

local function onClientKickFromChannelEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, kickerID, kickerName, kickerUniqueIdentifier, kickMessage)  
  
 local myID = ts3.getClientID(serverConnectionHandlerID)
  
  if myID == clientID then
   local channelID, error = ts3.getChannelIDFromChannelNames(
		serverConnectionHandlerID, channelNames)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting ChannelID: "  .. error)
	end
   end
	
	if channelID ~= oldChannelID then
		ts3.requestClientMove(
			serverConnectionHandlerID,
			myID,
			oldChannelID,
			password)
	return
    end
end

local registeredEvents = {
	onClientKickFromChannelEvent = onClientKickFromChannelEvent
}

ts3RegisterModule("antikick", registeredEvents)