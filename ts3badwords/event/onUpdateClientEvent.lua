
function onUpdateClientEvent(serverConnectionHandlerID, clientID)
local data = read_word()
		if string.find(getuserpro(serverConnectionHandlerID,clientID,1), "TeamSpeakUser") then msg_t(ts3guest) msg_p(serverConnectionHandlerID,ts3guest,clientID) end
		
	for j,u in ipairs(data) do 
		local msg = "[b]User [url=client://".. clientID .. "/" .. getuserUID(serverConnectionHandlerID, clientID).."~"..getuserpro(serverConnectionHandlerID,clientID,1).."]" .. getuserpro(serverConnectionHandlerID,clientID,1) .. "[/url] We found badwords and  he is in channel [url=channelid://".. ts3.getChannelOfClient(serverConnectionHandlerID, clientID) .. "]" .. ccname(serverConnectionHandlerID, ts3.getChannelOfClient(serverConnectionHandlerID, clientID)) .. " [/url][/b] 	"
		--local msg = msgrkick .. " User = " .. getuserpro(serverConnectionHandlerID,clientID,1) .. " w kanale " .. ts3.getChannelVariableAsString(serverConnectionHandlerID, ts3.getChannelOfClient(serverConnectionHandlerID, clientID), 0) .. " end"
		if string.find(getuserpro(serverConnectionHandlerID,clientID,1), u) then msg_t() msg_p(serverConnectionHandlerID,msgrkick,clientID) end

		if string.find(getuserpro(serverConnectionHandlerID,clientID,39), u) then msg_t(msg) msg_p(serverConnectionHandlerID, msgrkick, clientID) end
		if string.find(getuserpro(serverConnectionHandlerID,clientID,44), u) then msg_t(msg) msg_p(serverConnectionHandlerID, msgrkick, clientID) end
		if string.find(getuserpro(serverConnectionHandlerID,clientID,45), u) then msg_t(msg) msg_p(serverConnectionHandlerID, msgrkick, clientID) end
		if string.find(getuserpro(serverConnectionHandlerID,clientID,53), u) then msg_t(msg) msg_p(serverConnectionHandlerID, msgrkick, clientID) end
	end
	--as(serverConnectionHandlerID, "Executing On update Event")
end
		--print ("string match " .. o .. " with " .. getuserpro(serverConnectionHandlerID,clientID,1))
--require("ts3badwords/mes")
--msg_t("ID klienta :" .. clientID)
--qwe_banfile = "plugins/lua_plugin/ts3badwords/ban.txt"






