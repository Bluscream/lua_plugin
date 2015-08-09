require("ts3defs")
require("ts3errors")

local SCRIPT = "LUA Channel creator"
local SCRIPTSHORT = "CC"
local VERSION = "0.5"
local AUTHOR = "B1uscr34m"
local EMAIL = "piracy@teamspeakusa.com"

-- Settings
CC_DEBUG = true
ColArray = { 'Green', 'Yellow', 'Red', 'Blue' }
RANDCOL = ( ColArray[ math.random( #ColArray ) ] )
SCRIPT_PREFIX = "[color=grey][[/color][color="..RANDCOL.."]"..SCRIPTSHORT.."[/color][color=grey]][/color]"
function ScriptLog(logMSG)
	if CC_DEBUG == true then
		local tsCol = { 'Green', 'Black', 'Red', 'Blue' }
		local RANDCOL = ( tsCol[ math.random( #tsCol ) ] )
		local scriptTimestamp = os.date("%x %X")
		ts3.printMessageToCurrentTab("[color=Black][[/color][color="..RANDCOL.."]"..scriptTimestamp.."[/color][color=Black]][/color]> "..SCRIPT_PREFIX..": "..logMSG)
		-- ts3.logMessage(logMSG, severity, channel, logID)
		-- debugPrint(logMSG)
	end
end

cc_func_auto_create = true
cc_func_auto_create_fast = true
cc_func_auto_create_mode = "pietcast"
cc_func_auto_create_number = "1"
cc_func_anti_channel_delete = true
cc_func_anti_channel_delete_mode = "old" -- old / mode
cc_func_fullString = false
UID_mtg = "LpfWDi8tO9blye3wZXZZ76uPAM8="
UID_gomme = "FI9+KF1c/BKx5dlFejAs8OJpnO0="
-- -----------------------------=LOGGING=-------------------------------------
ScriptLog("[color=".. RANDCOL .."]_-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-_[/color]")
ScriptLog("[color=darkgreen]".. SCRIPT .."[/color] [color=white][[/color][color=orange]".. VERSION .."[/color][color=white]][/color] loading...")
-- ____________________________-=LOGGING=-____________________________________
-- Variables
-- chancreate.const.menuIDs = {
	-- CREATE_CHANNEL_BIT = 1
-- }
-- chancreate.var.menuItemID = 0
local FUNCTIONS = "Creating channels like a boss ;)"
local HLPTXT = "Use [b][color=red]/lua run cc[/color][/b] to see a list of commands!"
-- -----------------------------=LOGGING=-------------------------------------
ScriptLog("[color=darkgreen]".. SCRIPTSHORT .."[/color] variables initialized.")
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
function testlog(serverConnectionHandlerID, text)
	ScriptLog(text)
end
function cc(serverConnectionHandlerID)
	local emcCol = { 'Green', 'Yellow', 'Red', 'Blue' }
	local RANDCOL = ( emcCol[ math.random( #emcCol ) ] )
	ts3.printMessageToCurrentTab("[u][color=".. RANDCOL .."]".. SCRIPT ..": [b]Commands[/b][/color][/u]")
	ts3.printMessageToCurrentTab("Show all Channel Variables: [color=red]/lua run channelCreationInfo[/color]")
	ts3.printMessageToCurrentTab("Start creating a pre-defined channel: [color=red]/lua run createChannel {channelMODE}[/color]")
	ts3.printMessageToCurrentTab("Show all available channelMODEs: [color=red]/lua run ccchannelModes[/color]")
end
function ccchannelModes(serverConnectionHandlerID)
	local emcCol = { 'Green', 'Yellow', 'Red', 'Blue' }
	local RANDCOL = ( emcCol[ math.random( #emcCol ) ] )
	ts3.printMessageToCurrentTab("[u][color=".. RANDCOL .."]".. SCRIPT ..": [b]channelMODEs[/b][/color][/u]")
	ts3.printMessageToCurrentTab("[color=red]random[/color]")
	ts3.printMessageToCurrentTab("[color=red]randomPW[/color]")
	ts3.printMessageToCurrentTab("[color=red]talk[/color]")
	ts3.printMessageToCurrentTab("[color=red]chillen[/color]")
	ts3.printMessageToCurrentTab("[color=red]gomme[/color]")
	ts3.printMessageToCurrentTab("[color=red]gommePW[/color]")
	ts3.printMessageToCurrentTab("[color=red]bit[/color]")
	ts3.printMessageToCurrentTab("[color=red]script[/color]")
	ts3.printMessageToCurrentTab("[color=red]line[/color]")
	ts3.printMessageToCurrentTab("[color=red]music[/color]")
	ts3.printMessageToCurrentTab("[color=red]musicPW[/color]")
	ts3.printMessageToCurrentTab("[color=red]iloveradio[/color]")
	ts3.printMessageToCurrentTab("[color=red]iloveradioPW[/color]")
	ts3.printMessageToCurrentTab("[color=red]ilove2dancePW[/color]")
	ts3.printMessageToCurrentTab("Everything else creates a Test Channel")
end
function cchelp()
	local emcCol = { 'Green', 'Yellow', 'Red', 'Blue' }
	local RANDCOL = ( emcCol[ math.random( #emcCol ) ] )
	ts3.printMessageToCurrentTab("[u][color=".. RANDCOL .."]".. SCRIPT ..": [b]Help[/b][/color][/u]")
	ts3.printMessageToCurrentTab("View all"..SCRIPTSHORT.." commands: [color=red]/lua run cchelp[/color]")
end
function ccinfo()
	local emcCol = { 'Green', 'Yellow', 'Red', 'Blue' }
	local RANDCOL = ( emcCol[ math.random( #emcCol ) ] )
	ts3.printMessageToCurrentTab("[u][color=".. RANDCOL .."]".. SCRIPT ..": [b]Info[/b][/color][/u]")
	ts3.printMessageToCurrentTab("[color=red]"..FUNCTIONS.."[/color]")
end
function colrandomizer()
	local myTable = { 'Green', 'Yellow', 'Red', 'Blue' }
	local RANDCOL = ( myTable[ math.random( #myTable ) ] )
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
local function checkServer(serverConnectionHandlerID)
	local serverUID = ts3.getServerVariableAsString(serverConnectionHandlerID, ts3defs.VirtualServerProperties.VIRTUALSERVER_UNIQUE_IDENTIFIER)
	if serverUID == UID_mtg then
			-- ts3.printMessageToCurrentTab("Server mtG, using plugin")
		needed_tp_ca = "13"
		needed_tp_op = "12"
		needed_tp_member = "1"
		needed_tp_guest = "0"
		codec_voice_min = "0"
		codec_voice_quality_min = "0"
		codec_voice_max = "4"
		codec_voice_quality_max = "7"
		codec_music_min = "5"
		codec_music_quality_min = "7"
		codec_music_max = "5"
		codec_music_quality_max = "7"
		cc_func_auto_create_mode = "chillen"
		cc_func_auto_create_number = ""
		return
	elseif serverUID == UID_gomme then
			--ts3.printMessageToCurrentTab('Server GommeHD, using plugin')
		needed_tp_ca = "10"
		needed_tp_op = "5"
		needed_tp_member = ""
		needed_tp_guest = "0"
		codec_voice_min = "0"
		codec_voice_quality_min = "0"
		codec_voice_max = "4"
		codec_voice_quality_max = "10"
		codec_music_min = "5"
		codec_music_quality_min = "0"
		codec_music_max = "5"
		codec_music_quality_max = "10"
		cc_func_auto_create_mode = "pietcast"
		cc_func_auto_create_number = ""
		return
	else
			-- ts3.printMessageToCurrentTab("Server ELSE, using defaults")
		needed_tp_ca = "0"
		needed_tp_op = "0"
		needed_tp_member = "0"
		needed_tp_guest = "0"
		codec_voice_min = "0"
		codec_voice_quality_min = "0"
		codec_voice_max = "4"
		codec_voice_quality_max = "10"
		codec_music_min = "5"
		codec_music_quality_min = "0"
		codec_music_max = "3"
		codec_music_quality_max = "10"
		cc_func_auto_create = false
		-- cc_func_auto_create_mode = "blu"
		-- cc_func_auto_create_number = ""
		return
	end
end
-- -----------------------------=LOGGING=-------------------------------------
if CC_DEBUG == true then
ScriptLog("Core functions loaded...")
end
-- ____________________________-=LOGGING=-____________________________________

------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--======================================================================================================================================================================
-- Channel Creator Events
--======================================================================================================================================================================
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function onConnectStatusChangeEvent(serverConnectionHandlerID, status, errorNumber)
	if cc_func_auto_create == true then
		local error = checkServer(serverConnectionHandlerID)
		if not isempty(error) then
			ts3.printMessageToCurrentTab("Error while checking server!")
		end
		if cc_func_auto_create_fast == true then
			if status ~= ts3defs.ConnectStatus.STATUS_CONNECTED then
				return
			end
			local channelCreation, error = chan(
			serverConnectionHandlerID,
			cc_func_auto_create_mode,
			cc_func_auto_create_number)
			if not isempty(error) then
				ts3.printMessageToCurrentTab("Error auto creating Channel ("  .. error .. ")")
			end
		else
			if status ~= ts3defs.ConnectStatus.STATUS_CONNECTION_ESTABLISHED then
				return
			end
			local channelCreation, error = chan(
			serverConnectionHandlerID,
			cc_func_auto_create_mode,
			cc_func_auto_create_number)
			if not isempty(error) then
				ts3.printMessageToCurrentTab("Error auto creating Channel ("  .. error .. ")")
			end
		end
	end
end
function onNewChannelCreatedEvent(serverConnectionHandlerID, channelID, channelParentID, invokerID, invokerName, invokerUniqueIdentifier)
	local ownID = ts3.getClientID(serverConnectionHandlerID)
	if invokerID == ownID then
		cc_backup_channelID = channelID
		cc_created_backup_channelName = ts3.getChannelVariableAsString(serverConnectionHandlerID, channelID, ts3defs.ChannelProperties.CHANNEL_NAME)
		cc_created_backup_channelNamePhonetic = ts3.getChannelVariableAsString(serverConnectionHandlerID, channelID, ts3defs.ChannelProperties.CHANNEL_NAME_PHONETIC)
		cc_created_backup_channelPassword = ts3.getChannelVariableAsString(serverConnectionHandlerID, channelID, ts3defs.ChannelProperties.CHANNEL_PASSWORD)
		cc_created_backup_channelTopic = ts3.getChannelVariableAsString(serverConnectionHandlerID, channelID, ts3defs.ChannelProperties.CHANNEL_TOPIC)
		cc_created_backup_channelDescription = ts3.getChannelVariableAsString(serverConnectionHandlerID, channelID, ts3defs.ChannelProperties.CHANNEL_DESCRIPTION)
		cc_created_backup_channelMaxClients = ts3.getChannelVariableAsInt(serverConnectionHandlerID, channelID, ts3defs.ChannelProperties.CHANNEL_MAXCLIENTS)
		cc_created_backup_channelNeededTP = ts3.getChannelVariableAsInt(serverConnectionHandlerID, channelID, ts3defs.ChannelProperties.CHANNEL_NEEDED_TALK_POWER)
		cc_created_backup_channelIconID = ts3.getChannelVariableAsInt(serverConnectionHandlerID, channelID, ts3defs.ChannelProperties.CHANNEL_ICON_ID)
		cc_created_backup_channelIsSemi = ts3.getChannelVariableAsInt(serverConnectionHandlerID, channelID, ts3defs.ChannelProperties.CHANNEL_FLAG_SEMI_PERMANENT)
		cc_created_backup_channelIsPerma = ts3.getChannelVariableAsInt(serverConnectionHandlerID, channelID, ts3defs.ChannelProperties.CHANNEL_FLAG_PERMANENT)
		cc_created_backup_channelIsDefault = ts3.getChannelVariableAsInt(serverConnectionHandlerID, channelID, ts3defs.ChannelProperties.CHANNEL_FLAG_DEFAULT)
		cc_created_backup_channelCodec = ts3.getChannelVariableAsString(serverConnectionHandlerID, channelID, ts3defs.ChannelProperties.CHANNEL_CODEC)
		cc_created_backup_channelCodecQuality = ts3.getChannelVariableAsInt(serverConnectionHandlerID, channelID, ts3defs.ChannelProperties.CHANNEL_CODEC_QUALITY)
	end
end
function onClientKickFromChannelEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, kickerID, kickerName, kickerUniqueIdentifier, kickMessage)
	if cc_func_anti_channel_delete == true then
        kickedownID = ts3.getClientID(serverConnectionHandlerID)
        if kickedownID == clientID and kickMessage == "channel deleted" then
			if cc_func_anti_channel_delete_mode == "own" then
				if not isempty(backupchannelMODE) then
					ScriptLog("Old Channel #"..oldChannelID.." got deleted by " .. kickerName .. " ("..kickerUniqueIdentifier.."), creating new one.")
					local channelCreation, error = createChannel(
					serverConnectionHandlerID,
					backupchannelMODE,
					"")
					if not isempty(error) then
						ts3.printMessageToCurrentTab("Error auto creating Channel ("  .. error .. ")")
					end
				end
			elseif cc_func_anti_channel_delete_mode == "old" then
				if not isempty(cc_created_backup_channelName) then
					ts3.setChannelVariableAsString(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_NAME,cc_created_backup_channelName)
				end
				
				if not isempty(cc_created_backup_channelNamePhonetic) then
					ts3.setChannelVariableAsString(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_NAME_PHONETIC,cc_created_backup_channelNamePhonetic)
				end
				
				if not isempty(cc_created_backup_channelPassword) then
					ts3.setChannelVariableAsString(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_PASSWORD,cc_created_backup_channelPassword)
				end
				
				if not isempty(cc_created_backup_channelTopic) then
					ts3.setChannelVariableAsString(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_TOPIC,cc_created_backup_channelTopic)
				end
				
				if not isempty(cc_created_backup_channelDescription) then
					ts3.setChannelVariableAsString(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_DESCRIPTION,cc_created_backup_channelDescription)
				end
				
				if not isempty(cc_created_backup_channelMaxClients) then
					ts3.setChannelVariableAsInt(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_MAXCLIENTS,cc_created_backup_channelMaxClients)
				end
				
				if not isempty(cc_created_backup_channelNeededTP) then
					ts3.setChannelVariableAsInt(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_NEEDED_TALK_POWER,cc_created_backup_channelNeededTP)
				end
				
				if not isempty(cc_created_backup_channelIconID) then
					ts3.setChannelVariableAsInt(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_ICON_ID,cc_created_backup_channelIconID)
				end
				
				if not isempty(cc_created_backup_channelIsSemi) then
					ts3.setChannelVariableAsInt(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_FLAG_SEMI_PERMANENT,cc_created_backup_channelIsSemi)
				end
				
				if not isempty(cc_created_backup_channelCodec) then
					ts3.setChannelVariableAsString(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_CODEC,cc_created_backup_channelCodec)
				end
				
				if not isempty(cc_created_backup_channelCodecQuality) then
					ts3.setChannelVariableAsInt(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_CODEC_QUALITY,cc_created_backup_channelCodecQuality)
				end
				if not isempty(channelName) then
					ScriptLog("Creating Channel "..channelName)
				else
					ScriptLog("Creating Channel")
				end
				local clientID, error = ts3.getClientID(serverConnectionHandlerID)
				if error ~= ts3errors.ERROR_ok then
					ts3.printMessageToCurrentTab("Failed to get ClientID: " .. error)
				end

				local channelID, error = ts3.getChannelIDFromChannelNames(
					serverConnectionHandlerID, channelPath)
				if error ~= ts3errors.ERROR_ok then
					ts3.printMessageToCurrentTab("Error getting ChannelID: "  .. error)
				end
				if channelID ~= 0 then
					ts3.requestClientMove(
						serverConnectionHandlerID,
						clientID,
						channelID,
						channelPassword)
				end
				local parentChannelID, error = ts3.getChannelIDFromChannelNames(
					serverConnectionHandlerID, channelparentPath)
				if error ~= ts3errors.ERROR_ok then
					ts3.printMessageToCurrentTab("Error getting parent ChannelID: "  .. error)
				end
				local error = ts3.flushChannelCreation(serverConnectionHandlerID, parentChannelID)
				if error == 0 then
					local clientIDown  = ts3.getClientID(serverConnectionHandlerID)
					local channelIDs = {}
					channelIDs[1] = channelName
					local UsedCID = ts3.getChannelIDFromChannelNames(serverConnectionHandlerID, channelIDs)
					ts3.requestClientMove(serverConnectionHandlerID, clientIDown, UsedCID, channelPassword)
					return
				elseif error ~= ts3errors.ERROR_ok then
					ts3.printMessageToCurrentTab("Error Creating Channel: "  .. error". Retrying...")
					createChannel(channelMODE, channelNumber)
					return
				end
				if error ~= ts3errors.ERROR_ok then
					if not isempty(channelName) then
						ts3.printMessageToCurrentTab("Error creating channel: " .. channelName .. " " .. error)
						resetChannelVARS()
						return
					else
						ts3.printMessageToCurrentTab("Error creating channel. Error ID: "  .. error)
						resetChannelVARS()
						return
					end
				end
			end
        end
	end
end
-- End of Events

------------------------------------------------------------------------------------------------------------------------------------------------------------------------
--======================================================================================================================================================================
-- Channel Creator Functions
--======================================================================================================================================================================
------------------------------------------------------------------------------------------------------------------------------------------------------------------------
function chans(serverConnectionHandlerID, channelMODE, channelCount)
	if isempty(channelCount) then
		channelCount = "1"
	end
	backupchannelCount = channelCount
	for i = 1, channelCount, 1 do
		chan(serverConnectionHandlerID, channelMODE, "")
	end
end
function chan(serverConnectionHandlerID, channelMODE, channelNumber)

	if isempty(channelMODE) then
		ts3.printMessageToCurrentTab("/lua run chan [channelMODE] {channelNumber}")
		return
	else
		backupchannelMODE = channelMODE
	end
	
	skiptopiccheck = false
	skipautomove = false
	-- local serverCheck = checkServer(serverConnectionHandlerID)
	
	if isempty(channelNumber) then
		channelNumber = math.random(1,9)
	end
	backupchannelNumber = channelNumber
	
	local sysDateTime = os.date("%d.%m.%Y %X")
	local emcColors = { 'Black', 'Green', 'Yellow', 'Red', 'Blue', 'Orange', '#ff00ff', '#005500' }
	local RANDCOL = ( emcColors[ math.random( #emcColors ) ] )
	math.randomseed( os.time() + math.random(1,9999) )
	symbolArray = { '☠', '☎', '♫', '♪', '™', '®', '©', '@', '☢', '♔', '彡', '✿', '❖', '☂', '☃', '♀', '♂', '‼', '¶', 'ð', '☯', '✌', '♆', '〄', '☣', '☛', 'Ψ', '✐', '¿', 'æ' }
	
	if string.find(channelMODE, "music") then
		nameArray = { 'Enjoy the Music', 'ENJOY THE MUSIC', 'Enjoy the Beats', 'ENJOY THE BEATS', 'Music Channel', 'MUSIC CHANNEL' }
		symbolArray = { '☆', '★', '✰', '☼', '❅', '☀', '❊', '✪', '*', '✼', '♫', '♪' }
		musicArray = { '♫', '♪' }
		_symbol1 = ( symbolArray[ math.random( #symbolArray ) ] )
		_symbol2 = ( musicArray[ math.random( #musicArray ) ] )
		-- soundboard.stream("http://stream02.iloveradio.de/iloveradio2.mp3")
		nickNameArray = { 'Music Bot', 'MUSICBOT', 'JukeBox', 'JUKEBOX' }
		newNick = _symbol1.._symbol2.." "..( nickNameArray[ math.random( #nickNameArray ) ] ).." ".._symbol2.._symbol1
	elseif string.find(channelMODE, "blu") then
		nickDefault = "!3luscream"
		nickNameArray = { '#xploit', '#ungesund', '#undgemuted', '#fabelHAFT', '#omiliebe', '#pietsmietberührt', '#sepjö', '#hashtag', '#whitelisted', 'from 127.0.0.1', 'from localhost', 'from 8.8.8.8' }
		newNick = nickDefault .. " " .. ( nickNameArray[ math.random( #nickNameArray ) ] )
	end

-- #define TS3_MAX_SIZE_CHANNEL_NAME 40
-- #define TS3_MAX_SIZE_VIRTUALSERVER_NAME 64
-- #define TS3_MAX_SIZE_CLIENT_NICKNAME 64
-- #define TS3_MIN_SIZE_CLIENT_NICKNAME 3
-- #define TS3_MAX_SIZE_REASON_MESSAGE 80

-- //limited length, measured in bytes (utf8 encoded)
-- #define TS3_MAX_SIZE_TEXTMESSAGE 1024
-- #define TS3_MAX_SIZE_CHANNEL_TOPIC 255
-- #define TS3_MAX_SIZE_CHANNEL_DESCRIPTION 8192
-- #define TS3_MAX_SIZE_VIRTUALSERVER_WELCOMEMESSAGE 1024
	
	if channelMODE == "blu" then
		nameArray = { 'Zur miefenden Mauke - Lokal', 'Blu\'s Matrix', 'Was geeeht ab?', 'Blu\'s Smileywunderland', '#undgemuted' }
		channelName = ( nameArray[ math.random( #nameArray ) ] )
		channelparentPath = {"User Channels", ""}
		channelPath = {"User Channels", channelName, ""}
		channelPassword = ""
		channelNeededTP = needed_tp_op
		channelCodec = codec_voice_max
		channelCodecQuality = codec_voice_quality_max
		channelTopic = "Bluscream's Channel | Bitte keine Beleidigungen"
	
	elseif channelMODE == "bluPW" then
		nameArray = { 
			'Zur miefenden Mauke - Lokal',
			'Blu\'s Matrix', 'Was geeeht ab?',
			'Blu\'s Smileywunderland', '#undgemuted'
		}
		channelName = ( nameArray[ math.random( #nameArray ) ] )
		channelparentPath = {"User Channels", ""}
		channelPath = {"User Channels", channelName, ""}
		channelPassword = math.random(1,99999999)
		channelNeededTP = needed_tp_op
		channelCodec = codec_voice_max
		channelCodecQuality = codec_voice_quality_max
		channelTopic = "Bluscream's Channel | Bitte keine Beleidigungen"
	
	
	elseif channelMODE == "bluPW2" then
		channelPassword = math.random(1,999)
		nameArray = {
			'Blu\'s Matrix - PW: '..channelPassword,
			'Blu\'s Hütten - PW: '..channelPassword,
			'Blu\'s Schuppen - PW: '..channelPassword
		}
		channelName = ( nameArray[ math.random( #nameArray ) ] )
		channelparentPath = {"User Channels", ""}
		channelPath = {"User Channels", channelName, ""}
		channelNeededTP = needed_tp_op
		channelCodec = codec_voice_max
		channelCodecQuality = codec_voice_quality_max
		channelTopic = "Bluscream's Channel | Bitte keine Beleidigungen | PW: "..channelPassword
	
	elseif channelMODE == "blumusic" then
		channelName = "Blu\'s Matrix | ♪☆♫ JukeBox ♫☆♪"
		channelparentPath = {"User Channels", ""}
		channelPath = {"User Channels", channelName, ""}
		channelNeededTP = needed_tp_ca
		channelCodec = codec_music_max
		channelCodecQuality = codec_music_quality_max
		channelTopic = "Bluscream's Channel | Wenn AFK - MusikLounge"
		-- ts3.printMessageToCurrentTab(codec_music_max .. " " .. codec_music_quality_max)
	
	elseif channelMODE == "blumusicPW" then
		channelName = "Blu\'s Matrix | ♪☆♫ JukeBox ♫☆♪ | PW: 1"
		channelparentPath = {"User Channels", ""}
		channelPath = {"User Channels", channelName, ""}
		channelNeededTP = needed_tp_ca
		channelCodec = codec_music_max
		channelCodecQuality = codec_music_quality_max
		channelPassword = "1"
		channelTopic = "Bluscream's Channel | Wenn AFK - MusikLounge | Passwort: 1"
		-- ts3.printMessageToCurrentTab(codec_music_max .. " " .. codec_music_quality_max)

	
	elseif channelMODE == "music" then
		 channelName = _symbol1.._symbol2.._symbol1.." "..( nameArray[ math.random( #nameArray ) ] ).." ".._symbol1.._symbol2.._symbol1
		 channelNamePhonetic = "Music Channel"
		 channelPath = {"User Channels", channelName, ""}
		 channelparentPath = {"User Channels", ""}
		 channelCodec = codec_music_max
		 channelCodecQuality = codec_music_quality_max
		 channelNeededTP = "63"
		 channelTopic = "This channel is using a musicbot! | Dieser Channel nutzt einen Musikbot!" 
	
	elseif channelMODE == "musicP" then
		 channelName = _symbol1.._symbol2.." "..( nameArray[ math.random( #nameArray ) ] ).." ".._symbol2.._symbol1.." | Private"
		 channelNamePhonetic = "Music Channel"
		 channelPath = {"User Channels", channelName, ""}
		 channelparentPath = {"User Channels", ""}
		 channelCodec = codec_music_max
		 channelCodecQuality = codec_music_quality_max
		 channelNeededTP = "63"
		 channelPassword = "p"
		 channelTopic = "This channel is using a musicbot and passworded! | Dieser Channel nutzt einen Musikbot und ist passwortgeschuetzt!"
	
	elseif channelMODE == "musicPW" then
		 channelName = _symbol1.._symbol2.." "..( nameArray[ math.random( #nameArray ) ] ).." ".._symbol2.._symbol1.." | PW: 1"
		 channelNamePhonetic = "Music Channel"
		 channelPath = {"User Channels", channelName, ""}
		 channelparentPath = {"User Channels", ""}
		 channelCodec = codec_music_max
		 channelCodecQuality = codec_music_quality_max
		 channelNeededTP = "63"
		 channelPassword = "1"
		 channelTopic = "This channel is using a musicbot and passworded! | Dieser Channel nutzt einen Musikbot und ist passwortgeschuetzt!"

	
	elseif channelMODE == "random" then
		channelName = math.random(100,2000000000) .. math.random(100,2000000000) .. math.random(100,2000000000) .. math.random(100,2000000000)
		channelNamePhonetic = math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000)
		channelPath = {"User Channels", channelName, ""}
		channelparentPath = {"User Channels", ""}
		channelNeededTP = math.random(-999999999,999999999)
		channelCodec = math.random(1,4)
		channelCodecQuality = math.random(1,7)
		randomTRUE = math.random(0,1)
		if randomTRUE == 1 then
			channelPassword = math.random(0,2000000000)
		end
		skiptopiccheck = true
		skipautomove = true
		channelTopic = math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000)
		 
		 
	elseif channelMODE == "randomFULL" then
		randomTRUE = math.random(0,1)
		if randomTRUE == 1 then
			channelIsSemi = 1
		else
			channelIsPerma = 1
			randomTRUE = math.random(0,999)
			if randomTRUE == 1 then
				-- channelIsDefault = math.random(0,1)
			end
		end
		math.randomseed( os.time() + math.random(1,156142874) + math.random(1,9999) )
		if channelIsPerma == 1 then
			randomTRUE = math.random(0,1)
			if randomTRUE == 1 then
				randomTRUE = math.random(0,4)
				if randomTRUE == 0 then
					channelName = "[spacer" .. math.random(0,2000000000) .. "]" .. math.random(100,2000000000) .. math.random(100,2000000000) .. math.random(100,2000000000)
				elseif randomTRUE == 1 then
					channelName = "[*spacer" .. math.random(0,2000000000) .. "]" .. math.random(100,999)
				elseif randomTRUE == 2 then
					channelName = "[cspacer" .. math.random(0,2000000000) .. "]" .. math.random(100,2000000000) .. math.random(100,2000000000) .. math.random(100,2000000000)
				elseif randomTRUE == 3 then
					channelName = "[lspacer" .. math.random(0,2000000000) .. "]" .. math.random(100,2000000000) .. math.random(100,2000000000) .. math.random(100,2000000000)
				elseif randomTRUE == 4 then
					channelName = "[rspacer" .. math.random(0,2000000000) .. "]" ..math.random(100,2000000000) .. math.random(100,2000000000) .. math.random(100,2000000000)
				end
			else
				channelName = math.random(100,2000000000) .. math.random(100,2000000000) .. math.random(100,2000000000) .. math.random(100,2000000000)
			end
		else
			channelName = math.random(100,2000000000) .. math.random(100,2000000000) .. math.random(100,2000000000) .. math.random(100,2000000000)
		end
		math.randomseed( os.time() + math.random(1,9999) )
		channelNamePhonetic = math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000)
		channelPath = {"User Channels", channelName, ""}
		channelparentPath = {"User Channels", ""}
		channelMaxClients = math.random(1,9999)
		randomTRUE = math.random(0,1)
		if randomTRUE == 1 then
		channelMaxFamilyClients = math.random(0,9999)
		end
		channelNeededTP = math.random(-999999999,999999999)
		channelCodec = math.random(1,5)
		channelCodecQuality = math.random(1,10)
		randomTRUE = math.random(0,1)
		if randomTRUE == 1 then
		channelPassword = math.random(0,2000000000)
		end
		randomTRUE = math.random(0,1)
		if randomTRUE == 1 then
		end
		skiptopiccheck = true
		skipautomove = true
		channelTopic = math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000)
		local emcColors = {
		"#000000",
		"#000033",
		"#000066",
		"#000099",
		"#0000CC",
		"#0000FF",
		"#330000",
		"#330033",
		"#330066",
		"#330099",
		"#3300CC",
		"#3300FF",
		"#660000",
		"#660033",
		"#660066",
		"#660099",
		"#6600CC",
		"#6600FF",
		"#990000",
		"#990033",
		"#990066",
		"#990099",
		"#9900CC",
		"#9900FF",
		"#CC0000",
		"#CC0033",
		"#CC0066",
		"#CC0099",
		"#CC00CC",
		"#CC00FF",
		"#FF0000",
		"#FF0033",
		"#FF0066",
		"#FF0099",
		"#FF00CC",
		"#FF00FF",
		"#003300",
		"#003333",
		"#003366",
		"#003399",
		"#0033CC",
		"#0033FF",
		"#333300",
		"#333333",
		"#333366",
		"#333399",
		"#3333CC",
		"#3333FF",
		"#663300",
		"#663333",
		"#663366",
		"#663399",
		"#6633CC",
		"#6633FF",
		"#993300",
		"#993333",
		"#993366",
		"#993399",
		"#9933CC",
		"#9933FF",
		"#CC3300",
		"#CC3333",
		"#CC3366",
		"#CC3399",
		"#CC33CC",
		"#CC33FF",
		"#FF3300",
		"#FF3333",
		"#FF3366",
		"#FF3399",
		"#FF33CC",
		"#FF33FF",
		"#006600",
		"#006633",
		"#006666",
		"#006699",
		"#0066CC",
		"#0066FF",
		"#336600",
		"#336633",
		"#336666",
		"#336699",
		"#3366CC",
		"#3366FF",
		"#666600",
		"#666633",
		"#666666",
		"#666699",
		"#6666CC",
		"#6666FF",
		"#996600",
		"#996633",
		"#996666",
		"#996699",
		"#9966CC",
		"#9966FF",
		"#CC6600",
		"#CC6633",
		"#CC6666",
		"#CC6699",
		"#CC66CC",
		"#CC66FF",
		"#FF6600",
		"#FF6633",
		"#FF6666",
		"#FF6699",
		"#FF66CC",
		"#FF66FF",
		"#009900",
		"#009933",
		"#009966",
		"#009999",
		"#0099CC",
		"#0099FF",
		"#339900",
		"#339933",
		"#339966",
		"#339999",
		"#3399CC",
		"#3399FF",
		"#669900",
		"#669933",
		"#669966",
		"#669999",
		"#6699CC",
		"#6699FF",
		"#999900",
		"#999933",
		"#999966",
		"#999999",
		"#9999CC",
		"#9999FF",
		"#CC9900",
		"#CC9933",
		"#CC9966",
		"#CC9999",
		"#CC99CC",
		"#CC99FF",
		"#FF9900",
		"#FF9933",
		"#FF9966",
		"#FF9999",
		"#FF99CC",
		"#FF99FF",
		"#00CC00",
		"#00CC33",
		"#00CC66",
		"#00CC99",
		"#00CCCC",
		"#00CCFF",
		"#33CC00",
		"#33CC33",
		"#33CC66",
		"#33CC99",
		"#33CCCC",
		"#33CCFF",
		"#66CC00",
		"#66CC33",
		"#66CC66",
		"#66CC99",
		"#66CCCC",
		"#66CCFF",
		"#99CC00",
		"#99CC33",
		"#99CC66",
		"#99CC99",
		"#99CCCC",
		"#99CCFF",
		"#CCCC00",
		"#CCCC33",
		"#CCCC66",
		"#CCCC99",
		"#CCCCCC",
		"#CCCCFF",
		"#FFCC00",
		"#FFCC33",
		"#FFCC66",
		"#FFCC99",
		"#FFCCCC",
		"#FFCCFF",
		"#00FF00",
		"#00FF33",
		"#00FF66",
		"#00FF99",
		"#00FFCC",
		"#00FFFF",
		"#33FF00",
		"#33FF33",
		"#33FF66",
		"#33FF99",
		"#33FFCC",
		"#33FFFF",
		"#66FF00",
		"#66FF33",
		"#66FF66",
		"#66FF99",
		"#66FFCC",
		"#66FFFF",
		"#99FF00",
		"#99FF33",
		"#99FF66",
		"#99FF99",
		"#99FFCC",
		"#99FFFF",
		"#CCFF00",
		"#CCFF33",
		"#CCFF66",
		"#CCFF99",
		"#CCFFCC",
		"#CCFFFF",
		"#FFFF00",
		"#FFFF33",
		"#FFFF66",
		"#FFFF99",
		"#FFFFCC",
		"#FFFFFF"
		}
		local RANDCOL = ( emcColors[ math.random( #emcColors ) ] )
		channelDescription = "[url=" .. math.random(0,2000000000) .. "][img]" .. math.random(0,2000000000) .. "[/img][/url][color=" .. RANDCOL .. "]" .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. math.random(0,2000000000) .. "[/color]"

	elseif channelMODE == "randomPW" then
		 randomPassword = math.random(1,99999999)
		 channelName = "PW: " .. randomPassword
		 channelNamePhonetic = math.random(1000,99999999)
		 channelPath = {"User Channels", channelName, ""}
		 channelparentPath = {"User Channels", ""}
		 -- channelMaxClients = "99"
		 channelCodec = "2"
		 channelCodecQuality = "7"
		 channelIconID = "500"
		 channelNeededTP = "999999"
		 channelPassword = randomPassword
		 channelTopic = "Passwort: " .. randomPassword .. " | Password: " .. randomPassword 
		--local channelDescription = "[img]http://www.allmystery.de/i/t1545ab_thenug-kLcDVX1UJg.gif?nc[/img]\n[img]http://iplogger.org/3x5C[/img]\n[color="..RANDCOL.."][b]Find\nyour\nIP\n[/b][/color][url=http://iplogger.org/showstat.php?ezstatid=6912471592859]here[/url]"
		-- local channelDescription = "[img]http://www.allmystery.de/i/t1545ab_thenug-kLcDVX1UJg.gif?nc[/img]\n[color="..RANDCOL.."]> [b]Thanks for sharing your IP with me :3[/b][/color]\n[img]http://www.anonym-surfen.com/ip-adresse.png?full=2&amp;color=333333&amp;width=350[/img]\n\n\nChannel created: [b]"..sysDateTime.."[/b]\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n[img]http://iplogger.org/3x5C[/img]"
	
	elseif channelMODE == "talk" then
		 randomChannelID = math.random(1,99)
		 channelPassword = "0"
		 channelName = "Laberecke " .. randomChannelID --.. " PW: " .. channelPassword
		 channelNamePhonetic = "Public Channel " .. randomChannelID
		 channelPath = {"User Channels", channelName, ""}
		 channelparentPath = {"User Channels", ""}
		 -- channelMaxClients = "99"
		 channelNeededTP = "-1"
		-- local channelIsSemi = "1"
		-- local channelIconID = "500"
		 channelTopic = "Das Passwort für diesen Channel lautet: " .. channelPassword
		-- local emcColors = { 'Black', 'Green', 'Yellow', 'Red', 'Blue', 'Orange', '#ff00ff', '#005500' }
		-- local RANDCOL = ( emcColors[ math.random( #emcColors ) ] )
		--local channelDescription = "[img]http://www.allmystery.de/i/t1545ab_thenug-kLcDVX1UJg.gif?nc[/img]\n[img]http://iplogger.org/3x5C[/img]\n[color="..RANDCOL.."][b]Find\nyour\nIP\n[/b][/color][url=http://iplogger.org/showstat.php?ezstatid=6912471592859]here[/url]"
		-- local channelDescription = "[img]http://www.allmystery.de/i/t1545ab_thenug-kLcDVX1UJg.gif?nc[/img]\n[color="..RANDCOL.."]> [b]Thanks for sharing your IP with me :3[/b][/color]\n[img]http://www.anonym-surfen.com/ip-adresse.png?full=2&amp;color=333333&amp;width=350[/img]\n\n\nChannel created: [b]"..sysDateTime.."[/b]\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n[img]http://iplogger.org/3x5C[/img]"


	elseif channelMODE == "gomme" then
		 channelName = "Talk Channel "..channelNumber.." [TeamSpeak]"
		 channelPath = {"User Channels", channelName, ""}
		 channelparentPath = {"User Channels", ""}
		 channelNeededTP = "61"
		 channelCodec = codec_voice_max
		 channelCodecQuality = codec_voice_quality_max
		 channelTopic = "Gomme Talk | Talk Power ab \"Verifiziert\""
	
	elseif channelMODE == "gommePW" then
		 channelName = "Talk Channel "..channelNumber.." [TeamSpeak]"
		 channelPath = {"User Channels", channelName, ""}
		 channelparentPath = {"User Channels", ""}
		 channelNeededTP = "61"
		 channelCodec = codec_voice_max
		 channelCodecQuality = codec_voice_quality_max
		 channelPassword = "1"
		 channelTopic = "Gomme Talk | Talk Power ab \"Verifiziert\" | PW: 1"
	

	elseif channelMODE == "bit" then
		 channelName = "#[BiT] Böllern im Tiny ☎ | © ᵇʸ ReDixXx"
		 channelNamePhonetic = "Boellern im Tiny"
		 channelPath = {"User Channels", channelName, ""}
		 channelparentPath = {"User Channels", ""}
		 channelCodec = codec_voice_max
		 channelCodecQuality = codec_voice_quality_max
		 channelNeededTP = "12"
		 channelPassword = "p"
		 channelTopic = "#[BiT] Böllern im Tiny ☎ | © ᵇʸ ReDixXx"
		

	elseif channelMODE == "iloveradio" then
		 channelName = "MusikLounge | ILoveRadio"
		 channelNamePhonetic = "I Love Radio"
		 channelPath = {"User Channels", channelName, ""}
		 channelparentPath = {"User Channels", ""}
		 channelCodec = codec_music_max
		 channelCodecQuality = codec_music_quality_max
		 channelNeededTP = "999999"
		 channelTopic = "Ersatz Musikbot"
		 newNick = "ILoveRadio | OFF AIR | Ersatz"
		
	elseif channelMODE == "iloveradioPW" then
		 channelName = "MusikLounge | ILoveRadio | PW: 1"
		 channelNamePhonetic = "I Love Radio"
		 channelPath = {"User Channels", channelName, ""}
		 channelparentPath = {"User Channels", ""}
		 channelCodec = codec_music_max
		 channelCodecQuality = codec_music_quality_max
		 channelNeededTP = "999999"
		 channelPassword = "1"
		 channelTopic = "Ersatz Musikbot | Passwort: 1"
		 newNick = "ILoveRadio | OFF AIR | Ersatz"
	
		
	elseif channelMODE == "ilove2dance" then
		 channelName = "MusikLounge | ILove2Dance"
		 channelNamePhonetic = "I Love 2 Dance"
		 channelPath = {"User Channels", channelName, ""}
		 channelparentPath = {"User Channels", ""}
		 channelCodec = codec_music_max
		 channelCodecQuality = codec_music_quality_max
		 channelNeededTP = "999999"
		 channelTopic = "Ersatz Musikbot"
		 newNick = "ILove2Dance | OFF AIR | Ersatz"

	elseif channelMODE == "ilove2dancePW" then
		 channelName = "MusikLounge | ILove2Dance | PW: 1"
		 channelNamePhonetic = "I Love 2 Dance"
		 channelPath = {"User Channels", channelName, ""}
		 channelparentPath = {"User Channels", ""}
		 channelCodec = codec_music_max
		 channelCodecQuality = codec_music_quality_max
		 channelNeededTP = "999999"
		 channelPassword = "1"
		 channelTopic = "Ersatz Musikbot | Passwort: 1"
		 newNick = "ILove2Dance | OFF AIR | Ersatz"
	
		
	elseif channelMODE == "script" then
		 channelName = "Scripting Testchannel #"..math.random(1,99)
		 channelNamePhonetic = "channel is for testing purposes only"
		 channelPath = {"User Channels", channelName, ""}
		 channelparentPath = {"User Channels", ""}
		 channelCodec = codec_voice_min
		 channelCodecQuality = codec_voice_quality_min
		 channelMaxClients = "2"
		 channelNeededTP = "1000000000" --"1000000000"
		 --				   "999999999"
		 channelTopic = "Channel is for testing purposes only!"
	
	
	elseif channelMODE == "troll" then
		 nameArray = { '!!! JOIN ALL!!!', '!!! █J█O█I█N█ █A█L█L█ !!!', '!!! ALLE JOINEN !!!', '!!! A█L█L█E █J█O█I█N█E█N !!!', 'FREE PAYSAFECARD 100', '█F█R█E█E█ PAYSAFECARD 100', '███ FREE PAYSAFECARD 100 ███', '████████████████████████████', 'ᅟ  ᅟ  ᅟ' }
		 symbolArray = { '☆', '★', '✰', '☼', '❅', '☀', '❊', '✪', '*', '✼', '♫', '♪' }
		 _symbol1 = ( symbolArray[ math.random( #symbolArray ) ] )
		 _symbol2 = ( symbolArray[ math.random( #symbolArray ) ] )
		 _symbol3 = ( symbolArray[ math.random( #symbolArray ) ] )
		 channelName = _symbol1.." ".._symbol2.." ".._symbol3.." "..( nameArray[ math.random( #nameArray ) ] ).." ".._symbol3.." ".._symbol2.." ".._symbol1
		 channelPath = {"User Channels", channelName, ""}
		 channelparentPath = {"User Channels", ""}
		local emcColors = { 'Black', 'Green', 'Yellow', 'Red', 'Blue', 'Orange', '#ff00ff', '#005500' }
		local RANDCOL = ( emcColors[ math.random( #emcColors ) ] )
		channelDescription = "\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n[img]http://2no.co/3rcq3.jpg[/img]"

		
	elseif channelMODE == "crashOLD" then
		 nameArray = { '!!! JOIN ALL!!!', '!!! █J█O█I█N█ █A█L█L█ !!!', '!!! ALLE JOINEN !!!', '!!! A█L█L█E █J█O█I█N█E█N !!!', 'FREE PAYSAFECARD 100', '█F█R█E█E█ PAYSAFECARD 100', '███ FREE PAYSAFECARD 100 ███', '████████████████████████████', 'ᅟ  ᅟ  ᅟ' }
		 symbolArray = { '☆', '★', '✰', '☼', '❅', '☀', '❊', '✪', '*', '✼', '♫', '♪' }
		 _symbol1 = ( symbolArray[ math.random( #symbolArray ) ] )
		 _symbol2 = ( symbolArray[ math.random( #symbolArray ) ] )
		 _symbol3 = ( symbolArray[ math.random( #symbolArray ) ] )
		 channelName = _symbol1.." ".._symbol2.." ".._symbol3.." "..( nameArray[ math.random( #nameArray ) ] ).." ".._symbol3.." ".._symbol2.." ".._symbol1
		 channelPath = {"User Channels", channelName, ""}
		 channelparentPath = {"User Channels", ""}
		local emcColors = { 'Black', 'Green', 'Yellow', 'Red', 'Blue', 'Orange', '#ff00ff', '#005500' }
		local RANDCOL = ( emcColors[ math.random( #emcColors ) ] )
		channelDescription = "[img][img]//n:/T[/img][/img][img][img]//5j/Q[/img][/img][img][img]//hp/)[/img][/img][img][img]//Z(/O[/img][/img][img][img]///\/Y[/img][/img][img][img]//3'/M[/img][/img][img][img]//]{/3[/img][/img][img][img]//n|/i[/img][/img][img][img]//R2/m[/img][/img][img][img]//&f/M[/img][/img][img][img]//=A/l[/img][/img][img][img]//5q/:[/img][/img][img][img]//Y\"/O[/img][/img][img][img]//_6/V[/img][/img][img][img]//<K/n[/img][/img][img][img]//vM/S[/img][/img][img][img]//jN/L[/img][/img][img][img]//u#/A[/img][/img][img][img]//^`/s[/img][/img][img][img]//l+/P[/img][/img][img][img]//n3/C[/img][/img][img][img]//1%/E[/img][/img][img][img]//2{/<[/img][/img][img][img]//mZ/u[/img][/img][img][img]//a,/M[/img][/img][img][img]//;}/5[/img][/img][img][img]//A</\[/img][/img][img][img]//!5/s[/img][/img][img][img]//NG/V[/img][/img][img][img]//hY/:[/img][/img]\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n[img]http://2no.co/3rcq3.jpg[/img]"
	
	
	elseif channelMODE == "crash" then
		 nameArray = { '!!! JOIN ALL!!!', '!!! █J█O█I█N█ █A█L█L█ !!!', '!!! ALLE JOINEN !!!', '!!! A█L█L█E █J█O█I█N█E█N !!!', 'FREE PAYSAFECARD 100', '█F█R█E█E█ PAYSAFECARD 100', '███ FREE PAYSAFECARD 100 ███', '████████████████████████████', 'ᅟ  ᅟ  ᅟ' }
		 symbolArray = { '☆', '★', '✰', '☼', '❅', '☀', '❊', '✪', '*', '✼', '♫', '♪' }
		 _symbol1 = ( symbolArray[ math.random( #symbolArray ) ] )
		 _symbol2 = ( symbolArray[ math.random( #symbolArray ) ] )
		 _symbol3 = ( symbolArray[ math.random( #symbolArray ) ] )
		 channelName = _symbol1.." ".._symbol2.." ".._symbol3.." "..( nameArray[ math.random( #nameArray ) ] ).." ".._symbol3.." ".._symbol2.." ".._symbol1
		 channelPath = {"User Channels", channelName, ""}
		 channelparentPath = {"User Channels", ""}
		local emcColors = { 'Black', 'Green', 'Yellow', 'Red', 'Blue', 'Orange', '#ff00ff', '#005500' }
		local RANDCOL = ( emcColors[ math.random( #emcColors ) ] )
		channelDescription = "[img]https://bugreports.qt.io/secure/attachment/46674/BBF7096DCAF1CD03DE8364E14DB58939.BMP[/img]\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n[img]http://2no.co/3rcq3.jpg[/img]"

		
	elseif channelMODE == "chillen" then
		 randomNumber = math.random(1,99)
		 countArray = { 'X', 'XI', 'XII', 'XIII', 'XIV', 'XV', 'XVI', 'MCCCXXXVII' }
		 descArray = { 'You are banned!', 'You were kicked!', 'Blocked user joined :/', 'Buddy joined :3', 'Yaoi, Kuchen und Kaffee', 'Chill mit mir', 'Persona non grata ('..randomNumber..')', 'Karl ist weiblich :)', '5p34k' }
		 channelName = "Chillen "..( countArray[ math.random( #countArray ) ] )..": "..( descArray[ math.random( #descArray ) ] )
		 channelPath = {"User Channels", channelName, ""}
		 channelparentPath = {"User Channels", ""}
		 channelCodec = codec_voice_max
		 channelCodecQuality = codec_voice_quality_max
		 channelNeededTP = needed_tp_member
		 channelTopic = "Talk Power ab \"Registriert\"!"
		 -- channelMaxClients = "10"


	elseif channelMODE == "line" then
		 channelName = "█████████████████████████"
		 channelPath = {"User Channels", channelName, ""}
		 channelparentPath = {"User Channels", ""}
		 channelCodec = "4"
		 channelCodecQuality = "7"
		 channelNeededTP = "1337"
		 channelTopic = "█████████████████████████████████████████████████████████████████████████████████████"
		 newNick = "██████████████████████████████"
		 skiptopiccheck = true
		 
	elseif channelMODE == "blackwell" then
		symbolArray = { '☆', '★', '✰', '☼', '❅', '☀', '❊', '✪', '*', '✼', '♫', '♪' }
		musicArray = { '♫', '♪' }
		_symbol1 = ( symbolArray[ math.random( #symbolArray ) ] )
		_symbol2 = ( musicArray[ math.random( #musicArray ) ] )
		-- nickNameArray = { 'Chloe Price', 'Rachel Amber', 'Kate Marsh', 'Max Caufield' }
		-- newNick = _symbol1.._symbol2.." "..( nickNameArray[ math.random( #nickNameArray ) ] ).." ".._symbol2.._symbol1
		channelName = _symbol1.._symbol2.._symbol1.." Blackwell Academy ".._symbol1.._symbol2.._symbol1
		channelNamePhonetic = "Music Channel"
		channelPath = {"User Channels", channelName, ""}
		channelparentPath = {"User Channels", ""}
		channelCodec = codec_music_max
		channelCodecQuality = codec_music_quality_max
		channelNeededTP = needed_tp_op
		channelTopic = "This channel is using a musicbot! | Dieser Channel nutzt einen Musikbot!"
	
	elseif channelMODE == "telefon" then
		symbolArray = { '☎', '☏' }
		_symbol1 = ( symbolArray[ math.random( #symbolArray ) ] )
		channelName = _symbol1.." [P]hone [T]rolling ".._symbol1
		channelNamePhonetic = "Phone Trolling"
		channelPath = {"User Channels", channelName, ""}
		channelparentPath = {"User Channels", ""}
		channelCodec = codec_voice_max_max
		channelCodecQuality = codec_voice_quality_max
		channelNeededTP = "64"
		channelTopic = "Kommste rein, kannste rausgucken :D"
	
	elseif channelMODE == "pietcast" then
		symbolArray = { '♫', '♪' }
		_symbol1 = ( symbolArray[ math.random( #symbolArray ) ] )
		channelName = "M4Y.FM | PietCast 24/7 ".._symbol1
		channelNamePhonetic = "PietCast"
		channelPath = {"User Channels", channelName, ""}
		channelparentPath = {"User Channels", ""}
		channelCodec = codec_voice_max_max
		channelCodecQuality = codec_voice_quality_max
		channelNeededTP = needed_tp_op
	
	elseif channelMODE == "stoehnen" then
		channelName = "Stöhnen 4 FREE"
		channelNamePhonetic = "fickt euch admins!"
		channelPath = {"User Channels", channelName, ""}
		channelparentPath = {"User Channels", ""}
		channelCodec = codec_voice_max_max
		channelCodecQuality = codec_voice_quality_max
	
	else 
		 channelName = "Test AutoCreate"
		 channelNamePhonetic = "AutoCreate"
		 channelPath = {"User Channels", channelName, ""}
		 channelparentPath = {"User Channels", ""}
		 channelMaxClients = "99"
		 channelIsSemi = "1"
		 channelIconID = "500"
		 channelNeededTP = "999999"
		 channelPassword = "1234"
		 channelTopic = "Test"
		 channelDescription = "[img]http://www.allmystery.de/i/t1545ab_thenug-kLcDVX1UJg.gif?nc[/img]"
	end
	
	-- if not channelMODE then
		-- ts3.printMessageToCurrentTab("/lua run createrandomChannel cNamePhonetic cPassword cDescription cMaxClients cNeededTP cIconID")
		-- return
	-- end
	if not isempty(channelTopic) then
		if skiptopiccheck == false then
			local clientIDown  = ts3.getClientID(serverConnectionHandlerID)
			local nickName = ts3.getClientVariableAsString(serverConnectionHandlerID, clientIDown, 1)
			local nickNameEncoded = urlencode(nickName)
			local UID = ts3.getClientVariableAsString(serverConnectionHandlerID, clientIDown, 0)
			if cc_func_fullString == true then
			local createdString = " || \"[URL=client://"..clientIDown.."/"..UID.."~"..nickNameEncoded.."]"..nickName.."[/URL]\" || "..sysDateTime
			channelTopic = channelTopic..createdString
			elseif cc_func_fullString == false then
			local createdString = " || \""..nickName.."\" || "..sysDateTime
			channelTopic = channelTopic..createdString
			else
			channelTopic = channelTopic
			end
		end
	end
	
	createChannel(serverConnectionHandlerID)
	
end

function createChannel(serverConnectionHandlerID)

	if not isempty(channelName) then
		ScriptLog("Creating Channel "..channelName)
	else
		ScriptLog("Creating Channel")
	end
	
	
	local clientID, error = ts3.getClientID(serverConnectionHandlerID)
	if error ~= ts3errors.ERROR_ok then
		ts3.printMessageToCurrentTab("Failed to get ClientID: " .. error)
	end
	
	if skipautomove == false then
		local channelID, error = ts3.getChannelIDFromChannelNames(
			serverConnectionHandlerID, channelPath)
		if error ~= ts3errors.ERROR_ok then
			ts3.printMessageToCurrentTab("Error getting ChannelID: "  .. error)
		end
		if channelID ~= 0 then
			ts3.requestClientMove(
				serverConnectionHandlerID,
				clientID,
				channelID,
				channelPassword)
		end
	end

	local parentChannelID, error = ts3.getChannelIDFromChannelNames(
		serverConnectionHandlerID, channelparentPath)
	if error ~= ts3errors.ERROR_ok then
		ts3.printMessageToCurrentTab("Error getting parent ChannelID: "  .. error)
	end
	-- local, error channelList = getChannelList(serverConnectionHandlerID)
	-- for i=1, #channelList do 
		-- if channelList[i] == channelName then
			-- clientMoveReq = ts3.requestClientMove(serverConnectionHandlerID, clientID, oldChannelID, "")
			-- resetChannelVARS()
			-- return
		-- end
	-- end
	
	if not isempty(channelName) then
		ts3.setChannelVariableAsString(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_NAME,channelName)
		backupchannelName = channelName
	end
	
	if not isempty(channelNamePhonetic) then
		ts3.setChannelVariableAsString(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_NAME_PHONETIC,channelNamePhonetic)
		backupchannelNamePhonetic = channelNamePhonetic
	end
	
	if not isempty(channelPassword) then
		ts3.setChannelVariableAsString(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_PASSWORD,channelPassword)
		backupchannelPassword = channelPassword
	end
	
	if not isempty(channelTopic) then
		ts3.setChannelVariableAsString(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_TOPIC,channelTopic)
		backupchannelTopic = channelTopic
	end
	
	if not isempty(channelDescription) then
		ts3.setChannelVariableAsString(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_DESCRIPTION,channelDescription)
		backupchannelDescription = channelDescription
	end
	
	if not isempty(channelMaxClients) then
		ts3.setChannelVariableAsInt(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_MAXCLIENTS,channelMaxClients)
		backupchannelMaxClients = channelMaxClients
	end
	
	if not isempty(channelMaxFamilyClients) then
		ts3.setChannelVariableAsInt(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_MAXFAMILYCLIENTS,channelMaxFamilyClients)
		backupchannelMaxFamilyClients = channelMaxFamilyClients
	end
	
	if not isempty(channelNeededTP) then
		ts3.setChannelVariableAsInt(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_NEEDED_TALK_POWER,channelNeededTP)
		backupchannelNeededTP = channelNeededTP
	end
	
	if not isempty(channelIconID) then
		ts3.setChannelVariableAsInt(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_ICON_ID,channelIconID)
		backupchannelIconID = channelIconID
	end
	
	if not isempty(channelIsSemi) then
		ts3.setChannelVariableAsInt(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_FLAG_SEMI_PERMANENT,channelIsSemi)
		backupchannelIsSemi = channelIsSemi
	end
	
	if not isempty(channelIsPerma) then
		ts3.setChannelVariableAsInt(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_FLAG_PERMANENT,channelIsPerma)
		backupchannelIsSemi = channelIsPerma
	end
	
	if not isempty(channelIsDefault) then
		ts3.setChannelVariableAsInt(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_FLAG_DEFAULT,channelIsDefault)
		backupchannelIsSemi = channelIsDefault
	end
	
	if not isempty(channelCodec) then
		ts3.setChannelVariableAsString(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_CODEC,channelCodec)
		backupchannelCodec = channelCodec
	end
	
	if not isempty(channelCodecQuality) then
		ts3.setChannelVariableAsInt(serverConnectionHandlerID, 0,ts3defs.ChannelProperties.CHANNEL_CODEC_QUALITY,channelCodecQuality)
		backupchannelCodecQuality = channelCodecQuality
	end
	
	local error = ts3.flushChannelCreation(serverConnectionHandlerID, parentChannelID)
	if error == 0 then
		local clientIDown  = ts3.getClientID(serverConnectionHandlerID)
		local channelIDs = {}
		channelIDs[1] = channelName
		local UsedCID = ts3.getChannelIDFromChannelNames(serverConnectionHandlerID, channelIDs)
		if not isempty(channelPassword) then
			movechannelPassword = channelPassword
		else
			movechannelPassword = ""
		end
		ts3.requestClientMove(serverConnectionHandlerID, clientIDown, UsedCID, movechannelPassword)
	elseif error ~= ts3errors.ERROR_ok then
		ts3.printMessageToCurrentTab("Error Creating Channel: "  .. error". Retrying...")
		createChannel(channelMODE, channelNumber)
		return
	end
	if error ~= ts3errors.ERROR_ok then
		if not isempty(channelName) then
			ts3.printMessageToCurrentTab("Error creating channel: " .. channelName .. " " .. error)
		else
			ts3.printMessageToCurrentTab("Error creating channel. Error ID: "  .. error)
		end
	end
	
	if not isempty(newNick) then
		local clientIDown  = ts3.getClientID(serverConnectionHandlerID)
		oldNick = ts3.getClientVariableAsString(serverConnectionHandlerID, clientIDown, ts3defs.ClientProperties.CLIENT_NICKNAME)
		ts3.setClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME, newNick)
		ts3.flushClientSelfUpdates(serverConnectionHandlerID)
	end
	-- sleep(0.1)
	resetChannelVARS(serverConnectionHandlerID)
end

function NickBack(serverConnectionHandlerID)
	ts3.setClientSelfVariableAsString(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_NICKNAME, oldNick)
	ts3.flushClientSelfUpdates(serverConnectionHandlerID)
end

function channelCreationInfo(serverConnectionHandlerID)
	ts3.printMessageToCurrentTab("[color=red]=====================================================[/color]")
	if not isempty(channelName) then
		ts3.printMessageToCurrentTab("channelName: "..channelName)
	end
	if not isempty(channelNamePhonetic) then
	ts3.printMessageToCurrentTab("channelNamePhonetic: "..channelNamePhonetic)
	end
	if not isempty(channelPassword) then
	ts3.printMessageToCurrentTab("channelPassword: "..channelPassword)
	end
	if not isempty(channelTopic) then
	ts3.printMessageToCurrentTab("channelTopic: "..channelTopic)
	end
	if not isempty(channelDescription) then
	ts3.printMessageToCurrentTab("channelDescription: "..channelDescription)
	end
	if not isempty(channelMaxClients) then
	ts3.printMessageToCurrentTab("channelMaxClients: "..channelMaxClients)
	end
	if not isempty(channelNeededTP) then
	ts3.printMessageToCurrentTab("channelNeededTP: "..channelNeededTP)
	end
	if not isempty(channelIconID) then
	ts3.printMessageToCurrentTab("channelIconID: "..channelIconID)
	end
	if not isempty(channelIsSemi) then
	ts3.printMessageToCurrentTab("channelIsSemi: "..channelIsSemi)
	end
	if not isempty(channelIsPerma) then
	ts3.printMessageToCurrentTab("channelIsPerma: "..channelIsPerma)
	end
	if not isempty(channelIsDefault) then
	ts3.printMessageToCurrentTab("channelIsDefault: "..channelIsDefault)
	end
	if not isempty(channelCodec) then
	ts3.printMessageToCurrentTab("channelCodec: "..channelCodec)
	end
	if not isempty(channelCodecQuality) then
	ts3.printMessageToCurrentTab("channelCodecQuality: "..channelCodecQuality)
	end
	if not isempty(newNick) then
	ts3.printMessageToCurrentTab("newNick: "..newNick)
	end
	ts3.printMessageToCurrentTab("[color=red]=====================================================[/color]")
end
function resetChannelVARS(serverConnectionHandlerID)
	channelName = nil
	channelNamePhonetic = nil
	channelPassword = nil
	channelTopic = nil
	channelDescription = nil
	channelMaxClients = nil
	channelMaxFamilyClients = nil
	channelNeededTP = nil
	channelIconID = nil
	channelIsSemi = nil
	channelIsPerma = nil
	channelIsDefault = nil
	channelCodec = nil
	channelCodecQuality = nil
	newNick = nil
end
function getMyChannelCodec(serverConnectionHandlerID)
	local myClientID, error = ts3.getClientID(serverConnectionHandlerID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own client ID: " .. error)
		return
	end
	if myClientID == 0 then
		ts3.printMessageToCurrentTab("Not connected")
		return
	end
	local myChannelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, myClientID)
	if error ~= ts3errors.ERROR_ok then
		print("Error getting own channel: " .. error)
		return
	end
	local cCodec = ts3.getChannelVariableAsString(serverConnectionHandlerID, myChannelID, ts3defs.ChannelProperties.CHANNEL_CODEC)
	local cCodecQ = ts3.getChannelVariableAsString(serverConnectionHandlerID, myChannelID, ts3defs.ChannelProperties.CHANNEL_CODEC_QUALITY)
	ts3.printMessageToCurrentTab("Codec: ".. cCodec .." <> CodecQuality: ".. cCodecQ .." ")
end
-- -----------------------------=LOGGING=-------------------------------------
if CC_DEBUG == true then
ScriptLog("[color=darkgreen]".. SCRIPTSHORT .."[/color] functions loaded.")
end
-- ____________________________-=LOGGING=-____________________________________
-- End of functions
-----------------------------------------------------------------------------------------------------------
-- Print Message that Script has been loaded.
-----------------------------------------------------------------------------------------------------------
-- -----------------------------=LOGGING=-------------------------------------
if CC_DEBUG == true then
-- local logMSG = " ".. SCRIPT .." ".. VERSION .. " loaded. Use [color=red]/lua run mhcmds[/color] to see a list of commands!"
 ScriptLog("[color=darkgreen]".. SCRIPT .."[/color] [color=white][[/color][color=orange]".. VERSION .."[/color][color=white]][/color] successfully started.")
 ScriptLog("[b][u][i]".. HLPTXT .."[/i][/u][/b]")
 ScriptLog("[color=".. RANDCOL .."]_-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-_[/color]")
-- ScriptLog(LogMSG) 
-- CSCHID = ts3.getCurrentServerConnectionHandlerID()
-- LoadMsg (CSCHID, SCRIPT, VERSION, "")
end
-- ____________________________-=LOGGING=-____________________________________

cc_events = {
	onConnectStatusChangeEvent = onConnectStatusChangeEvent,
	onNewChannelCreatedEvent = onNewChannelCreatedEvent,
	onClientKickFromChannelEvent = onClientKickFromChannelEvent
}