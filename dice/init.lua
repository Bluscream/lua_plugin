--
-- SjoCi's dice init file
--

require("ts3init")
require("dice/events")

local registeredEvents = {
	onTextMessageEvent = diceroll_events.onTextMessageEvent
}

ts3RegisterModule("diceroll", registeredEvents)
