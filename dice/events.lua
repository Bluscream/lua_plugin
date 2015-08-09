--
-- SjoCi kockája TS3-ra / SjoCi's dice for TS3
--

local function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
	local kezdet = string.sub(message,1,1)
	if kezdet=="(" then
		local dpos = string.find(message,"d")
		if dpos~=nil then
			if dpos<=4 then
				local epos = string.find(message,")")
				if epos~=nil then
					if epos<=dpos+4 and epos~=dpos+1 then
						local jo = 1
						local szamok = {}
						if string.sub(message,2,2) ~= "d" then
							for i=1,dpos-2,1 do
								szamok[i]=0
								local szov = string.sub(message,2,dpos-1)
								for j=0,9,1 do
									if tonumber(string.sub(szov,i,i))==j then
										szamok[i]=1
									end
								end
								if szamok[i]==0 then
									jo = 0
								end
							end
						end
						if jo==1 then
							local jo2 = 1
							for i=dpos+1,epos-1,1 do
								szamok[i]=0
								szov = string.sub(message,dpos+1,epos-1)
								for j=0,9,1 do
									if tonumber(string.sub(szov,i-dpos,i-dpos))==j then
										szamok[i]=1
									end
								end
								if szamok[i]==0 then
									jo2 = 0
								end
							end
							if jo2==1 then
								if string.len(string.sub(message,2,dpos-1)) <= 3 or string.sub(message,2,dpos-1) == "d" then
									local dice = tonumber(string.sub(message,dpos+1,epos-1))
									local numberor = 1
									if string.sub(message,2,2)~="d" then
										numberor = tonumber(string.sub(message,2,dpos-1))
									end
									if dice ~= 1 and numberor<=25 then
										local legkev = 1
										local legtobb = dice
										local csatorna = ts3.getChannelOfClient(serverConnectionHandlerID, fromID)
										local koca = 0
										local totalkoca = 0
										local sendMsg =  "[b]["..fromName.."][/b] rolled the dice [b]("..string.sub(message,2,dpos-1).."d"..dice..")[/b]:\n"
										math.randomseed(tonumber(tostring(os.clock()):reverse():sub(1,6)))
										math.random()
										math.random()
										math.random()
										math.randomseed(tonumber(tostring(os.clock()):reverse():sub(1,6))+math.random())
										math.random()
										math.random()
										math.random()
										if tonumber(string.sub(message,2,dpos-1))~=1 and string.sub(message,2,2)~="d" then
											for i=1,tonumber(string.sub(message,2,dpos-1)),1 do
												math.random()
												math.random()
												math.random()
												koca = math.random(dice)
												sendMsg = sendMsg..i..". = "
												if koca==legkev then
													sendMsg = sendMsg.."[b]"..koca.."[/b] -\n"
												elseif koca==legtobb then
													sendMsg = sendMsg.."[b]"..koca.."[/b] !\n"
												else
													sendMsg = sendMsg.."[b]"..koca.."[/b]\n"
												end
												totalkoca = totalkoca + koca
											end
											sendMsg = sendMsg.."Total: [b]"..totalkoca.."[/b]"
										else
											math.random()
											math.random()
											math.random()
											koca = math.random(dice)
											if koca==legkev then
												sendMsg = sendMsg.."[b]"..koca.."[/b] -\n"
											elseif koca==legtobb then
												sendMsg = sendMsg.."[b]"..koca.."[/b] !\n"
											else
												sendMsg = sendMsg.."[b]"..koca.."[/b]\n"
											end
										end
										ts3.requestSendChannelTextMsg(serverConnectionHandlerID, sendMsg, csatorna)
									end
								end
							end
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
