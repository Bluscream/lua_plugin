--
-- Florian initialisation, this script is called via autoload mechanism when the
-- TeamSpeak 3 client starts.
--

require("ts3init")        -- Required for ts3RegisterModule
require("public/events")  -- Forwarded TeamSpeak 3 callbacks
require("public/demo")    -- Some demo functions callable from TS3 client chat input

-- Define which callbacks you want to receive in your module. Callbacks not mentioned
-- here will not be called. To avoid function name collisions, your callbacks should
-- be put into an own package.
local registeredEvents = {
	onClientMoveEvent = public_events.onClientMoveEvent
}

-- Register your callback functions with a unique module name.
ts3RegisterModule("public", registeredEvents)








