require("ts3init")

local registeredEvents = {
	onClientPokeEvent = antipoke_events.onClientPokeEvent
}

ts3RegisterModule("antipoke", registeredEvents)
