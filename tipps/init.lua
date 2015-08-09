require("ts3init")

local registeredEvents = {
	onTextMessageEvent = tipps_events.onTextMessageEvent
	onClientMoveEvent = tipps_events.onClientMoveEvent
}

ts3RegisterModule("tipps", registeredEvents)
