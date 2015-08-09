require("ts3defs")
require("ts3errors")
require("frigyd/funcs")
require("frigyd/prefs")

prefs = loadPrefs()

-- Declare handlers, that way custom modules can add functions to them.
chatHandlers = {}
speechHandlers = {}
moveHandlers = {}
adMoveHandlers = {}
timeoutMoveHandlers = {}
connectHandlers = {}

local spammers = {}

-- Help commands array.
helpCmds = {}

local baseDir = "plugins/lua_plugin/frigyd/"
frigydDir = baseDir

math.randomseed(os.time())
math.random(); math.random(); math.random()


local frigVer = "1.2"
local fClientVer = "1.0"

local function searchSpammers(UID)
	local rv, tbl = nil
	
	for k,v in pairs(spammers) do
		
		if(v[1] == UID) then
			rv = k
			tbl = v
		end
		
	end
	
	return rv, tbl
end

local function checkSpam(SCHI, clID)
	local UID = getUIDbyID(SCHI, clID)
	
	local spr, sptbl = searchSpammers(UID)
	
	if(spr ~= nil and sptbl ~= nil) then
		-- User exists in the spam file, check when last command was.
		
		--print("SPAM EXIST")
		
		local ctime = os.time()
		local diff = os.difftime(ctime, sptbl[2])
		
		--print("== DIFF", diff)
		
		if(diff >= tonumber(prefs["Bot"]["spamProtect"])) then
			--print("NO SPAM")
			
			if(tonumber(sptbl[4]) == 0) then
				--print("== NO SPAM")
				sptbl[2] = os.time()
				--print("UPDATED TIME")
				sptbl[4] = 0
				
				return 0
			else
				--print("== REDUCE TIME")
				
				--local sptime = (tonumber(sptbl[3]) + ())
				--local spamdiff = os.difftime(ctime, )
				
				sptbl[2] = os.time()
				--print("UPDATED TIME")
				
				local newtime = (tonumber(sptbl[3]) - diff)
				
				if(newtime < 0) then
					newtime = 0
				end
				sptbl[3] = newtime
				
				
				--print("==== NEW SPAM CD", newtime, sptbl[3], diff)
				
				if(newtime == 0) then
					return 0
				else
					sendChatMsg(SCHI, "You have [color=blue][b]"..sptbl[3].." seconds[/b][/color] left in your [b]spam cooldown[/b].", clID, "private", "red")
					
					return 1
				end
				
			end
			
			
			
			
		else
			--print("== SPAM")
			
			if(tonumber(sptbl[4]) == 0) then
				--print("== FIRST WARNING")
				sptbl[4] = tonumber(sptbl[4]) + 1
			elseif(tonumber(sptbl[4]) > 0) then
				--print("== ACTIVE SPAM", sptbl[4], sptbl[3])
				sptbl[4] = tonumber(sptbl[4]) + 1
				sptbl[3] = tonumber(sptbl[3]) + 3
			end
			
			sptbl[2] = os.time()
			--print("UPDATED TIME")
			
			sendChatMsg(SCHI, "You are [b]spamming[/b], you must wait [color=blue][b]"..sptbl[3].." seconds[/b][/color] until you can use commands.", clID, "private", "red")
			
			if(tonumber(sptbl[4]) == 10) then
				frigWriteLog("-SPAM- "..getUsernameByID(SCHI, clID).." (".. getUIDbyID(SCHI, clID) ..") is spamming commands!")
			end
			
			return 1
		end
		
		
	else
		table.insert(spammers, {UID, os.time(), 0, 0})
		
		return 0
	end
	
end


function frigMessageHandler(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
	--print("FRIGYD MODE", prefs["Bot"]["mode"])

	local botUID = getUIDbyID(serverConnectionHandlerID, ts3.getClientID(serverConnectionHandlerID))

	local comPrefix = "."
	local firstLetter = string.sub(message, 1, #comPrefix)
	
	local senderUID = getUIDbyID(serverConnectionHandlerID, fromID)
	
	if(#message > 1 and firstLetter == comPrefix) then
			local messageStr = Split(message, " ")
			
			local cmdIns = string.sub(messageStr[1], #comPrefix+1)
			messageStr[1] = cmdIns
			
			
			local args = {}
			
			for k,v in pairs(messageStr) do
				if(k ~= 1) then
					table.insert(args, v)
				end
			end
			
			local commands = {}
			for k,v in pairs(commandList) do
				commands[k] = v
			end
			
			local isSpam = 0
			if(prefs["Bot"]["spamEnabled"] == "true") then
				isSpam = checkSpam(serverConnectionHandlerID, fromID)
			else
				isSpam = 0
			end
			
				if(isSpam == 0) then
				
					local srchPerm = searchUserPerm(getUIDbyID(serverConnectionHandlerID, fromID), "c")
				
					if(srchPerm == true) then
						local srchBlocked = searchBlocked(getUIDbyID(serverConnectionHandlerID, fromID))
						
						if(srchBlocked == nil) then
							local match = false
							local mK, mV = nil, nil
							
							for k,v in pairs(commands) do
							
								if(messageStr[1] == v) then
									match = true
									mK, mV = k,v
								end
								
							end
							
							if(match == true) then
								if(prefs["Bot"]["mode"] ~= "1") then
									mK(serverConnectionHandlerID, fromID, ffIgnored, args, targetMode)
								else
									if(mV == "admin" or mV == "a") then
										mK(serverConnectionHandlerID, fromID, ffIgnored, args, targetMode)									
									end
								end
							end
						
						else
							sendChatMsg(serverConnectionHandlerID, "You are [b]blocked[/b] you cannot use commands.", fromID, "private", "red")
						end
					else
						sendChatMsg(serverConnectionHandlerID, "You do not have access to bot commands.", fromID, "private", "red")
					end
			end
		
		
	end
		
	
	
end


local function coreConnectHandler(SCHI, status, errorNum)
	
	if(status == 4) then
		if(tonumber(prefs["Bot"]["soundtype"]) == 1) then
			if(prefs["Bot"]["type"] == "2") then
				--ts3.setClientSelfVariableAsString(SCHI, ts3defs.ClientProperties.CLIENT_INPUT_MUTED, 1)
				--ts3.setClientSelfVariableAsString(SCHI, ts3defs.ClientProperties.CLIENT_OUTPUT_MUTED, 0)
			end
		else
			
			--ts3.setClientSelfVariableAsString(SCHI, ts3defs.ClientProperties.CLIENT_INPUT_MUTED, 0)
			--ts3.setClientSelfVariableAsString(SCHI, ts3defs.ClientProperties.CLIENT_OUTPUT_MUTED, 0)
		end
		
	end
	
end


chatHandlers[function(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored) frigMessageHandler(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored) end] = "coreMessageHandler"

connectHandlers[function(serverConnectionHandlerID, status, err) coreConnectHandler(serverConnectionHandlerID, status, err) end] = "coreConnectHandler"