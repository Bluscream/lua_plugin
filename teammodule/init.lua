require("ts3init")  
local MODULE_NAME = "teammodule"
local lastMeeting
local open_cmd

local function open_url(url)
    if not open_cmd then
        if package.config:sub(1,1) == '\\' then 
            open_cmd = function(url)
                os.execute(string.format('start /B %s', url))
            end
        elseif (io.popen("uname -s"):read'*a') == "Darwin" then 
            open_cmd = function(url)
                os.execute(string.format('open "%s" &', url))
            end
        else 
            open_cmd = function(url)
                os.execute(string.format('xdg-open "%s" &', url))
            end
        end
    end
    open_cmd(url)
end

local function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
	local selfID = ts3.getClientID(serverConnectionHandlerID)
    local str = string.match(message, '(m%d%d%-%d%d%d%-%d%d%d)')
	if str and fromID ~= selfID then
		lastMeeting = str:gsub("%-", "")
		ts3.printMessageToCurrentTab("[url=tvjoinv8://go.teamviewer.com?mid=" .. lastMeeting .. "] Join " .. fromName .. "'s meeting [/url]")
		return
	end
	if (message == "j" or message == "join") and lastMeeting and fromID == selfID then
		open_url("start tvjoinv8://go.teamviewer.com?mid="..lastMeeting)
	end
end

local events = {
	onTextMessageEvent = onTextMessageEvent,
	onConnectStatusChangeEvent = onConnectStatusChangeEvent
}
ts3RegisterModule(MODULE_NAME, events)