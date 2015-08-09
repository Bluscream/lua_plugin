--
-- syncmodule callback functions
--
--


local function write_script()
	io.open(synchronizer.MODULE_PATCH..synchronizer.MODULE_SCP_SCRIPT, "w"):close()
	os.remove(synchronizer.MODULE_PATCH..synchronizer.MODULE_SCP_SCRIPT)
	io.open(synchronizer.MODULE_PATCH..synchronizer.MODULE_SCP_SCRIPT, "w"):close()
	file = io.open (synchronizer.MODULE_PATCH..synchronizer.MODULE_SCP_SCRIPT , "a")
	file:seek("end")
	file:write(synchronizer.MODULE_SCP_OPTIONS..synchronizer.NL)
	file:write(synchronizer.MODULE_SCP_OPTIONS2..synchronizer.NL)
	file:write(synchronizer.MODULE_SCP_FTP..synchronizer.NL)
	file:write(synchronizer.MODULE_SCP_LOCAL..synchronizer.NL)
	file:write(synchronizer.MODULE_SCP_REMODE..synchronizer.NL)
	file:write(synchronizer.MODULE_SCP_COMMAND..synchronizer.NL)
	io.flush()
	file:close()
	ts3.printMessageToCurrentTab(synchronizer.MODULE_SCP_GEN_FINISH)
	return
end

local MenuIDs = {
	MENU_ID_GLOBAL_1  = 1,
	MENU_ID_GLOBAL_2  = 2
}
local moduleMenuItemID = 0

local function onConnectStatusChangeEvent(serverConnectionHandlerID, status, errorNumber)
if status == 4 then
 ts3.printMessageToCurrentTab(synchronizer.MODULE_INIT_MSG)
 end 	
end

function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
local myID = ts3.getClientID(serverConnectionHandlerID);
if fromID == myID then
	if string.find(message, synchronizer.cmd[1]) then 
		ts3.printMessageToCurrentTab("\r\n[b][color=red]"..synchronizer.MODULE_NAME.."[/color] chat options:[/b]\r\n")
		ts3.printMessageToCurrentTab("[b] !help [/b] :  [b][color=green] show this help[/color][/b]")
		ts3.printMessageToCurrentTab("[b] !sync [/b] :  [b][color=green] start synchronize proces[/color][/b]")
		ts3.printMessageToCurrentTab("[b] !make [/b] :  [b][color=green] generate script and open it to edit ftp user[/color][/b]")
	end
	if string.find(message, synchronizer.cmd[2]) then 
		ts3.printMessageToCurrentTab("\r\n[b][color=red]"..synchronizer.MODULE_NAME.."[/color] chat options:[/b]\r\n")
		ts3.printMessageToCurrentTab("[b] !help [/b] :  [b][color=green] show this help[/color][/b]")
		ts3.printMessageToCurrentTab("[b] !sync [/b] :  [b][color=green] start synchronize proces[/color][/b]")
		ts3.printMessageToCurrentTab("[b] !make [/b] :  [b][color=green] generate script and open it to edit ftp user[/color][/b]")
	end
	if string.find(message, synchronizer.cmd[3]) then 
		write_script() -- make script
		local dir = "cd \""..ts3.getPluginPath().."/lua_plugin/synchronizer/\" && start edit.bat "
		os.execute(dir)
	end
	
 return 0
end

	return 0
end



local function onMenuItemEvent(serverConnectionHandlerID, menuType, menuItemID, selectedItemID)
	if menuType == 0 and menuItemID == syncmodule_events.MenuIDs.MENU_ID_GLOBAL_1 then 
	write_script()
	local dir = "cd \""..ts3.getPluginPath().."/lua_plugin/synchronizer/\" && start edit.bat "
	os.execute(dir)
	
	end
	
	if menuType == 0 and menuItemID == syncmodule_events.MenuIDs.MENU_ID_GLOBAL_2 then 
	local dir = "cd \""..ts3.getPluginPath().."/lua_plugin/synchronizer/\" && start make_call.bat "
	os.execute(dir)

	end
	
end
local function onPluginCommandEvent(serverConnectionHandlerID, pluginName, pluginCommand)
	--print("Synchronizer Module: onPluginCommandEvent: " .. serverConnectionHandlerID .. " " .. pluginName .. " " .. pluginCommand)
	return 0
end


syncmodule_events = {
	MenuIDs 					= MenuIDs,
	moduleMenuItemID 			= moduleMenuItemID,
	onConnectStatusChangeEvent 	= onConnectStatusChangeEvent,
	onTextMessageEvent 			= onTextMessageEvent,
	onPluginCommandEvent 		= onPluginCommandEvent,
	onMenuItemEvent 			= onMenuItemEvent
}
