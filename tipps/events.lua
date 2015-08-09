require("ts3defs")

function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
    if letzerTipp == nil then
        letzerTipp = 0
    end
    if os.time() - 60 > letzerTipp then
        --ts3.printMessageToCurrentTab(os.time() - 30 .. ">" .. letzerTipp)
        nBeginn, nEnde = string.find(string.upper(message), "reden")
        if nBeginn > 0 and nEnde > 0 then
            ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "at2: [b]Du willst mitreden?[/b]\nRechtsklick auf euren eigenen Namen und auf Talk Power anfordern klicken.", fromID)
        end
        letzerTipp = os.time()
    end
    nBeginn, nEnde = string.find(string.upper(message), "at")
    if (nBeginn == 0) then
        letzerTipp = os.time()
    end
    --MyID = ts3.getClientID(serverConnectionHandlerID)
    
end



function onClientMoveEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, moveMessage)

    local name = ""
    if letzerTipp == nil then
        letzerTipp = 0
    end
    if (newChannelID == ts3.getChannelOfClient(serverConnectionHandlerID, ts3.getClientID(serverConnectionHandlerID))) then
        --ts3.printMessageToCurrentTab("| > > > " .. newChannelID)
        if (ts3.getServerVariableAsString(serverConnectionHandlerID, ts3defs.VirtualServerProperties.VIRTUALSERVER_UNIQUE_IDENTIFIER) == "CxOLw6ev+Mun0Bm5+1N/rJDwKtI=" and newChannelID == 5) then
            if os.time() - 60 > letzerTipp then
                ts3.requestSendChannelTextMsg(serverConnectionHandlerID, "at1: [b]brauchst du Hilfe?[/b]\nRechtsklick auf euren eigenen Namen und auf Talk Power anfordern klicken. Als Grund bitte das Problem angeben.", newChannelID)
                letzerTipp = os.time()
                name = ts3.getClientVariableAsString(serverConnectionHandlerID, clientID, ts3defs.ClientProperties.CLIENT_NICKNAME)
                ts3.printMessageToCurrentTab("------------->Client ID: " .. clientID .. " - name: " .. name)
            end
        end
    end
end

tipps_events = {
	onTextMessageEvent = onTextMessageEvent
	onClientMoveEvent = onClientMoveEvent
}