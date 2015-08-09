require("ts3defs")
require("ts3errors")

local function onClientMoveEvent(schid, clientID, oldChannelID, newChannelID, visibility, moveMessage)
  if visibility == ts3defs.Visibility.ENTER_VISIBILITY then
    local grps, error = ts3.getClientVariableAsString(schid, clientID, ts3defs.ClientProperties.CLIENT_SERVERGROUPS)
    if error == ts3errors.ERROR_ok then
      if grps == "01" then -- replace 00 with the guest group's ID (or whatever group's ID you want to monitor with this)
        ts3.playWaveFile(schid, "./plugins/lua_plugin/guestsound/sound/claves.wav")
      end
    end
  end
end

guestsound_events = {
	onClientMoveEvent = onClientMoveEvent
}