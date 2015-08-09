
function onChannelMove(serverConnectionHandlerID, channelID, newParentChannelID, invokerID, invokerName, invokerUniqueIdentifier)

--print("On channel move event" .. serverConnectionHandlerID, channelID, newParentChannelID, invokerID, invokerName, invokerUniqueIdentifier)
--print("1")
isbadchannel(serverConnectionHandlerID, channelID, newParentChannelID, invokerID, invokerName, invokerUniqueIdentifier)	
--print("prawie koniec on channel move")

return 0
end	
