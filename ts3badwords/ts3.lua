-- deflauts global
require("ts3defs")
require("ts3errors")
qwe_friend = "plugins/lua_plugin/ts3badwords/friend.txt"
qwe_banfile = "plugins/lua_plugin/ts3badwords/ban.txt"

--module(myteamspeak);
--user
function getuserUID(SID, CLID) 
local uuuid, error = ts3.getClientVariableAsString(SID, CLID, 0)
	if error ~= ts3errors.ERROR_ok then print("Error getting client list: " .. error) return 0 end
	return uuuid
	end
function getusername(SID, CLID) return ts3.getClientVariableAsString(SID, CLID, 1) end
function getuserawaymes(SID, CLID) return ts3.getClientVariableAsString(SID, CLID, 39) end
function getusertalkrequestmes(SID,CLID) return ts3.getClientVariableAsString(SID, CLID, 44) end
function getuserdesc(SID,CLID) return ts3.getClientVariableAsString(SID, CLID, 45) end
function getuserpro(SID, CLID, IDENT) return ts3.getClientVariableAsString(SID, CLID, IDENT) end

-- channel
function ccname(SID, channelID)
local tre, error = ts3.getChannelVariableAsString(SID, channelID, 0)
	if error ~= ts3errors.ERROR_ok then print("BUG: Error getting client list: " .. error) return 0 end
	return tre
	end
function cctopic(SID, channelID) return ts3.getChannelVariableAsString(SID, channelID, 1) end
function ccdesc(SID, channelID) return ts3.getChannelVariableAsString(SID, channelID, 2) end
function cphonetic(SID, channelID) return ts3.getChannelVariableAsString(SID, channelID, 30) end
function getchannelpro(SID,channelID,IDENT) return ts3.getClientVariableAsString(SID, CLID, IDENT) end

-- extend BBCODE functions 
function userBBcode(SID, clientID) return "[b][url=client://"..clientID.."/" .. getuserpro(SID,clientID,0) .."~"..getusername(SID, clientID).."]"..getusername(SID, clientID).."[/url][/b]" end
function chBBcode(SID, channelID) return "[b][url=channelid://"..channelID.."]" .. ccname(SID, channelID).. "[/url][/b]" end

--messange
function msg_c(SID,txtx,CHANID) return ts3.requestSendChannelTextMsg(SID, txtx, CHANID) end
function msg_p(SID,txt,UID) return ts3.requestSendPrivateTextMsg(SID, txt, UID) end
function msg_t(what) return ts3.printMessageToCurrentTab(what) end
function msg_chattab(what,where) return ts3.printMessage(where, what, 1) end
function msg_servertab(what, where) return ts3.printMessage(where, what, 0) end
function msg_s(SID, message) return ts3.requestSendServerTextMsg(SID, message) end