require("NoX/settings")
local function isempty(s)
  return s == nil or s == ''
end
function antix(serverConnectionHandlerID, arg, value)
	if not isempty(arg) then
		arg = string.lower(arg)
	end
	if not isempty(value) then
		value = string.lower(value)
	end
	if arg == "bc" then
		if isempty(value) then
			ts3.printMessageToCurrentTab("NoX: Ban count = "..nox.var.bancount)
		elseif value == "reset" then
			ts3.printMessageToCurrentTab("NoX: Resetted ban count")
			nox.var.bancount = 0
		else
			ts3.printMessageToCurrentTab("NoX: Setting ban count from "..nox.var.bancount.." to "..value)
			nox.var.bancount = value
		end
	end
end
function clock(serverConnectionHandlerID)
	local x = os.clock()
		ts3.printMessageToCurrentTab(x)
end
function time(serverConnectionHandlerID)
	local x = os.time()
		ts3.printMessageToCurrentTab(x)
end
function setID(serverConnectionHandlerID)
	var_i = math.random(0,nox.setting.AmountOfIDs)
	if var_i == nox.var.lastID then
		setID(serverConnectionHandlerID)
		return
	end
	if nox.setting.slowmode == true then
		nox.var.checkForKick = true
		nox.func.checkForSwitch = true
	else
		if nox.setting.failsave == true then
			nox.var.variables_Requested = "true"
			ts3.requestServerVariables(serverConnectionHandlerID)
			ScriptLog("[Flood] Requested Server Variables.")
		else
			reJoin(serverConnectionHandlerID)
		end
	end
end
function reJoin(serverConnectionHandlerID)
	local clientIDown = ts3.getClientID(serverConnectionHandlerID)
	local ip = ts3.getConnectionVariableAsString(serverConnectionHandlerID, clientIDown, 6)
	local port = ts3.getConnectionVariableAsUInt64(serverConnectionHandlerID, clientIDown, 7)
	local ip = ip .. ":" ..port
	local nickName = ts3.getClientSelfVariableAsString(serverConnectionHandlerID, 1)
	local channelPassworded = ts3.getChannelVariableAsInt(serverConnectionHandlerID, KickedChannelID, ts3defs.ChannelProperties.CHANNEL_FLAG_PASSWORD)
	if channelPassworded == 0 then
		if not isempty(nox.var.lastbanned) then
			if os.time() > nox.var.lastbanned + 5 then
				nox.var.bancount = nox.var.bancount
			elseif os.time() > nox.var.lastbanned + 10 then
				nox.var.bancount = nox.var.bancount - 1
			else
				nox.var.bancount = nox.var.bancount + 1
			end
		end
		nox.var.lastbanned = os.time()
		ScriptLog("Last Banned: "..nox.var.lastbanned)
		ScriptLog("Bancount: "..nox.var.bancount)
		local TempKickedChannelNAME = string.gsub(KickedChannelNAME, '%/', '%\\/')
		ts3.guiConnect(1, "NoX #" .. var_i,ip, "", nickName,TempKickedChannelNAME,"","","","","",nox.setting.IDPrefix .. var_i,"","")
		nox.var.lastID = var_i
		ScriptLog("Saved last ID as #" .. nox.var.lastID )
		nox.var.checkChannel = true
		if nox.setting.auto_slowmode == true then
			if nox.var.bancount >= 3 then
				nox.setting.slowmode = true
				nox.func.checkForSwitch = true
			end
		end
	end
end
ScriptLog("functions.lua loaded...")