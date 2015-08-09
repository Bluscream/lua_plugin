require("ts3init")
require("guestsound/events")
require("ts3defs")
require("ts3errors")

local registeredEvents = {
	onClientMoveEvent = guestsound_events.onClientMoveEvent
}

ts3RegisterModule("guestsound", registeredEvents)
