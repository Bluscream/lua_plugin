require("ts3defs") 
require("ts3errors") 

local function onConnectStatusChangeEvent(serverConnectionHandlerID, status, errorNumber)
	if status == ts3defs.ConnectStatus.STATUS_CONNECTING then
		ts3.setClientSelfVariableAsInt(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_AWAY, 1)
		ts3.setClientSelfVariableAsInt(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_INPUT_MUTED, ts3defs.MuteInputStatus.MUTEINPUT_MUTED)
		ts3.setClientSelfVariableAsInt(serverConnectionHandlerID, ts3defs.ClientProperties.CLIENT_OUTPUT_MUTED, ts3defs.MuteOutputStatus.MUTEOUTPUT_MUTED)
	end
end

startaway_events = {
	onConnectStatusChangeEvent = onConnectStatusChangeEvent
}