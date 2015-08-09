--
-- libNotify - Init, this script is called via autoload mechanism when the
-- TeamSpeak 3 client starts.
--

require("ts3init")            -- Required for ts3RegisterModule
require("ts3errors")
require("functions")
require("libnotify/def")
require("libnotify/notify")
require("libnotify/commands")

-- Festlegen der behandelten Events
local registeredEvents = {
	onClientPokeEvent = libnotify_events.onClientPokeEvent,
	onClientMoveEvent = libnotify_events.onClientMoveEvent,
	onClientMoveMovedEvent = libnotify_events.onClientMoveMovedEvent,
	onTalkStatusChangeEvent = libnotify_events.onTalkStatusChangeEvent,
	onTextMessageEvent = libnotify_events.onTextMessageEvent,
	onConnectStatusChangeEvent = libnotify_events.onConnectStatusChangeEvent
}


-- Register your callback functions with a unique module name.
ts3RegisterModule("libNotify", registeredEvents)

print("libNotify: AppPath: " .. ts3.getAppPath())
print("libNotify: ResourcesPath: " .. ts3.getResourcesPath())
print("libNotify: ConfigPath: " .. ts3.getConfigPath())
print("libNotify: PluginPath: " .. ts3.getPluginPath())
