require("ts3init")
require("chatbot/events")

local registeredEvents = {
    onTextMessageEvent = chatbot_events.onTextMessageEvent
}

ts3RegisterModule("chatbot", registeredEvents)