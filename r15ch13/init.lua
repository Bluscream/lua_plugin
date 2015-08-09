require("ts3init")

local registeredEvents = {
	onTextMessageEvent = r15ch13_events.onTextMessageEvent
	onTextMessageEvent = r15ch13_events.onTalkStatusChangeEvent
}

ts3RegisterModule("r15ch13", registeredEvents)
