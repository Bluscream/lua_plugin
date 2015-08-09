require("channelKicker/settings")
function Set (list)
  local set = {}
  for _, l in ipairs(list) do set[l] = true end
  return set
end
clientAwayWhitelistMSG = "afk"
whitelistUIDs = Set { 'e3dvocUFTE1UWIvtW8qzulnWErI=', 'eVAaW2DkZC8qhLLM2io3xP4NjxM=', 'y7iQ9Ad9+nx4B2geCQxXF2IZt34=', 'THZOH1fdIPf2BZR1UEcTGiCKJj4=', 'KXzGE6kpFkEsySL9mDB/N1wX6dc=', 'F81ea9vlCwxS/xBjQuo37RytLuE=', 'pkLWdDQ/Er0/ws6X128Mas8dcE0=','x86scd2iqqLBvihyY7nrqks7V/4='}
DefaultNickArray = { 'teamspeakuser', 'android', 'iphone' }
BadCharArray = { '&#3178;', '&#21328;', '&#21325;', '%d+%.%d+%.%d+%.%d', '%w%w%w%w::%w%w%w%w::%w%w%w%w::%w%w%w%w', '%w%w%w%w:%w%w%w%w:%w%w%w%w:%w%w%w%w:%w%w%w%w:%w%w%w%w:%w%w%w%w:%w%w%w%w' }
BadNickArray = { 'lore', 'kev', 'sling', 'gommehd', 'ungespielt', 'gronkh', 'rewinside', 'dner' }
BannedNickArray = { 'ramiz karaeski', 'sh0xx', '-= pietro =-', 'xX Reko Xx', '°°[iPandaChris]°°', 'HerbertHD', 'Ha.Be', 'HA.BE', 'Wurst', 'Aerotos' }
BannedUIDArray = { '28E2/z3FENezKJJhvHS2HP1nxkI=', 'EEK17/THKGE554xyH4hWnE4py0w=' }
BadWordArray = { 'hurensohn', 'ddos', 'wichser', 'egal', 'lizard', 'asshole', 'arschloch', 'fick', 'anus', 'scheide', 'vagina', 'fotze', 'schlampe', 'hitler', 'adolf', 'sieg', 'heil' }
BadOSArray = { 'OS X', 'iOS' }
BadCountryArray = { 'FR', 'AU' }
LinkArray = { '%://', 'www%.', '%.net', '%.de', '%.com', '%.me', '%.tk' }
bugStringfreeze = "%[img%]"
bugStringclear = 'width="999999999'
IDArray = { 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9' }
UID_mtG = "LpfWDi8tO9blye3wZXZZ76uPAM8="
UID_gomme = "FI9+KF1c/BKx5dlFejAs8OJpnO0="
UID_ts3live = "zyGoi6QIUW9fkW+KwZRv6E5d4D8="
UID_gronkh = "xrCRBBHOnbIoxnfpttsaVeqbF+M="
UID_logi = "4qcBNBAXAYVwO3H4+YV5WfrGSyc="
txt_oldChannelID = 0
lastKickedFaggot = 0
last_sended_vtext_target = 0
lastMeeting = nil
ts3_triggered_antiflood = false
clientDataREQUESTED = false
clientDataREASON = ""
clientDataID = 0
serverDataREQUESTED = false
serverDataREASON = ""
oldMSG = ""
channelKicker.info.MODULEFILE = "vars"
ts3.printMessageToCurrentTab("Loaded "..channelKicker.info.MODULE.." v"..channelKicker.info.MODULEVERSION.." by "..channelKicker.info.MODULEAUTHOR.." from "..ts3.getPluginPath().."lua_plugin/"..channelKicker.info.MODULEFOLDER.."/"..channelKicker.info.MODULEFILE.."."..channelKicker.info.MODULEEXT)