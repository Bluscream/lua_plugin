require("ts3init")
require("LinksPlus/msglink")
require("LinksPlus/links_events")

local MODULE_NAME = "LinksPlus"

local registeredEvents = {
	onTextMessageEvent = links_events.onTextMessageEvent
}

ts3RegisterModule(MODULE_NAME, registeredEvents)
