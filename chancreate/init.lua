require("ts3init")
require("chancreate/channelCreator")

local chancreate = {
	const = {
		MODULE_NAME = "ChanCreator",
		MODULE_FOLDER = "chancreate",
		DEBUG = 0,
		DEBUG_MSG_IN_CHAT = 1,
	},
	var = {},
}

local registeredEvents = {
	onConnectStatusChangeEvent = cc_events.onConnectStatusChangeEvent,
	onNewChannelCreatedEvent = cc_events.onNewChannelCreatedEvent,
	onClientKickFromChannelEvent = cc_events.onClientKickFromChannelEvent
}

ts3RegisterModule("chancreate", registeredEvents)

	-- createMenus = chancreate.onCreateMenus,
	-- onMenuItemEvent = chancreate.onMenuItemEvent