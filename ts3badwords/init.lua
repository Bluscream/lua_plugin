print(" Loading realy required Function ")
require("ts3init")
print(" Loading : events ")
require("ts3badwords/events")
print(" Loading : Function")
require ("ts3badwords/ts3")
require("ts3badwords/func")
print(" Loading : onTextMessageEvent")
require("ts3badwords/event/onTextMessageEvent")
print(" Loading : onUpdateClientEvent ")
require("ts3badwords/event/onUpdateClientEvent")
--print(" Loading : onChannelMoveEvent")
--require("ts3badwords/event/onChannelMoveEvent")
print(" Loading : onNewChannelEvent")
require("ts3badwords/event/onNewChannelEvent")
print(" Loading : onConnectStatusChangeEvent")
require("ts3badwords/event/onConnectStatusChangeEvent")
--require("ts3badwords/dumper.lua")
	--onServerPermissionErrorEvent = badwords_events.onServerPermissionErrorEvent,

local registeredEvents = {
	onConnectStatusChangeEvent = badwords_events.onConnectStatusChangeEvent,
	onNewChannelEvent = badwords_events.onNewChannelEvent,
	onChannelMoveEvent = badwords_events.onChannelMoveEvent,
	onTextMessageEvent = badwords_events.onTextMessageEvent,
	onUpdateClientEvent = badwords_events.onUpdateClientEvent,
}
ts3RegisterModule("badwords", registeredEvents)
