--
-- Advanced Mass Control Module
-- Version: 1.4
-- Author: Kaptan647
-- Original Author: Willy_Sunny
--

--

require("ts3defs")
require("ts3errors")

--
-- Call these function from the TeamSpeak 3 client console via: /lua run <function>
-- Note the serverConnectionHandlerID of the current server is always passed.
--

--
-- Run with "/lua run getMyChanID"
--
-- Show the curren channel ID that you are in
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
-- Run with "/lua run mm"
--
-- Mass Mover Script (within currently subscribed channel)
--

function mm(serverConnectionHandlerID, ...)

	ts3.printMessageToCurrentTab("= [b][u]Advanced Mass Control Module Version 1.4 by [url=http://r4p3.net/forum/mlist/kaptan647_135]Kaptan647[/url][/u][/b] =")

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
-- Run with "/lua run mp <message>"
--
-- Mass Poke Script (within currently subscribed channel)
--

function mp(serverConnectionHandlerID, ...)

	ts3.printMessageToCurrentTab("= [b][u]Advanced Mass Control Module Version 1.4 by [url=http://r4p3.net/forum/mlist/kaptan647_135]Kaptan647[/url][/u][/b] =")

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
-- Run with "/lua run mmsg <message>"
--
-- Mass Messaging Script (within currently subscribed channel)
--

function mmsg(serverConnectionHandlerID, ...)

	ts3.printMessageToCurrentTab("= [b][u]Advanced Mass Control Module Version 1.4 by [url=http://r4p3.net/forum/mlist/kaptan647_135]Kaptan647[/url][/u][/b] =")

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
-- Run with "/lua run mmp <message>"
--
-- Mass Message & Poke Script (within currently subscribed channel)
--

function mmp(serverConnectionHandlerID, ...)

	ts3.printMessageToCurrentTab("= [b][u]Advanced Mass Control Module Version 1.4 by [url=http://r4p3.net/forum/mlist/kaptan647_135]Kaptan647[/url][/u][/b] =")

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
-- Run with "/lua run gmm"
--
-- Global Mass Mover Script (subscribe all possible channels before moving)
--

function gmm(serverConnectionHandlerID, ...)

	ts3.printMessageToCurrentTab("= [b][u]Advanced Mass Control Module Version 1.4 by [url=http://r4p3.net/forum/mlist/kaptan647_135]Kaptan647[/url][/u][/b] =")

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
-- Run with "/lua run gmp <message>"
--
-- Global Mass Poke Script (subscribe all possible channels before moving)
--

function gmp(serverConnectionHandlerID, ...)

	ts3.printMessageToCurrentTab("= [b][u]Advanced Mass Control Module Version 1.4 by [url=http://r4p3.net/forum/mlist/kaptan647_135]Kaptan647[/url][/u][/b] =")

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
-- Run with "/lua run gmmsg <message>"
--
-- Global Mass Message Script (subscribe all possible channels before moving)
--

function gmmsg(serverConnectionHandlerID, ...)

	ts3.printMessageToCurrentTab("= [b][u]Advanced Mass Control Module Version 1.4 by [url=http://r4p3.net/forum/mlist/kaptan647_135]Kaptan647[/url][/u][/b] =")

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
-- Run with "/lua run gmmp <message>"
--
-- Global Mass Message & Poke Script (subscribe all possible channels before moving)
--

function gmmp(serverConnectionHandlerID, ...)

	ts3.printMessageToCurrentTab("= [b][u]Advanced Mass Control Module Version 1.4 by [url=http://r4p3.net/forum/mlist/kaptan647_135]Kaptan647[/url][/u][/b] =")

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

--
-- Run with "/lua run mk <message>"
--


function mk(serverConnectionHandlerID, ...)

	ts3.printMessageToCurrentTab("= [b][u]Advanced Mass Control Module Version 1.4 by [url=http://r4p3.net/forum/mlist/kaptan647_135]Kaptan647[/url][/u][/b] =")

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

function mck(serverConnectionHandlerID, ...)

	ts3.printMessageToCurrentTab("= [b][u]Advanced Mass Control Module Version 1.4 by [url=http://r4p3.net/forum/mlist/kaptan647_135]Kaptan647[/url][/u][/b] =")

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
			local error = ts3.requestClientKickFromChannel(serverConnectionHandlerID, clients[i], argMsg)
			if error == ts3errors.ERROR_ok then
				counter = counter + 1
			else
				print("Error poking client ID: " .. clients[i] .. "\n")
			end
		end
	end
	ts3.printMessageToCurrentTab("[b][i]== Successfully Kicked From Channel " .. counter .. "/" .. #clients - 1 .. " clients ==[/i][/b]")
end


--
-- Run with "/lua run mb <Duraction> <message>"
--


function mb(serverConnectionHandlerID, ...)

	ts3.printMessageToCurrentTab("= [b][u]Advanced Mass Control Module Version 1.4 by [url=http://r4p3.net/forum/mlist/kaptan647_135]Kaptan647[/url][/u][/b] =")
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

	local timeInSeconds = ""
	if type(arg[1]) ~= "nil" then
		timeInSeconds = arg[1]
		ts3.printMessageToCurrentTab("[b][i]== Mass Baning " .. #clients - 1 .. " visible clients for " .. timeInSeconds .. " seconds ==[/i][/b]")
	else
		ts3.printMessageToCurrentTab("[b][i]== Mass Baning " .. #clients - 1 .. " visible clients ==[/i][/b]")
	end
	
	local banReason = ""
	if type(arg[2]) ~= "nil" then
		banReason = arg[2]
		ts3.printMessageToCurrentTab("[b][i]== Mass Baning " .. #clients - 1 .. " visible clients with " .. banReason .. " message ==[/i][/b]")
	else
		ts3.printMessageToCurrentTab("[b][i]== Mass Baning " .. #clients - 1 .. " visible clients ==[/i][/b]")
	end
	
	local counter = 0
	ts3.printMessageToCurrentTab("[b][i]== Mass Baning " .. #clients - 1 .. " visible clients ==[/i][/b]")
	for i=1, #clients do
		if clients[i] ~= myClientID then
			local error = ts3.banclient(serverConnectionHandlerID,clients[i],  timeInSeconds, banReason)						
			if error == ts3errors.ERROR_ok then
				counter = counter + 1
			else
				print("kullanicilar pokelenirken sorun cikti: " .. clients[i] .. "\n")
			end
		end
	end
	ts3.printMessageToCurrentTab("[b][i]== Successfully Baned From Server " .. counter .. "/" .. #clients - 1 .. " clients ==[/i][/b]")
end


--
-- Run with "/lua run md"
--

function md(serverConnectionHandlerID, ...)

	ts3.printMessageToCurrentTab("= [b][u]Advanced Mass Control Module Version 1.4 by [url=http://r4p3.net/forum/mlist/kaptan647_135]Kaptan647[/url][/u][/b] =")

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

	local channels, error = ts3.getChannelList(serverConnectionHandlerID)
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
	ts3.printMessageToCurrentTab("[b][i]== Deleting " .. #channels - 1 .. " Channels ==[/i][/b]")
	for i=1, #channels do
		if channels[i] ~= myChannelID then
			local error = ts3.requestChannelDelete(serverConnectionHandlerID, channels[i] , 1)
			if error == ts3errors.ERROR_ok then
				counter = counter + 1
			else
				print("Error Deleting Channel ID: " .. channels[i] .. "\n")
			end
		end
	end
	ts3.printMessageToCurrentTab("[b][i]== Successfully Deleted " .. counter .. "/" .. #clients - 1 .. " Channels ==[/i][/b]")
end

