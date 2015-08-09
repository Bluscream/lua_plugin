--
-- item generation init file
--

require("ts3init")
require("items/events")
require("items/items_table")

local registeredEvents = {
	onTextMessageEvent = itemroll_events.onTextMessageEvent
}

ts3RegisterModule("itemroll", registeredEvents)
