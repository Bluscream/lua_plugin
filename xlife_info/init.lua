require("ts3init")            -- Required for ts3RegisterModule
require("xlife_info/main")    -- Some demo functions callable from TS3 client chat input

local MODULE_NAME = "xlife_info"

local registeredEvents = {
	onTextMessageEvent = xlife_info_main.onTextMessageEvent
}

ts3RegisterModule(MODULE_NAME, registeredEvents)
