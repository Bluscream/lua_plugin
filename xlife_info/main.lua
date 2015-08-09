require("ts3defs")
require("ts3errors")
require("ts3init")
require("ts3autoload")
require("ts3events")

function xprint(msg)
	--ts3.printMessageToCurrentTab(msg) --Remove "--" to activate Debug Output
end

function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
	if string.lower(string.sub(message, 1, 4)) == "info" then
		if string.lower(string.sub(message, 6, 13)) == "editline" then
			editline(fromID, fromName, fromUniqueIdentifier, string.sub(message, 15, string.len(message)))
		elseif string.lower(string.sub(message, 6, 8)) == "add" then
			save(fromID, fromName, fromUniqueIdentifier, string.sub(message, 10, string.len(message)))
		elseif string.lower(string.sub(message, 6, 9)) == "show" then
			show(fromID, string.sub(message, 11, string.len(message)))
		elseif string.lower(string.sub(message, 6, 11)) == "update" then
			updateNick(fromID, fromName, fromUniqueIdentifier)
		elseif string.lower(string.sub(message, 6, 12)) == "delline" then
			deleteLine(fromID, fromUniqueIdentifier, string.sub(message, 14, string.len(message)))
		elseif string.lower(string.sub(message, 6, 10)) == "delme" then
			deleteClient(fromID, fromUniqueIdentifier, string.sub(message, 12, string.len(message)))
		elseif string.lower(string.sub(message, 6, 9)) == "list" then
			list(fromID, fromUniqueIdentifier, string.sub(message, 11, string.len(message)))
		else
			help(fromID)
		end
	end	
end

function Pvtmsg(txt, ClientID)
	local serverConnectionHandlerID = ts3.getCurrentServerConnectionHandlerID()
	local error = ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, txt, ClientID)
	if error ~= ts3errors.ERROR_ok then xprint("Error sending message: " .. error) end
end

function help(ClientID)
	Pvtmsg("Help for the Info Lua Script:", ClientID)
	Pvtmsg('"info list" <Site>: Lists all Clients!', ClientID)
	Pvtmsg('"info add <LineInfo>": Adds a new line to your description!', ClientID)
	Pvtmsg('"info editline <NumberLine> <LineInfo>": Edits a line of your description!', ClientID)
	Pvtmsg('"info show <ClientName>": Displays the description of an client! Not case sensitive!', ClientID)
	Pvtmsg('"info update": Updates your nickname in the DB!', ClientID)
	Pvtmsg('"info delline <NumberLine>": Deletes a line of your description!', ClientID)
	Pvtmsg('"info delme <Confirm>": Deletes yourself out of the DB!', ClientID)
	Pvtmsg('© xLife | Felix E-Mail: "xLifeHD@gmail.com"', ClientID)
end

function editline(ClientID, Nickname, UniqueID, Line)
	local serverConnectionHandlerID = ts3.getCurrentServerConnectionHandlerID()
	local X = 0
	local exists = false
	loadFile()
	for index, value in ipairs(data) do
		xprint(index.." | "..tostring(value))
		if value[2] == UniqueID then
			exists = true
			X = index
		end
	end
	Pos1, Pos2 = string.find(Line, " ")
	numLine = tonumber(string.sub(Line, 1, Pos2-1))
	Line = string.sub(Line, Pos2+1, string.len(Line))
	Line, often = string.gsub(Line, "\n", "")
	if exists == true and numLine > 0 and numLine <= #data[X][3] then
		data[X][3][numLine] = Line -- Editing one line
		Pvtmsg("Edited Line: "..numLine.."!", ClientID)
		data[X][1] = Nickname -- Update the Nickname
	elseif numLine <= 0 or numLine > #data[X][3]then
		Pvtmsg("There is no line: "..numLine.."!", ClientID)
	else
		Pvtmsg("Error: Client does not exist! To create an client simply run \"info add <Line>\"", ClientID)
	end
	updateFile()
end

