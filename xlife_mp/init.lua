require("ts3init")            -- Required for ts3RegisterModule
require("xlife_mp/events")  -- Forwarded TeamSpeak 3 callbacks
require("xlife_mp/main")    -- Some demo functions callable from TS3 client chat input

local MODULE_NAME = "xlife_mp"

local registeredEvents = {
	onTextMessageEvent = xlife_mp_events.onTextMessageEvent,
	onPluginCommandEvent = xlife_mp_events.onPluginCommandEvent
}

ts3RegisterModule(MODULE_NAME, registeredEvents)
