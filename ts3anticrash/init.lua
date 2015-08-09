--(c) by Tobias Schramm 2014

require("ts3init")

local MODULE_NAME = "img_autoban"
local autoban = false
local sendbanmsg = false

local function onTextMessage(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
	if(string.find(message, "[img", 1, true)) then
		message = message:lower()
		height = message:find("height", 1 ,true)
		width = message:find("width", 1 ,true)
		imgcnt = 0
		str = message
		i = string.find(str, '[img', 1, true)
		while(i) do
			imgcnt = imgcnt + 1
			str = string.sub(str, i)
			i = string.find(str, '[img', 2, true)
		end
		print("##########Message stats##########")
		print("[img] tags: "..imgcnt)
		print("[img] hasWidth: "..(width and "yes" or "no"))
		print("[img] hasHeight: "..(height and "yes" or "no"))
		print("[img] malicious: "..((imgcnt >= 1 and (width or height)) and "yes" or "no"))
		print("#################################")
		if(imgcnt >= 3 or (imgcnt >= 1 and (width or height))) then
			me = ts3.getClientID(serverConnectionHandlerID)
			if(autoban) then
				ts3.banclient(serverConnectionHandlerID, fromID, 0, "Banned by tSYS-Autoban for: bugusing");
				if(sendbanmsg) then
					channel = ts3.getChannelOfClient(serverConnectionHandlerID, me)
					ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "User "..fromID.." banned for bugusing.", channel)
				end
			end
			fromName = fromName:gsub("[%[%]]","")
			ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "Blocked malicious message from '"..fromName.."'", me)
			return 1 --Ignore message
		end
	end
	return 0
end

local events = {onTextMessageEvent = onTextMessage}

ts3RegisterModule(MODULE_NAME, events)