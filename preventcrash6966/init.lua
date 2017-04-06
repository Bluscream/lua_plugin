require("ts3init")
require("preventcrash6966/events")

local MODULE_NAME = "preventcrash6966"

local registeredEvents = {
	onTextMessageEvent = preventcrash6966_events.onTextMessageEvent,
	onClientPokeEvent = preventcrash6966_events.onClientPokeEvent,
}

-- Register your callback functions with a unique module name.
ts3RegisterModule(MODULE_NAME, registeredEvents)
