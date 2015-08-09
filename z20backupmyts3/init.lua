--
-- Testmodule initialisation, this script is called via autoload mechanism when the
-- TeamSpeak 3 client starts.
--

require("ts3init")                -- Required for ts3RegisterModule
require("z20backupmyts3/events")  -- Forwarded TeamSpeak 3 callbacks
require("sgtcommon/sgt-common")   -- Common functions for my lua scripts
require("z20backupmyts3/backupmyts3")    -- Some demo functions callable from TS3 client chat input

local MODULE_NAME = "backupmyts3"

-- Define which callbacks you want to receive in your module. Callbacks not mentioned
-- here will not be called. To avoid function name collisions, your callbacks should
-- be put into an own package.

local registeredEvents = {
	onUpdateClientEvent = backupmyts3_events.onUpdateClientEvent,
	onTextMessageEvent = backupmyts3_events.onTextMessageEvent,
	onClientMoveEvent = backupmyts3_events.onClientMoveEvent,
}

-- Register your callback functions with a unique module name.
ts3RegisterModule(MODULE_NAME, registeredEvents)


