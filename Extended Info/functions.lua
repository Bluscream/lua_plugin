local function ScriptLog(logMSG)
	if ExtendedInfo.const.DEBUG == true then
		local tsCol = { 'Green', 'Black', 'Red', 'Blue' }
		local RANDCOL = ( tsCol[ math.random( #tsCol ) ] )
		local scriptTimestamp = os.date("%x %X")
		ts3.printMessageToCurrentTab("[color=Black][[/color][color="..RANDCOL.."]"..scriptTimestamp.."[/color][color=Black]][/color]> "..ExtendedInfo.const.MODULESHORT..": "..logMSG)
		ts3.logMessage(logMSG, 4, 0x0002, 1)
		debugPrint(logMSG)
		print(logMSG)
	end
end
local function isempty(s)
  return s == nil or s == ''
end
function urlencode(str)
   if (str) then
      str = string.gsub (str, "\n", "\r\n")
      str = string.gsub (str, "([^%w ])",
         function (c) return string.format ("%%%02X", string.byte(c)) end)
      str = string.gsub (str, " ", "+")
   end
   return str    
end