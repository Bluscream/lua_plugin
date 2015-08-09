-- Izzy's Musicot Lua Script for Teamspeak 3
 
local path = "/root/Desktop/"
local myFile = "song.txt"
local file = io.open( path..myFile, "r" )
local oldFile = "stale.txt"
local stale = io.open ( path..oldFile, "w" )
 
if (file and oldFile) then
-- read all contents of file into a string
 
	contents = file:read()
	cstale = stale:read()
	file:close()
	stale:close()
 
-- io.close( file )
		 if (contents == cstale) then
		end
-- Stop the script if the name is already the same.
	elseif (contents ~= cstale) then
		local nick = ("MusicBot - "..contents)
		ts3.setClientSelfVariableAsString(schid, CLIENT_NICKNAME, nick);
		ts3.flushClientSelfUpdates(schid);
 
	else
	print("file not found")
end