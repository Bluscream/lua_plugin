--
-- Testmodule initialisation, this script is called via autoload mechanism when the
-- TeamSpeak 3 client starts.
--

require("ts3init")                -- Required for ts3RegisterModule
require("z15announcegrp/events")  -- Forwarded TeamSpeak 3 callbacks
require("sgtcommon/sgt-common")   -- Common functions for my lua scripts
require("z15announcegrp/announcegrp")    -- Some demo functions callable from TS3 client chat input

local MODULE_NAME = "announcegrp"

-- Define which callbacks you want to receive in your module. Callbacks not mentioned
-- here will not be called. To avoid function name collisions, your callbacks should
-- be put into an own package.

local registeredEvents = {
	onTextMessageEvent = announcegrp_events.onTextMessageEvent,
	onClientMoveEvent = announcegrp_events.onClientMoveEvent,
	onClientMoveMovedEvent = announcegrp_events.onClientMoveMovedEvent,
}

-- Register your callback functions with a unique module name.
ts3RegisterModule(MODULE_NAME, registeredEvents)