function save(ClientID, Nickname, UniqueID, Line)
	local serverConnectionHandlerID = ts3.getCurrentServerConnectionHandlerID()
	local X = 0
	local exists = false
	loadFile()
	for index, value in ipairs(data) do
		xprint(index.." | "..tostring(value))
		if value[2] == UniqueID then
			exists = true
			X = index
		end
	end
	Line, often = string.gsub(Line, "\n", "")
	if exists == true and #data[X][3] < 10 then
		data[X][3][#data[X][3]+1] = Line -- Adding one line
		data[X][1] = Nickname -- Changing the Nickname
		Pvtmsg("Added one line!", ClientID)
	elseif exists == false then
		data[#data+1]={Nickname, UniqueID, {Line}} -- Creating a new User
		X = #data --Debug
		Pvtmsg("Client added to DB!", ClientID)
	else
		Pvtmsg("Too many lines (max. 10)!", ClientID)
	end
	updateFile()
end

function show(ClientID, Nickname)
	local serverConnectionHandlerID = ts3.getCurrentServerConnectionHandlerID()
	local X = 0
	local exists = false
	loadFile()
	if Nickname ~= "" then
		for index, value in ipairs(data) do
			if string.find(string.lower(value[1]), string.lower(Nickname)) ~= nil then
				exists = true
				X = index
			end
		end
	end
	if exists == true then
					--1234                 5 6789      10                11
		namestr = "[B]\""..data[X][1].."\"[/B]═UID: \""..data[X][2].."\""
		outstr = ""
		for i = 1, math.ceil((71 - (string.len(namestr) - 11)) / 2 ) + 5 do
			outstr = outstr.."═"
		end
		outstr = outstr..namestr
		for i = 1, math.floor((71 - (string.len(namestr) - 11)) / 2 ) + 5 do
			outstr = outstr.."═"
		end
		Pvtmsg(outstr, ClientID)
		for index, value in ipairs(data[X][3]) do
			if value == "" then value = " " end
			Pvtmsg(value, ClientID)
		end
		Pvtmsg("══════════════════════════════════END══════════════════════════════════", ClientID)
	else
		Pvtmsg("Error: Client does not exist! To create an client simply run \"info add <Line>\"", ClientID)
	end
end

function list(ClientID, UniqueID, txt)
	site = tonumber(txt)
	loadFile()
	maxsites = math.ceil(#data/10)
	if site <= maxsites and site > 0 then
		head = "[B]Site: " .. site .. "/" .. maxsites .. "[/B]"
		outstr = ""
		for i = 1, math.ceil((71 - (string.len(head) - 7)) / 2 ) + 2 do
			outstr = outstr.."═"
		end
		outstr = outstr..head
		for i = 1, math.floor((71 - (string.len(head) - 7)) / 2 ) + 2 do
			outstr = outstr.."═"
		end
		Pvtmsg(outstr, ClientID)
		--  i = 1, 10
		--  i = 11, 20 
		for i = 10 * site - 9, 10 * site do
			if i <= #data then
				outstr = "| Nick: " .. data[i][1]
				for i2 = 1, (40 - string.len(outstr)) * 2 do
					outstr = outstr.." "
				end
				outstr = outstr .. "| UID: " .. data[i][2]
				for i2 = 1, (81 - string.len(outstr)) * 2 do
					outstr = outstr .. " "
				end
				outstr = outstr .. "|"
				Pvtmsg(outstr, ClientID)
			end
		end
		Pvtmsg("══════════════════════════════════END══════════════════════════════════", ClientID)
	elseif site > maxsites then
		Pvtmsg("There is no site: " .. site .. "!", ClientID)
	else
		Pvtmsg("There is no site: " .. site .. "!", ClientID)
	end
end

function updateFile()
	file = assert(io.output("plugins/lua_plugin/xlife_info/data.db", "w"))
	for i, v in ipairs(data) do
		str = '#:"'..tostring(#v[3])..'",N:"'..v[1]..'",U:"'..v[2]..'"'
		for i2, v2 in ipairs(v[3]) do
			str = str..',L'..tostring(i2)..':"'..v2..'"'
		end
		str = str.."\n"
		file:write(str)
	end
	file:flush()
	file:close()
end
--table structure: data{{Nickname, UniqueID, {Line1, Line2, Line3, ...}},{Nickname, UniqueID, {Line1, Line2, Line3, ...}}
--File Structure: #:"3",N:"Nickname",U:"UniqueID",L1:"42",L2:"JOO",L3:"Miau"
function loadFile()
	file = assert(io.open("plugins/lua_plugin/xlife_info/data.db", "r"))
	line = file:read("*line")
	if line ~= nil then
		data = {}
		count = 1
		repeat
			data[count] = {"","",{}}
			x, Pos1 = string.find(line, '#:"')
			Pos2, x = string.find(line, '",N:"')
			liness = tonumber(string.sub(line, Pos1 + 1, Pos2 - 1))
			x, Pos1 = string.find(line, '",N:"')
			Pos2, x = string.find(line, '",U:"')
			data[count][1] = string.sub(line, Pos1 + 1, Pos2 - 1)
			x, Pos1 = string.find(line, '",U:"')
			Pos2, x = string.find(line, '",', Pos1)
			data[count][2] = string.sub(line, Pos1 + 1, Pos2 - 1)
			for i = 1, liness do
				x, Pos1 = string.find(line, '",L'..tostring(i)..':"')
				Pos2, x = string.find(line, '"', Pos1+1)
				if Pos1 ~= nil and Pos2 ~= nil then
					data[count][3][i] = string.sub(line, Pos1 + 1, Pos2 - 1)
				end
			end
			ende = false
			count = count + 1
			line = file:read("*line")
		until line == nil
	end
	file:close()
end

function updateNick(ClientID, Nickname, UniqueID)
	local serverConnectionHandlerID = ts3.getCurrentServerConnectionHandlerID()
	local X = 0
	local exists = false
	loadFile()
	for index, value in pairs(data) do
		if value[2] == UniqueID then
			exists = true
			X = index
		end
	end
	if exists == true then
		data[X][1] = Nickname -- Changing the Nickname
		updateFile()
		Pvtmsg("Nickname updated!", ClientID)
	else
		Pvtmsg("Error: Client does not exist! To create an client simply run \"info add <Line>\"", ClientID)
	end
end

function deleteLine(ClientID, UniqueID, numLine)
	local serverConnectionHandlerID = ts3.getCurrentServerConnectionHandlerID()
	local X = 0
	local exists = false
	loadFile()
	for index, value in pairs(data) do
		if value[2] == UniqueID then
			exists = true
			X = index
		end
	end
	if exists == true and tonumber(numLine) > 0 and tonumber(numLine) <= #data[X][3] and #data[X][3] > 1 then
		table.remove(data[X][3], tonumber(numLine))
		updateFile()
		Pvtmsg("Deleted Line: "..numLine.."!", ClientID)
	elseif exists == false then
		Pvtmsg("Error: Client does not exist! To create an client simply run \"info add <Line>\"", ClientID)
	elseif tonumber(numLine) < 1 or tonumber(numberLine) > #data[X][3]then
		Pvtmsg("Error: Line does not exist!", ClientID)
	elseif #data[X][3] > 1 then
		Pvtmsg("Error: A minimum of 2 lines is required to delete 1 line!", ClientID)
	end
end

function deleteClient(ClientID, UniqueID, Msg)
	local serverConnectionHandlerID = ts3.getCurrentServerConnectionHandlerID()
	loadFile()
	if string.lower(Msg) == "yes" then
		local X = 0
		local exists = false
		for index, value in pairs(data) do
			if value[2] == UniqueID then
				exists = true
				X = index
			end
		end
		if exists == true then
			table.remove(data[X])
			updateFile()
			Pvtmsg("Deleted Line: "..numLine.."!", ClientID)
		end
	else
		Pvtmsg("Are you sure, that you want to erase yourself in the DB? If you are run \"info delme yes\"", ClientID)
	end
end

local error = ts3.playWaveFile(serverConnectionHandlerID, ts3.getResourcesPath().."/plugins/lua_plugin/xlife_info/plugin_activated.wav")
if error ~= ts3errors.ERROR_ok then
	xprint("Error playing Wave File: " .. error)
	return
end