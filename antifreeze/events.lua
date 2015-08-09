-- Anti-Freeze 1.06 by Screech
--
-- Antifreeze callback functions
--
require("ts3defs")
require("ts3errors")

local bugString1 = "%[img%]//"
local bugString2 = 'width="999999999'
local bugString3 = "%[img%]\\\\" -- thanks to d3dx9 for bringing to my attention.

	
local function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
	return screenMessage(serverConnectionHandlerID, fromID, fromName, fromUniqueIdentifier, message) 
end

local function onClientPokeEvent(serverConnectionHandlerID, fromID, fromName, message, ffIgnored)
	local fromUniqueIdentifier = ""
	return screenMessage(serverConnectionHandlerID, fromID, fromName, fromUniqueIdentifier, message)
end 

function screenMessage(serverConnectionHandlerID, fromID, fromName, fromUniqueIdentifier, message)
	local exploitDetected = ""
	local retVal = 1
	local error = ts3errors.ERROR_ok
	local myClientID, myCIDerror = ts3.getClientID(serverConnectionHandlerID)
	if myCIDerror == ts3errors.ERROR_ok and fromID == myClientID then return 0 end
	local lowMessage = string.lower(message)
	if string.match(lowMessage, bugString1) or string.match(lowMessage, bugString3) then exploitDetected = "has attempted to freeze clients!!!!"
	elseif string.match(lowMessage, bugString2) then exploitDetected = "has attempted to clear everyone's chat!"
	else retVal = 0
	end 
	if retVal == 1 then 
		if string.len(fromUniqueIdentifier) == 0 then 
			fromUniqueIdentifier, error = ts3.getClientVariableAsString(serverConnectionHandlerID, fromID, ts3defs.ClientProperties.CLIENT_UNIQUE_IDENTIFIER)
		end 
		if error == ts3errors.ERROR_ok and string.len(fromUniqueIdentifier) ~= 0 then 
			local nameNoSpace = string.gsub(fromName, "( )", "%%20")
			ts3.printMessageToCurrentTab("[URL=client://" .. fromID .. "/" .. fromUniqueIdentifier .. "=~" ..  nameNoSpace .. "]" .. fromName .. " (CID=" .. fromID .. ") [UID=" .. fromUniqueIdentifier .. "][/URL] [b][color=red]" .. exploitDetected .."[/color][/b]")
		else
			ts3.printMessageToCurrentTab("[b][color=red]" .. fromName .. " " .. exploitDetected .. "[/color][/b]")
		end 
		error = ts3.playWaveFile(serverConnectionHandlerID, "plugins/lua_plugin/antifreeze/alert.wav") 
	end 
	return retVal
end

function removeOldCppVersion()
	local pluginDir = "./plugins/"
	os.remove (pluginDir .. "antifreeze/antifreeze_changelog.txt")
	os.remove (pluginDir .. "antifreeze/antifreeze_readme.txt")
	os.remove (pluginDir .. "antifreeze/")
	os.remove (pluginDir .. "antifreeze_win32.dll")
	os.remove (pluginDir .. "antifreeze_x64.dll")
end

Antifreeze_events = {
	onTextMessageEvent = onTextMessageEvent,
	onClientPokeEvent = onClientPokeEvent,
}

removeOldCppVersion()