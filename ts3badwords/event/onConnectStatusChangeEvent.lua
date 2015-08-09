function onConnectStatusChangeEvent(serverConnectionHandlerID, status, errorNumber)
	if status == 4 then
		local ll = ts3.getCurrentServerConnectionHandlerID()
		local oij, error = ts3.getClientID(ll)	
		local dat = read_word()
 
	ts3.requestSendPrivateTextMsg(ll, "[b][color=blue] " .. msg_helo .. ver .. by .. "\r\n" .. msg_helo2 .. " [b]Menü: \r\n! add DEIN WORT = Hinzufügen von Worten auf die Badwordsliste\r\n! del DEIN WORT = Löschen von Worten aus der Badwordsliste\r\n! fre = Suche Freunde aus der BadWords-Freundesliste (nicht aus Kontakten)\r\n! frdel UserName = Lösche ein User von der BadWords-Freundesliste\r\n! fradd wD3uiVIN6Wvd+u9Z8OSFDHHiFzY= = Füge einen Freund zur BadWords-Freundesliste hinzu[/b]", oij )
	msg_t("Deine BadWords Liste")
	for b,n in ipairs(dat) do msg_t(n) end 
	msg_t("Ende deiner BadWords Liste")

	end
end