RoomEx = {}

RoomEx_defs = {
	ChannelToken = "roomex-active"
}

local roomex_token = "roomex-active"

function RoomEx.onMove(serverConnectionHandlerID, clientID, oldChannelID, newChannelID)
	if RoomEx.isChannelEnabled(serverConnectionHandlerID, newChannelID) == true then
		RoomEx.UserCheckIn(serverConnectionHandlerID, clientID, newChannelID)
	end
end

function RoomEx.isChannelEnabled(serverConnectionHandlerID, ChannelID)
	Channel_topic, err = ts3.getChannelVariableAsString(serverConnectionHandlerID, ChannelID, ts3defs.ChannelProperties.CHANNEL_TOPIC)
	if string.lower(Channel_topic) == RoomEx_defs.ChannelToken then
		return true
	else
		return false
	end
end

function RoomEx.UserCheckIn(serverConnectionHandlerID, clientID, channelID)
	Channel_Description, err = ts3.getChannelVariableAsString(serverConnectionHandlerID, channelID, ts3defs.ChannelProperties.CHANNEL_DESCRIPTION)
	
	start = 0
	start = string.find(Channel_Description, "\n\n%[b%]--- Extra Room Info ---%[/b%]")
	-- print(Channel_Description)
	
	if start == nil then
		start = string.find(Channel_Description, "\n%[b%]--- Extra Room Info ---%[/b%]")
		
		if start == nil then start = 0 end
	end
	
	Channel_Description_Extra = "\n\n\[b\]--- Extra Room Info ---\[/b\]\n"
	a = "Last Visitor: " .. ts3.getClientVariableAsString(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_NICKNAME)
	a2 = " (" .. os.date() .. " - CET)\n"
	
	-- this place is messy, just wanted to make it work
	
	b, bb = string.find(Channel_Description, "Total visitors: ")
	if b ~= nil then
		b2, b3 = string.find(Channel_Description, "Total visitors: %d+")
		connections = string.sub(Channel_Description,bb+1,b3)
		b4 = "Total visitors: " .. tonumber(connections)+1 .. "\n"
	else
		b4 = "Total visitors: " .. "1\n"
	end
	
	Channel_Description = string.sub(Channel_Description, 0, start-1)
	
	ts3.setChannelVariableAsString(serverConnectionHandlerID, channelID, ts3defs.ChannelProperties.CHANNEL_DESCRIPTION, Channel_Description .. Channel_Description_Extra .. a .. a2 .. b4)
	ts3.flushChannelUpdates(serverConnectionHandlerID, channelID)
end