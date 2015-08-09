require("ts3defs")
require("ts3errors")

lastURL = " "

-- OS is determined by checking for default directories
-- That is offcourse unless you are running Windows
-- Windows is determined by checking for starting with \ instead of /
myOS = " "
local fileHandle = io.open("/home/")
if fileHandle ~= nil then
	io.close(fileHandle)
	myOS = "Linux"
else
	if string.sub(package.config, 1, 1) == "\\" then
		myOS = "Windows"
	else
		fileHandle = io.open("/Applications/")
		if fileHandle ~= nil then
			io.close(fileHandle)
			myOS = "Mac"
		end
	end
end
if myOS == " " then
	ts3.printMessageToCurrentTab("OS could not be determined")
end

-- pastes what is in your clipboard in the channel chat
function pasteClipboard(serverConnectionHandlerID)
	-- Stores the message to be sent to the chat
	local message = " "
	-- Gets users id for sending message to chat
	local myClientID = ts3.getClientID(serverConnectionHandlerID)
	-- Gets channel id for sending message to chat
	local myChannelID = ts3.getChannelOfClient(serverConnectionHandlerID, myClientID)
	local clipboard
	if myOS == "Windows" then
		clipboard = io.popen("clipboard.exe")
	elseif myOS == "Linux" then
		clipboard = io.popen("echo $(xclip -o)")
	elseif myOS == "Mac" then
		clipboard = io.popen("echo $(pbpaste)")
	end

	-- If the clipboard contains text set message equal to the clipboard
	if clipboard ~= nil then
		message = string.sub(clipboard:read("*a"), 1, -2)
	else
		ts3.printMessageToCurrentTab("Nothing was found on your clipboard")
	end

	-- Checks if the text is a URL and formats it accordingly
	if string.sub(message, 1, 7) == "http://" or string.sub(message, 1, 8) == "https://" then
		-- Adds formatting to make link clickable
		message = "[url]"..message.."[/url]"
	end

	-- Sends message to the current channel
	ts3.requestSendChannelTextMsg(serverConnectionHandlerID, message, myChannelID)
end

-- Checks the message provided and stores it if it is a URL
function receiveMsg(message)
	-- Checks if last message was a url and stores it if it was
	if string.find(message, "%[[uU][rR][lL]%]") ~= nil and string.find(message, "%[/[uU][rR][lL]%]") ~= nil then
		-- Gets only text inside the URL tags
		lastURL = string.match(message, '%[[uU][rR][lL]%].-%[/[uU][rR][lL]%]')
		-- Removes URL tags
		lastURL = string.sub(lastURL, 6, -7)
	end
end

-- Opens last URL that was retrieved by the function receiveMsg
function openLastURL()
	-- Opens last URL based upon the system you are running
	if myOS == "Linux" then
		os.execute("xdg-open "..lastURL)
	elseif myOS == "Windows" then
		os.execute("start "..lastURL)
	elseif myOS == "Mac" then
		os.execute("open "..lastURL)
	end
end

LinksPlus = {
	pasteClipboard = pasteClipboard,
	receiveMsg = receiveMsg,
	openLastURL = openLastURL
}
