

local function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
	local fullmessage = string.lower(message)
	local cmd = string.sub(fullmessage ,1,string.find(fullmessage, "%("))

	if cmd=="wonder(" or cmd=="w(" then
		local parameterString = string.sub(fullmessage,string.find(fullmessage,"%(")+1,string.find(fullmessage,")")-1)
		local rollCount = string.sub(parameterString,1,string.find(parameterString ,",")-1)
		local itemLevel = string.sub(parameterString,string.find(parameterString,",")+1)
		if tonumber(rollCount)>=1 and tonumber(itemLevel)>=1 and tonumber(itemLevel)<=3 then
			local channelData = ts3.getChannelOfClient(serverConnectionHandlerID, fromID)
			local roll = 0
			local sendMsg =  "[b]["..fromName.."][/b] rolled for "..rollCount.." wonderous item(s):\n"
			math.randomseed(tonumber(tostring(os.clock()):reverse():sub(1,6)))
			math.random()
			math.random()
			math.random()
			math.randomseed(tonumber(tostring(os.clock()):reverse():sub(1,6))+math.random())
			math.random()
			math.random()
			math.random()
			for i=1,rollCount,1 do
				math.random()
				math.random()
				math.random()
				roll = math.random(100)
				sendMsg = sendMsg..i..". = "
				if tonumber(itemLevel)==1 then
					sendMsg = sendMsg.."[b]"..wi_minor[roll].."[/b]\n"
				elseif tonumber(itemLevel)==2 then
					sendMsg = sendMsg.."[b]"..wi_medium[roll].."[/b]\n"
				else
					sendMsg = sendMsg.."[b]"..wi_major[roll].."[/b]\n"
				end
			end
			ts3.requestSendChannelTextMsg(serverConnectionHandlerID, sendMsg, channelData)
		end
	end
	return 0
end

itemroll_events = {
	onTextMessageEvent = onTextMessageEvent
}