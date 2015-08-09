-- math.randomseed( os.time() + math.random(1,9999) )

-- local nameArray = { 'Zur miefenden Mauke - Lokal', 'Blus Matrix', 'Was geeeht ab?' }
-- local channelName = ( nameArray[ math.random( #nameArray ) ] )
-- local parentChannelPath = {"User Channels", ""}
-- local channelPath = {"User Channels", channelName, ""}
-- local channelPassword = ""
-- local channelNeededTP = "62"
-- local channelCodec = "4"
-- local channelCodecQuality = "10"
-- local channelTopic = "Bluscream's Channel | Bitte keine Beleidigungen"

-- used internal, don't set
local channelID = 0

require("ts3init")

local function onConnectStatusChangeEvent(serverConnectionHandlerID, status, errorNumber)
	if status ~= ts3defs.ConnectStatus.STATUS_CONNECTION_ESTABLISHED then
		return
	end
	
	math.randomseed( os.time() + math.random(1,9999) )
	
	createChannel(serverConnectionHandlerID, "blu", "1")

	-- local clientID, error = ts3.getClientID(serverConnectionHandlerID)
	-- if error ~= ts3errors.ERROR_ok then
		-- print("Failed to get ClientID: " .. error)
		-- return
	-- end

	-- local channelID, error = ts3.getChannelIDFromChannelNames(
		-- serverConnectionHandlerID, channelPath)
	-- if error ~= ts3errors.ERROR_ok then
		-- print("Error getting ChannelID: "  .. error)
		-- return
	-- end
	
	-- if channelID ~= 0 then
		-- ts3.requestClientMove(
			-- serverConnectionHandlerID,
			-- clientID,
			-- channelID,
			-- channelPassword)
		-- return
	-- end

	-- local parentChannelID, error = ts3.getChannelIDFromChannelNames(
		-- serverConnectionHandlerID, parentChannelPath)
	-- if error ~= ts3errors.ERROR_ok then
		-- print("Error getting parent ChannelID: "  .. error)
		-- return
	-- end
	
	-- local sysDateTime = os.date("%d.%m.%Y %X")
	-- local nickName = ts3.getClientVariableAsString(serverConnectionHandlerID, clientID, 1)
	-- local createdString = " || \""..nickName.."\" || "..sysDateTime
	-- local channelTopic = channelTopic..createdString
	
	-- if not isempty(channelName) then
		-- ts3.setChannelVariableAsString(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_NAME,channelName)
	-- end
	
	-- if not isempty(channelNamePhonetic) then
	-- ts3.setChannelVariableAsString(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_NAME_PHONETIC,channelNamePhonetic)
	-- end
	
	-- if not isempty(channelPassword) then
	-- ts3.setChannelVariableAsString(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_PASSWORD,channelPassword)
	-- end
	
	-- if not isempty(channelTopic) then
	-- ts3.setChannelVariableAsString(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_TOPIC,channelTopic)
	-- end
	
	-- if not isempty(channelDescription) then
	-- ts3.setChannelVariableAsString(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_DESCRIPTION,channelDescription)
	-- end
	
	-- if not isempty(channelMaxClients) then
	-- ts3.setChannelVariableAsInt(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_MAXCLIENTS,channelMaxClients)
	-- end
	
	-- if not isempty(channelNeededTP) then
	-- ts3.setChannelVariableAsInt(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_NEEDED_TALK_POWER,channelNeededTP)
	-- end
	
	-- if not isempty(channelIconID) then
	-- ts3.setChannelVariableAsInt(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_ICON_ID,channelIconID)
	-- end
	
	-- if not isempty(channelIsSemi) then
	-- ts3.setChannelVariableAsInt(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_FLAG_SEMI_PERMANENT,channelIsSemi)
	-- end
	
	-- if not isempty(channelCodec) then
	-- ts3.setChannelVariableAsString(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_CODEC,channelCodec)
	-- end
	
	-- if not isempty(channelCodecQuality) then
	-- ts3.setChannelVariableAsInt(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_CODEC_QUALITY,channelCodecQuality)
	-- end
	

	-- local error = ts3.flushChannelCreation(
		-- serverConnectionHandlerID,
		-- parentChannelID)
	-- if error ~= ts3errors.ERROR_ok then
		-- print("Error creating channel: "  .. error)
		-- return
	-- end
end

local function isempty(s)
  return s == nil or s == ''
end

local registeredEvents = {
	onConnectStatusChangeEvent = onConnectStatusChangeEvent
}

-- Register your callback functions with a unique module name.
ts3RegisterModule("AutoCreate", registeredEvents)
