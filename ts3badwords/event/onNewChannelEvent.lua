function onNewChannelEvent(serverConnectionHandlerID, channelID, channelParentID)

--print("on new channel event START: " .. serverConnectionHandlerID, channelID, channelParentID)
--print (ccname(serverConnectionHandlerID, channelID))

--print (cctopic(serverConnectionHandlerID, channelID))
--print(ccdesc(serverConnectionHandlerID, channelID))
--print(cphonetic(serverConnectionHandlerID, channelID))
local ccname = ts3.getChannelVariableAsString(serverConnectionHandlerID, channelID, 0)
local cctopic = ts3.getChannelVariableAsString(serverConnectionHandlerID, channelID, 1)
--local ccdesc = ts3.getChannelVariableAsString(serverConnectionHandlerID, channelID, 2)
local cphonetic = ts3.getChannelVariableAsString(serverConnectionHandlerID, channelID, 30)
local data = read_word()
--local bb = ts3.urlsToBB("Kanał o nazwie [url=channelid://".. channelID .. "]" .. ccname .. ")
--local channel_info = "Kanał o nazwie " .. ccname .. "(id:" .. channelID .. ")"
local channel_info = "try test [url=channelid://" .. channelID .. "]" .. ccname .. "[/url]"
	for m,v in ipairs(data) do 
	--print("execute for " .. v .. "and channel ID" .. channelID)
	if string.find(ccname, v) then msg_p(serverConnectionHandlerID,ts3chanelbadname .. channel_info,ts3.getClientID(serverConnectionHandlerID)) end
	if string.find(cctopic, v) then msg_p(serverConnectionHandlerID,ts3chanelbadtopic .. channel_info,ts3.getClientID(serverConnectionHandlerID)) end
	if string.find(ccdesc(serverConnectionHandlerID, channelID), v) then 
	print("found bad desc in " .. channelID) msg_p(serverConnectionHandlerID,ts3chanelbaddesc .. channel_info,ts3.getClientID(serverConnectionHandlerID)) end
	if string.find(cphonetic, v) then msg_p(serverConnectionHandlerID,ts3chanelbadphonetic .. channel_info,ts3.getClientID(serverConnectionHandlerID)) end
	end

end	


