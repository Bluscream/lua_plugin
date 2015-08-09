require("ts3defs")
require("ts3errors")
lastChan = {}
AFKChan = 0
--TODO
--Automate idle movement after 10 min
function execAFK(serverConnectionHandlerID)
--This finds the ID of the server's AFK channel
--AFK channel must be named AFK
local channels, error = ts3.getChannelList(serverConnectionHandlerID)
	msg = "Channel list:"
	for e=1, #channels do
			local channelName, error = ts3.getChannelVariableAsString(serverConnectionHandlerID, channels[e], ts3defs.ChannelProperties.CHANNEL_NAME)
			if channelName == "++++++++++A--F--K++++++++++" then
			AFKChan = channels[e]
			ts3.printMessageToCurrentTab("Channel " .. channels[e] .. " was set to be this server's AFK channel.")
			else
			AFKChan = AFKChan
			end
			end
	local clients, error = ts3.getClientList(serverConnectionHandlerID)
	for i=1, #clients do
	lastChan[i]=307
	end
end

function showAFK(serverConnectionHandlerID)
	ts3.printMessageToCurrentTab("Executing AFK scan")
	local clients, error = ts3.getClientList(serverConnectionHandlerID)
	msg = "Client list:"
	for i=1, #clients do
			local clientName, error = ts3.getClientVariableAsString(serverConnectionHandlerID, clients[i], ts3defs.ClientProperties.CLIENT_NICKNAME)
			local requestError = ts3.requestClientVariables(serverConnectionHandlerID, clients[i])
			local clientIdle, error = ts3.getClientVariableAsInt(serverConnectionHandlerID, clients[i], ts3defs.ClientProperties.CLIENT_IDLE_TIME)
			if error == ts3errors.ERROR_ok then
			msg = msg .. "\n" .. clients[i] .. " " .. clientName .. " " .. clientIdle
			end
			end
			ts3.printMessageToCurrentTab(msg)
end

function onTalkStatusChangeEvent(serverConnectionHandlerID, status, isReceivedWhisper, clientID)
	local channelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, clientID)
	if channelID == AFKChan then
	ts3.requestClientMove(serverConnectionHandlerID, clientID, lastChan[clientID], 0)
	end
end

function mAFK (serverConnectionHandlerID, clientID)
local channelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, clientID)
ts3.printMessageToCurrentTab("Client to move " .. clientID)
ts3.printMessageToCurrentTab("\nClient's current channel is " .. channelID)
	if channelID == AFKChan then
	else
	lastChan[clientID] = channelID
	ts3.requestClientMove(serverConnectionHandlerID, clientID, AFKChan, 0)
	end
ts3.printMessageToCurrentTab("\n AFKstatus has been set to " .. AFKstatus)
end

function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
if message == "!AFK" then
local channelID, error = ts3.getChannelOfClient(serverConnectionHandlerID, fromID)
	if channelID == AFKChan then
	else
	lastChan[fromID] = channelID
	ts3.requestClientMove(serverConnectionHandlerID, fromID, AFKChan, 0)
end
end
end