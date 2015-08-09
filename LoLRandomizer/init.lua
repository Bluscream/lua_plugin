--
-- League of Legends Randomizer
-- 		  by mJrA & xQyz
--


require("ts3init")
require("ts3errors")
require("LoLRandomizer/events")

local registeredEvents = {
	onTextMessageEvent = diceroll_events.onTextMessageEvent
}

ts3RegisterModule("diceroll", registeredEvents)
