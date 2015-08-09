--------------------------------------------------------------
-- 		  League of Legends Randomizer version 1.1	    	--
--				  		 									--
--	  by Andrew Brennan (mJrA) and Michael Lubos(xQyz) 		--
--		  is licensed under a Creative Commons 				--
--		  Attribution-NonCommercial-ShareAlike 				--
--			  4.0 International License 					--
--------------------------------------------------------------

local function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
	local KeyInput = string.sub(message,1,1)
	if KeyInput=="(" then
		local Test="Code ok until here"
		local StartCheck= string.find(message,"start")
		local Path = {}
		local Path2 = {}
		local channelname = ts3.getChannelOfClient(serverConnectionHandlerID, fromID)
		local Reset = "[b][color=red]!! All roles have been rolled. Please reset the script with:[color=black] (start)[/b]"
		Path[1]="Top"
		Path[2]="Jungle"
		Path[3]="Mid"
		Path[4]="ADC"
		Path[5]="Support"
		Path2[1]="Top"
		Path2[2]="Jungle"
		Path2[3]="Bot"
		if StartCheck ~= nil then
			local Welcome = "\n"
			Welcome = Welcome.. "[b]  _______________________________________________[/b]\n" 
			Welcome = Welcome.. "[b]|[/b]\t\t\t\t\t\t[color=Darkred][b][u]Welcome 2 LoLRandomizer v1.1[/u][/b][color=black]\t\t\t\t\t\t  [b]|[/b]\n"
			Welcome = Welcome.. "[b]|[/b]\t\t\t\t\t  [color=black]This Code was written by [b]mJrA & xQyz[/b]\t\t\t\t\t  [b]|[/b]\n"
			Welcome = Welcome.. "[b]|[/b]\t\t\t\t\t  [color=black]visit us [b]@[/b] [url=ts3server://109.230.238.142?port=9987&nickname=LoLRandomizer%20User&channel=Lobby/Support%20for%20LoLRandomizer&channelpassword=LoLRandomizerPW]eoLithix Network Teamspeak 3[/url]\t\t\t\t\t   [b]|[/b] \n"
			Welcome = Welcome.. "[b]|[/b]\t\t\t\t\t\t\t\t\t\t\t\t\t\t[b]-[/b]\t\t\t\t\t\t\t\t\t\t\t\t\t[b]|[/b]\n"
			Welcome = Welcome.. "[b]|[/b]\t\t\t\t\t\t[b][color=black]Following comands are available[/b]\t\t\t\t\t\t [b]|[/b]\n"
			Welcome = Welcome.. "[b]|[/b]\t\t[color=black]For 5v5 without Champions:[color=darkgreen][b] (p5)[/b] [color=black]with champions: [color=darkgreen][b](p5c)[/b][color=black]\t\t  [b]|[/b]\n"
			Welcome = Welcome.. "[b]|[/b]\t\t[color=black]For 3v3 without Champions:[color=darkgreen][b] (p3)[/b] [color=black]with champions: [color=darkgreen][b](p3c)[/b][color=black]\t\t  [b]|[/b]\n"
			Welcome = Welcome.. "[b]|_______________________________________________|[/b]"			
			ts3.requestSendChannelTextMsg(serverConnectionHandlerID, Welcome, channelname)				
			for i=1,5,1 do
			Path5v5 = io.open("plugins/lua_plugin/LoLRandomizer/data/"..Path[i].."5v5.ini","w")
				Write5v5 = Path5v5:write("0")
			Path5v5:close()
			end
			for i=1,3,1 do
			Path3v3 = io.open("plugins/lua_plugin/LoLRandomizer/data/"..Path2[i].."3v3.ini","w")
				Write3v3 = Path3v3:write("0")
			Path3v3:close()
			end
			for i=1,5,1 do
			Champs = io.open("plugins/lua_plugin/LoLRandomizer/data/Champs"..i..".ini","w")
				WriteChamps = Champs:write("0")
			Champs:close()
			ChampsPicked = io.open("plugins/lua_plugin/LoLRandomizer/data/ChampsPicked.ini","w")
				WriteChampsPicked = ChampsPicked:write("0")
			ChampsPicked:close()
			end
		end
		local ppos = string.find(message,"p")
		local cpos = string.find(message,"c")
		local ccheck=0
		if ppos~=nil then
			if ppos==2 then
				local EndInput = string.find(message,")")

				if cpos==4 and EndInput==cpos+1 then
						ccheck=1
					end
				if EndInput~=nil then
					if EndInput<=ppos+3 and EndInput~=ppos+1 then
								PosNumber = string.sub(message,ppos+1,ppos+1)
								math.randomseed( os.time() )
											math.random()
											math.random()
											math.random()
											math.random()
											math.random()
								if PosNumber == "5" then
										local Role = ""
										local RoleColor = ""
										local RandomNr = 0
										local sendMsg =  "[b]["..fromName.."][/b] has to play [b]("..PosNumber.."v"..PosNumber..")[/b]:"
										local PathCheck2={}

										for i=1,5,1 do
											Path5v5 = io.open("plugins/lua_plugin/LoLRandomizer/data/"..Path[i].."5v5.ini","r")
											PathCheck = Path5v5:read("*number")
											PathCheck2[i] = PathCheck
											Path5v5:close()
										end
										local save=0
										repeat 
										RandomNr = math.random(tonumber(PosNumber))
										save = save +1
										until PathCheck2[RandomNr]==0 or save > 100
										if save > 100 then 
										ts3.requestSendChannelTextMsg(serverConnectionHandlerID, Reset, channelname) 
											for i=1,5,1 do
												Path5v5 = os.remove("plugins/lua_plugin/LoLRandomizer/data/"..Path[i].."5v5.ini","w")
											end
											for i=1,3,1 do
												Path3v3 = os.remove("plugins/lua_plugin/LoLRandomizer/data/"..Path2[i].."3v3.ini","w")
											end	
											for i=1,5,1 do
												ChampsRemove=os.remove("plugins/lua_plugin/LoLRandomizer/data/Champs"..i..".ini","w")
											end
											ChampPickedRemove = os.remove("plugins/lua_plugin/LoLRandomizer/data/ChampsPicked.ini","w")
										return 0
										end
										if RandomNr==1 then
											Role = "Top"
											RoleColor =	"Orange"
											Path5v5 = io.open("plugins/lua_plugin/LoLRandomizer/data/"..Role.."5v5.ini","w")
											Write5v5 = Path5v5:write("1")
											Path5v5:close()
										elseif RandomNr==2 then
											Role = "Jungle"
											RoleColor =	"Green"
											Path5v5 = io.open("plugins/lua_plugin/LoLRandomizer/data/"..Role.."5v5.ini","w")
											Write5v5 = Path5v5:write("1")
											Path5v5:close()
										elseif RandomNr==3 then	
											Role = "Mid"
											RoleColor =	"Blue"
											Path5v5 = io.open("plugins/lua_plugin/LoLRandomizer/data/"..Role.."5v5.ini","w")
											Write5v5 = Path5v5:write("1")
											Path5v5:close()
										elseif RandomNr==4 then
											Role = "ADC"
											RoleColor =	"Red"
											Path5v5 = io.open("plugins/lua_plugin/LoLRandomizer/data/"..Role.."5v5.ini","w")
											Write5v5 = Path5v5:write("1")
											Path5v5:close()
										elseif RandomNr==5 then
											Role = "Support"
											RoleColor =	"Purple"
											Path5v5 = io.open("plugins/lua_plugin/LoLRandomizer/data/"..Role.."5v5.ini","w")
											Write5v5 = Path5v5:write("1")
											Path5v5:close()
										end
											sendMsg = sendMsg.."[b][color="..RoleColor.."]".."   ******"..Role.."******[/b]"
												if ccheck==1 then 													
													local RandomChamp = 0	
													local handle = io.open("plugins/lua_plugin/LoLRandomizer/champs/"..Role..".txt", "r")
													local LoopExit=0
													local linesTable = {}	
													Picked = io.open("plugins/lua_plugin/LoLRandomizer/data/ChampsPicked.ini", "r")
														ChampNumber = Picked:read("*number")
													Picked:close()
													
													if handle then
														for line in handle:lines() do
															table.insert(linesTable, line)
														end
														if ChampNumber==0 then
															RandomChamp = math.random(table.getn(linesTable))												
															ChampNumber = ChampNumber+1
															LoopExit=LoopExit+1
															Champs=io.open("plugins/lua_plugin/LoLRandomizer/data/Champs"..ChampNumber..".ini", "w")
																WriteChamps = Champs:write(linesTable[RandomChamp])
															Champs:close()
															ChampsPicked = io.open("plugins/lua_plugin/LoLRandomizer/data/ChampsPicked.ini", "w")
																ChampNumberWrite = ChampsPicked:write(ChampNumber)
															ChampsPicked:close()	
														elseif ChampNumber==1 then
															repeat
															RandomChamp = math.random(table.getn(linesTable))
															Champs=io.open("plugins/lua_plugin/LoLRandomizer/data/Champs"..ChampNumber..".ini", "r")
																NameChamp1 = Champs:read("*all")
															Champs:close()
															until linesTable[RandomChamp]~=NameChamp1 or LoopExit > 25
															ChampNumber = ChampNumber+1
															LoopExit=LoopExit+1
															Champs=io.open("plugins/lua_plugin/LoLRandomizer/data/Champs"..ChampNumber..".ini", "w")
																WriteChamps = Champs:write(linesTable[RandomChamp])
															Champs:close()
															ChampsPicked = io.open("plugins/lua_plugin/LoLRandomizer/data/ChampsPicked.ini", "w")
																ChampNumberWrite = ChampsPicked:write(ChampNumber)
															ChampsPicked:close()
														elseif ChampNumber==2 then  
															repeat
															RandomChamp = math.random(table.getn(linesTable))
															Champs=io.open("plugins/lua_plugin/LoLRandomizer/data/Champs"..ChampNumber..".ini", "r")
																NameChamp2 = Champs:read("*all")
															Champs:close()	
															until linesTable[RandomChamp]~=NameChamp1 and linesTable[RandomChamp]~=NameChamp2 or LoopExit > 25
															ChampNumber = ChampNumber+1
															LoopExit=LoopExit+1
															Champs=io.open("plugins/lua_plugin/LoLRandomizer/data/Champs"..ChampNumber..".ini", "w")
																WriteChamps = Champs:write(linesTable[RandomChamp])
															Champs:close()
															ChampsPicked = io.open("plugins/lua_plugin/LoLRandomizer/data/ChampsPicked.ini", "w")
																ChampNumberWrite = ChampsPicked:write(ChampNumber)
															ChampsPicked:close()
														elseif ChampNumber==3 then  
															repeat
															RandomChamp = math.random(table.getn(linesTable))
															Champs=io.open("plugins/lua_plugin/LoLRandomizer/data/Champs"..ChampNumber..".ini", "r")
																NameChamp3 = Champs:read("*all")
															Champs:close()	
															until linesTable[RandomChamp]~=NameChamp1 and linesTable[RandomChamp]~=NameChamp2 and linesTable[RandomChamp]~=NameChamp3 or LoopExit > 25
															ChampNumber = ChampNumber+1
															LoopExit=LoopExit+1
															Champs=io.open("plugins/lua_plugin/LoLRandomizer/data/Champs"..ChampNumber..".ini", "w")
																WriteChamps = Champs:write(linesTable[RandomChamp])
															Champs:close()
															ChampsPicked = io.open("plugins/lua_plugin/LoLRandomizer/data/ChampsPicked.ini", "w")
																ChampNumberWrite = ChampsPicked:write(ChampNumber)
															ChampsPicked:close()
														elseif ChampNumber==4 then  
															repeat
															RandomChamp = math.random(table.getn(linesTable))
															Champs=io.open("plugins/lua_plugin/LoLRandomizer/data/Champs"..ChampNumber..".ini", "r")
																NameChamp4 = Champs:read("*all")
															Champs:close()	
															until linesTable[RandomChamp]~=NameChamp1 and linesTable[RandomChamp]~=NameChamp2 and linesTable[RandomChamp]~=NameChamp3 and linesTable[RandomChamp]~=NameChamp4 or LoopExit > 25
															ChampNumber = ChampNumber+1
															LoopExit=LoopExit+1
															Champs=io.open("plugins/lua_plugin/LoLRandomizer/data/Champs"..ChampNumber..".ini", "w")
																WriteChamps = Champs:write(linesTable[RandomChamp])
															Champs:close()
															ChampsPicked = io.open("plugins/lua_plugin/LoLRandomizer/data/ChampsPicked.ini", "w")
																ChampNumberWrite = ChampsPicked:write(ChampNumber)
															ChampsPicked:close()
														end									
														handle:close()
													end
													local myLine = ""

													if #linesTable > 0 then 
														local ChampPic="lol"..linesTable[RandomChamp]
														
														sendMsg = sendMsg.." [b]as "..linesTable[RandomChamp].."[/b]"
														sendMsg = sendMsg.."  [color=white]"..ChampPic.. " \n"
													end	
												end
											ts3.requestSendChannelTextMsg(serverConnectionHandlerID, sendMsg, channelname)
								end
								if PosNumber == "3" then
										local RandomNr = 0
										local PathCheck4={}	
										local sendMsg =  "[b]["..fromName.."][/b] has to play [b]("..PosNumber.."v"..PosNumber..")[/b]:"
										for i=1,3,1 do
											Path3v3 = io.open("plugins/lua_plugin/LoLRandomizer/data/"..Path2[i].."3v3.ini","r")
											PathCheck3 = Path3v3:read("*number")											
											PathCheck4[i] = PathCheck3
											Path3v3:close()	
										end		
										local save=0
										repeat 
										RandomNr = math.random(tonumber(PosNumber))
										save = save +1
										until PathCheck4[RandomNr]==0 or save > 100
										if save > 100 then 
										ts3.requestSendChannelTextMsg(serverConnectionHandlerID, Reset, channelname) 
											for i=1,3,1 do
												Path3v3 = os.remove("plugins/lua_plugin/LoLRandomizer/data/"..Path2[i].."3v3.ini","w")
											end	
											for i=1,5,1 do
												Path5v5 = os.remove("plugins/lua_plugin/LoLRandomizer/data/"..Path[i].."5v5.ini","w")
											end
											for i=1,5,1 do
												ChampsRemove=os.remove("plugins/lua_plugin/LoLRandomizer/data/Champs"..i..".ini","w")
											end
											ChampPickedRemove = os.remove("plugins/lua_plugin/LoLRandomizer/data/ChampsPicked.ini","w")
										return 0
										end
											if RandomNr==1 then
												Role = "Top"
												RoleColor =	"Orange"
												Path3v3 = io.open("plugins/lua_plugin/LoLRandomizer/data/"..Role.."3v3.ini","w")
												Write3v3 = Path3v3:write("1")
												Path3v3:close()
											elseif RandomNr==2 then
												Role = "Jungle"
												RoleColor = "Green"
												Path3v3 = io.open("plugins/lua_plugin/LoLRandomizer/data/"..Role.."3v3.ini","w")
												Write3v3 = Path3v3:write("1")
												Path3v3:close()												
											elseif RandomNr==3 then
												Role = "Bot"
												RoleColor = "Blue"		
												Path3v3 = io.open("plugins/lua_plugin/LoLRandomizer/data/"..Role.."3v3.ini","w")
												Write3v3 = Path3v3:write("1")
												Path3v3:close()
											end
											sendMsg = sendMsg.."[b][color="..RoleColor.."]".."   ******"..Role.."******[/b]"
												if ccheck==1 then 
													local RandomChamp = 0															
													local linesTable = {}													
													local LoopExit=0
													local handle = io.open("plugins/lua_plugin/LoLRandomizer/champs/"..Role.."3v3.txt", "r")
													Picked = io.open("plugins/lua_plugin/LoLRandomizer/data/ChampsPicked.ini", "r")
														ChampNumber = Picked:read("*number")
													Picked:close()
													
													if handle then
														for line in handle:lines() do
															table.insert(linesTable, line)
														end
														if ChampNumber==0 then
															RandomChamp = math.random(table.getn(linesTable))												
															ChampNumber = ChampNumber+1
															LoopExit=LoopExit+1
															Champs=io.open("plugins/lua_plugin/LoLRandomizer/data/Champs"..ChampNumber..".ini", "w")
																WriteChamps = Champs:write(linesTable[RandomChamp])
															Champs:close()
															ChampsPicked = io.open("plugins/lua_plugin/LoLRandomizer/data/ChampsPicked.ini", "w")
																ChampNumberWrite = ChampsPicked:write(ChampNumber)
															ChampsPicked:close()	
														elseif ChampNumber==1 then
															repeat
															RandomChamp = math.random(table.getn(linesTable))
															Champs=io.open("plugins/lua_plugin/LoLRandomizer/data/Champs"..ChampNumber..".ini", "r")
																NameChamp1 = Champs:read("*all")
															Champs:close()
															until linesTable[RandomChamp]~=NameChamp1 or LoopExit > 15
															ChampNumber = ChampNumber+1
															LoopExit=LoopExit+1
															Champs=io.open("plugins/lua_plugin/LoLRandomizer/data/Champs"..ChampNumber..".ini", "w")
																WriteChamps = Champs:write(linesTable[RandomChamp])
															Champs:close()
															ChampsPicked = io.open("plugins/lua_plugin/LoLRandomizer/data/ChampsPicked.ini", "w")
																ChampNumberWrite = ChampsPicked:write(ChampNumber)
															ChampsPicked:close()
														elseif ChampNumber==2 then  
															repeat
															RandomChamp = math.random(table.getn(linesTable))
															Champs=io.open("plugins/lua_plugin/LoLRandomizer/data/Champs"..ChampNumber..".ini", "r")
																NameChamp2 = Champs:read("*all")
															Champs:close()	
															until linesTable[RandomChamp]~=NameChamp1 and linesTable[RandomChamp]~=NameChamp2 or LoopExit > 15
															ChampNumber = ChampNumber+1
															LoopExit=LoopExit+1
															Champs=io.open("plugins/lua_plugin/LoLRandomizer/data/Champs"..ChampNumber..".ini", "w")
																WriteChamps = Champs:write(linesTable[RandomChamp])
															Champs:close()
															ChampsPicked = io.open("plugins/lua_plugin/LoLRandomizer/data/ChampsPicked.ini", "w")
																ChampNumberWrite = ChampsPicked:write(ChampNumber)
															ChampsPicked:close()
														end									
														handle:close()
													end
													local myLine = ""

													if #linesTable > 0 then 
														local ChampPic="lol"..linesTable[RandomChamp]
														
														sendMsg = sendMsg.." [b]as "..linesTable[RandomChamp].."[/b]"
														sendMsg = sendMsg.."  [color=white]"..ChampPic.. " \n"
													end	
												end
											ts3.requestSendChannelTextMsg(serverConnectionHandlerID, sendMsg, channelname)
							end
						end
					end
				end
			end
		end
	return 0
end

diceroll_events = {
	onTextMessageEvent = onTextMessageEvent
}