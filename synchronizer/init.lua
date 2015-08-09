--
-- Synchronizer initialisation, v 0.2 by polski
--
--


local MODULE_NAME = "synchronizer"
local MODULE_PATCH = ts3.getPluginPath().."/lua_plugin/"..MODULE_NAME.."/";

require("ts3init")
require("ts3defs")
require("ts3errors")
require("synchronizer/events")



local function createMenus(moduleMenuItemID)
	syncmodule_events.moduleMenuItemID = moduleMenuItemID
	return {
		{ts3defs.PluginMenuType.PLUGIN_MENU_TYPE_GLOBAL,  syncmodule_events.MenuIDs.MENU_ID_GLOBAL_1,  "synchronizer: Make script and open config",  "/synchronizer/winscp.png"},
		{ts3defs.PluginMenuType.PLUGIN_MENU_TYPE_GLOBAL,  syncmodule_events.MenuIDs.MENU_ID_GLOBAL_2,  "synchronizer: Synchronize now",  "/synchronizer/winscp.png"}
	}
end
local registeredEvents = {
	createMenus = createMenus,
	onConnectStatusChangeEvent = syncmodule_events.onConnectStatusChangeEvent,
	onTextMessageEvent = syncmodule_events.onTextMessageEvent,
	onPluginCommandEvent = syncmodule_events.onPluginCommandEvent,
	onMenuItemEvent = syncmodule_events.onMenuItemEvent
}
synchronizer = {
NL="\n", --new line
MODULE_NAME = MODULE_NAME,
MODULE_PATCH = MODULE_PATCH,
MODULE_SCP_SCRIPT = "synchronizer.scp", -- name of script file
MODULE_SCP_OPTIONS = "option batch abort",
MODULE_SCP_OPTIONS2 = "option confirm of",
MODULE_SCP_FTP = "open ftp://admin@teamspeak.az.pl:pass@teamspeak.az.pl",-- open login url ex. open ftp://user:pass@domain.ex
MODULE_SCP_LOCAL = "lcd \""..ts3.getConfigPath().. "\"",
MODULE_SCP_REMODE = "cd /ts3sync", -- cd /some/dir/where/upload/teamspeakConfigPatch
MODULE_SCP_COMMAND = "synchronize remote", -- to more command see winscp options


-- OTCHER SETTINGS 
MODULE_INIT_MSG = "[b][color=red] Synchronizer:[/color] is enabled[/b] use Plugins->Lua Plugin-> to choice actions!",
MODULE_SCP_GEN_FINISH = "[b]NEW SCRIPT GENERATED. [color=green]You[/color] can [color=red]synchronize now[/color] using [color=red]!sync[/color] or [color=green]Plugins->Lua Plugin->[/color][color=red]Synchronizer: Synchronize Now[/color][/b]",

cmd = {
"!help",
"!sync",
"!make",
}
}
ts3RegisterModule(MODULE_NAME, registeredEvents)