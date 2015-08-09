require("ts3init")            -- Required for ts3RegisterModule
require("ts3defs") 
require("ts3errors") 
require("startaway/events")

local MODULE_NAME = "Start Away"

local registeredEvents = {
	onConnectStatusChangeEvent = startaway_events.onConnectStatusChangeEvent
}

ts3RegisterModule(MODULE_NAME, registeredEvents)