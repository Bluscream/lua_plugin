--
-- Virtuajdr dice roller for TS3 init file
--

require("ts3init")
require("Virtuajdr_dice/VJDR_events")

local registeredEvents = {
	onTextMessageEvent = diceroll_events.onTextMessageEvent
}

ts3RegisterModule("diceroll", registeredEvents)
