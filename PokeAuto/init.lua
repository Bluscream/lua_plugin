require("ts3init")          
require("PokeAuto/events") 

local MODULE_NAME = "PokeAuto"

local registeredEvents = {
	onClientPokeEvent = PokeAuto_events.onClientPokeEvent
}

ts3RegisterModule(MODULE_NAME, registeredEvents)