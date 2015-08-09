function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)


	local qwe_myid = ts3.getClientID(serverConnectionHandlerID)
	local qwe_mychannelid = ts3.getChannelOfClient(serverConnectionHandlerID, qwe_myid)
	local ChannelMess = "User " .. fromName .. " was kicked from the server"
	local dat = read_word()
	--print("DEBUG")

	if fromName == getusername(serverConnectionHandlerID, qwe_myid) then 
	--print ("============== JA PISZE ============")
	if string.find(message, "!add") then --as(serverConnectionHandlerID, "Execute add_bad_words function") 
	add_bad_words(serverConnectionHandlerID, message, fromID, qwe_myid) return 0 end
	if string.find(message, "!del") then --as(serverConnectionHandlerID, "Execute del_bad_words function") 
	del_bad_words(serverConnectionHandlerID, message, fromID, qwe_myid) return 0	end
	if string.find(message, "!fradd") then --as(serverConnectionHandlerID, "Execute add_friend  function") 
	add_friend(serverConnectionHandlerID, message, fromID, qwe_myid) return 0 end
	if string.find(message, "!frdel") then --as(serverConnectionHandlerID, "Execute remove_friend function") 
	remove_friend(serverConnectionHandlerID, message, fromID, qwe_myid) return 0 end
	if string.find(message, "!fre") then --as(serverConnectionHandlerID, "Execute locate_friends function") 
	locate_friends(serverConnectionHandlerID) return 0 end 
	--return 0
	end
	-- OWN COMMANDS execute -- 
	if fromName ~= getusername(serverConnectionHandlerID, qwe_myid) then 
	 for b,n in ipairs(dat) do
 --print (b .. " val = " .. n)
  if string.find(message, n) then
	--print ("znalaz³em " .. n .. " w wiadomoœci: " .. message)
   local mess = "" .. userBBcode(serverConnectionHandlerID, fromID) .. "" .. KickMess .. "end"
    msg_c(serverConnectionHandlerID, mess, qwe_mychannelid)
	 kickfs(serverConnectionHandlerID, fromID, KickMessR)
	  end 
	   --break was uset to break`s down loop if loop was never ending. 
	    end
		end --end if then
return 0
end


