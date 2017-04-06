require("channelJOIN/settings")
function joinchannel(sCHID, id, pw)
	local ownID = ts3.getClientID(sCHID)
	local cName = ts3.getChannelVariableAsString(sCHID, id, ts3defs.ChannelProperties.CHANNEL_NAME)
	if pw then
		ScriptLog("Trying to join channel [url=channelid://"..id.."]"..cName.."[/url] with password \""..pw.."\".")
		ts3.requestClientMove(sCHID, ownID, id, pw)
	else
		ScriptLog("Trying to join channel [url=channelid://"..id.."]"..cName.."[/url].")
		ts3.requestClientMove(sCHID, ownID, id, channelJOIN.setting.defaultPW)
	end
end
ScriptLog("functions.lua loaded...")