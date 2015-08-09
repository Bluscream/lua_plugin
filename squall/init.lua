require("ts3init")            -- Required for ts3RegisterModule
require("squall/events")  -- Forwarded TeamSpeak 3 callbacks

local MODULE_NAME = "squall"

local registeredEvents = {
	onClientMoveEvent = squall_events.onClientMoveEvent,
	onClientMoveMovedEvent = squall_events.onClientMoveMovedEvent,
	onClientKickFromServerEvent = squall_events.onClientKickFromServerEvent,
	onClientKickFromChannelEvent = squall_events.onClientKickFromChannelEvent,
	onClientMoveTimeoutEvent = squall_events.onClientMoveTimeoutEvent,
	onClientBanFromServerEvent = squall_events.onClientBanFromServerEvent,
}

-- Register your callback functions with a unique module name.
ts3RegisterModule(MODULE_NAME, registeredEvents)