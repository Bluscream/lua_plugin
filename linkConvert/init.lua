require("ts3init")  
linkConvert = {
	info = {
		name = "Link Converter",
		prefix = "LC",
		folder = "linkConvert",
		ext = "lua",
		ver = "1.0",
		author = "Bluscream",
	},
	setting = { -- Edit below this line! --
		active = true, -- Enable the script.
		debug = true, -- The script shows debug messages.
	},
	functions = {
		protocols = true, -- Should protocols be reparsed?
		lmgtfy = true, -- Should we allow google'ing etc?
		lmgtfy_prefix = "!",
	},		    -- Edit above this line! --
	protocols = { "steam://", "minecraft://", "repz://", "channelid://"}
	-- commands = { "ip" = "http://whatismyipaddress.com/ip/%search%" }
}

local function reply(sCHID, msg, mode, target)
	oldMSG = msg
	if mode == 1 and target then
		ts3.requestSendPrivateTextMsg(sCHID, msg, target)
	elseif mode == 2 then
		ts3.requestSendChannelTextMsg(sCHID, msg, ts3.getChannelOfClient(sCHID, ts3.getClientID(sCHID)))
	elseif mode == 3 then
		ts3.requestSendServerTextMsg(sCHID, msg)
	else
		ts3.printMessageToCurrentTab(msg)
	end
end

local function lmgtfy(sCHID, message, targetMode, fromID)
	if string.match( message, linkConvert.functions.lmgtfy_prefix ) then
		for i=1, #linkConvert.commands do
			local command = string.match( message, linkConvert.commands[i][1] )	
			local returner = string.match( message, linkConvert.commands[i][2] )	
		end
		local sendMsg = string.gsub( message, "!whois", "" )
	end
end

local function onTextMessageEvent(sCHID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
	if not oldMSG then oldMSG = "" end
	if linkConvert.setting.active and oldMSG ~= message then
		str = nil
		-- TeamViewer Session
		local str = string.match(message, 's%d%d%-%d%d%d%-%d%d%d') or string.match(message, '%d%d%d% %d%d%d% %d%d%d')
		if str then
			reply(sCHID, "Join TeamViewer session via [url=tvjoinv8://go.teamviewer.com?mid="..str:gsub("%-", "").."]Client[/url] or [url=http://get.teamviewer.com/v11/"..str:gsub("%-", "").."]Web[/url]", targetMode, fromID)
		end
		str = nil
		-- TeamViewer Meeting
		local str = string.match(message, 'm%d%d%-%d%d%d%-%d%d%d')
		if str then
			str = str:gsub("%-", "");str = str:gsub("%s", "");
			reply(sCHID, "Join TeamViewer meeting via [url=tvjoinv8://go.teamviewer.com?mid="..str.."]Client[/url] or [url=https://go.teamviewer.com/v11/flash.aspx?tid="..str.."&lng=de]Web[/url]", targetMode, fromID)
		end
		str = nil
		-- IPs
		local s = string.match(message, '%d+%.%d+%.%d+%.%d+%:%d+'); local s2 = string.match(message, '%d+%.%d+%.%d+%.%d+')
		if s then str = s elseif s2 then str = s2 end
		s = nil; s2 = nil;
		if str then
			reply(sCHID,"[url=http://"..str.."]Web[/url] | [url=ts3server://"..str.."]TS³ Server[/url] |[url=minecraft://"..str.."]MC Server[/url]", 0, fromID)
		end
		str = nil
		-- if linkConvert.function.protocols then
			for i, protocol in ipairs(linkConvert.protocols) do
				if string.match(message, protocol.."[^%s]*") and ts3.getClientID(sCHID) ~= fromID then
					reply(sCHID,"[url]"..string.match(message, protocol.."[^%s]*").."[/url]", targetMode, fromID)
				end
			end
		-- end
		-- if linkConvert.function.lmgtfy then -- LMGTFY
			-- lmgtfy(sCHID, message, targetMode, fromID)
		-- end
	end
	local afkMSG = "Du bist nun seit 15 abwesend. Wenn du 20 Minuten abwesend bist wirst du zu \"Bot - AFK\" verschoben!"
	if message == afkMSG and ts3.getClientID(sCHID) ~= fromID then
		ts3.requestSendPrivateTextMsg(sCHID, "AntiAFK", fromID)
	end
end

local events = {
	onTextMessageEvent = onTextMessageEvent
}
ts3.printMessageToCurrentTab(linkConvert.info.name.." loaded.")
ts3RegisterModule(linkConvert.info.name, events)