--
-- TeamSpeak 3 events
--
-- This file is automatically loaded by the Lua plugin. All files loaded from this script via 'require' will
-- be automatically loaded as well. 
--
-- You should not modify this file to hook into the callback functions and load your script via require, as
-- this file will be overwritten and restored to the original state by the updater. Instead you should create
-- a new directory inside the lua_plugin folder and put your Lua code there. A file init.lua must exist for
-- the autoload mechanism to load your scripts. See the testmodule code as an example.
--
-- Scripts not load via the autoload mechanism can be loaded at runtime from the TeamSpeak 3 client by typing
-- "/lua load <filename>" from in the chat input.
--

require("ts3defs")      -- Required
require("ts3errors")    -- Required
require("ts3init")      -- Required
require("ts3autoload")  -- Required

-- Common print function to be able to disable print output by commenting out just one line
-- Enable to read debug output for each callback in the console (Pass "-console" commandline parameter to TS3 client)
local function debugPrint(msg)
	--print(msg)
end

function currentServerConnectionChanged(serverConnectionHandlerID)
	debugPrint("Lua: currentServerConnectionChanged: " .. serverConnectionHandlerID)
end

-- Clientlib

function onConnectStatusChangeEvent(serverConnectionHandlerID, status, errorNumber)
    debugPrint("Lua: onConnectStatusChangeEvent: " .. serverConnectionHandlerID .. " " .. status .. " " .. errorNumber)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onConnectStatusChangeEvent ~= nil then
			events.onConnectStatusChangeEvent(serverConnectionHandlerID, status, errorNumber)
		end
	end
end

function onNewChannelEvent(serverConnectionHandlerID, channelID, channelParentID)
    debugPrint("Lua: onNewChannelEvent: " .. serverConnectionHandlerID .. " " .. channelID .. " " .. channelParentID)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onNewChannelEvent ~= nil then
			events.onNewChannelEvent(serverConnectionHandlerID, channelID, channelParentID)
		end
	end
end

function onNewChannelCreatedEvent(serverConnectionHandlerID, channelID, channelParentID, invokerID, invokerName, invokerUniqueIdentifier)
    debugPrint("Lua: onNewChannelCreatedEvent: " .. serverConnectionHandlerID .. " " .. channelID .. " " .. channelParentID .. " " .. invokerID .. " " .. invokerName .. " " .. invokerUniqueIdentifier)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onNewChannelCreatedEvent ~= nil then
			events.onNewChannelCreatedEvent(serverConnectionHandlerID, channelID, channelParentID, invokerID, invokerName, invokerUniqueIdentifier)
		end
	end
end

function onDelChannelEvent(serverConnectionHandlerID, channelID, invokerID, invokerName, invokerUniqueIdentifier)
    debugPrint("Lua: onDelChannelEvent: " .. serverConnectionHandlerID .. " " .. channelID .. " " .. invokerID .. " " .. invokerName .. " " .. invokerUniqueIdentifier)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onDelChannelEvent ~= nil then
			events.onDelChannelEvent(serverConnectionHandlerID, channelID, invokerID, invokerName, invokerUniqueIdentifier)
		end
	end
end

function onChannelMoveEvent(serverConnectionHandlerID, channelID, newParentChannelID, invokerID, invokerName, invokerUniqueIdentifier)
    debugPrint("Lua: onChannelMoveEvent: " .. serverConnectionHandlerID .. " " .. channelID .. " " .. newParentChannelID .. " " .. invokerID .. " " .. invokerName .. " " .. invokerUniqueIdentifier)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onChannelMoveEvent ~= nil then
			events.onChannelMoveEvent(serverConnectionHandlerID, channelID, newParentChannelID, invokerID, invokerName, invokerUniqueIdentifier)
		end
	end
end

function onUpdateChannelEvent(serverConnectionHandlerID, channelID)
	debugPrint("Lua: onUpdateChannelEvent: " .. serverConnectionHandlerID .. " " .. channelID)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onUpdateChannelEvent ~= nil then
			events.onUpdateChannelEvent(serverConnectionHandlerID, channelID)
		end
	end
end

function onUpdateChannelEditedEvent(serverConnectionHandlerID, channelID, invokerID, invokerName, invokerUniqueIdentifier)
	debugPrint("Lua: onUpdateChannelEditedEvent: " .. serverConnectionHandlerID .. " " ..  channelID .. " " .. invokerID .. " " .. invokerName .. " " .. invokerUniqueIdentifier)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onUpdateChannelEditedEvent ~= nil then
			events.onUpdateChannelEditedEvent(serverConnectionHandlerID, channelID, invokerID, invokerName, invokerUniqueIdentifier)
		end
	end
end

function onUpdateClientEvent(serverConnectionHandlerID, clientID)
	debugPrint("Lua: onUpdateClientEvent: " .. serverConnectionHandlerID .. " " .. clientID)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onUpdateClientEvent ~= nil then
			events.onUpdateClientEvent(serverConnectionHandlerID, clientID)
		end
	end
end

function onClientMoveEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, moveMessage)
    debugPrint("Lua: onClientMoveEvent: " .. serverConnectionHandlerID .. " " .. clientID .. " " .. oldChannelID .. " " .. newChannelID .. " " .. visibility .. " " .. moveMessage)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onClientMoveEvent ~= nil then
			events.onClientMoveEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, moveMessage)
		end
	end
end

function onClientMoveSubscriptionEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility)
    debugPrint("Lua: onClientMoveSubscriptionEvent: " .. serverConnectionHandlerID .. " " .. clientID .. " " .. oldChannelID .. " " .. newChannelID .. " " .. visibility)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onClientMoveSubscriptionEvent ~= nil then
			events.onClientMoveSubscriptionEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility)
		end
	end
end

function onClientMoveTimeoutEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, timeoutMessage)
    debugPrint("Lua: onClientMoveTimeoutEvent: " .. serverConnectionHandlerID .. " " .. clientID .. " " .. oldChannelID .. " " .. newChannelID .. " " .. visibility .. " " .. timeoutMessage)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onClientMoveTimeoutEvent ~= nil then
			events.onClientMoveTimeoutEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, timeoutMessage)
		end
	end
end

function onClientMoveMovedEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, moverID, moverName, moverUniqueIdentifier, moveMessage)
    debugPrint("Lua: onClientMoveMovedEvent: " .. serverConnectionHandlerID .. " " .. clientID .. " " .. oldChannelID .. " " .. newChannelID .. " " .. visibility .. " " .. moverID .. " " .. moverName .. " " .. moverUniqueIdentifier .. " " .. moveMessage)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onClientMoveMovedEvent ~= nil then
			events.onClientMoveMovedEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, moverID, moverName, moverUniqueIdentifier, moveMessage)
		end
	end
end

function onClientKickFromChannelEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, kickerID, kickerName, kickerUniqueIdentifier, kickMessage)
    debugPrint("Lua: onClientKickFromChannelEvent: " .. serverConnectionHandlerID .. " " .. clientID .. " " .. oldChannelID .. " " .. newChannelID .. " " .. visibility .. " " .. kickerID .. " " .. kickerName .. " " .. kickerUniqueIdentifier .. " " .. kickMessage)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onClientKickFromChannelEvent ~= nil then
			events.onClientKickFromChannelEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, kickerID, kickerName, kickerUniqueIdentifier, kickMessage)
		end
	end
end

function onClientKickFromServerEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, kickerID, kickerName, kickerUniqueIdentifier, kickMessage)
    debugPrint("Lua: onClientKickFromServerEvent: " .. serverConnectionHandlerID .. " " .. clientID .. " " .. oldChannelID .. " " .. newChannelID .. " " .. visibility .. " " .. kickerID .. " " .. kickerName .. " " .. kickerUniqueIdentifier .. " " .. kickMessage)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onClientKickFromServerEvent ~= nil then
			events.onClientKickFromServerEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, kickerID, kickerName, kickerUniqueIdentifier, kickMessage)
		end
	end
end

function onServerEditedEvent(serverConnectionHandlerID, editerID, editerName, editerUniqueIdentifier)
    debugPrint("Lua: onServerEditedEvent: " .. serverConnectionHandlerID .. " " .. editerID .. " " .. editerName .. " " .. editerUniqueIdentifier)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onServerEditedEvent ~= nil then
			events.onServerEditedEvent(serverConnectionHandlerID, editerID, editerName, editerUniqueIdentifier)
		end
	end
end

function onServerUpdatedEvent(serverConnectionHandlerID)
	debugPrint("Lua: onServerUpdatedEvent: " .. serverConnectionHandlerID)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onServerUpdatedEvent ~= nil then
			events.onServerUpdatedEvent(serverConnectionHandlerID)
		end
	end
end

function onServerErrorEvent(serverConnectionHandlerID, errorMessage, errorCode, extraMessage)
    debugPrint("Lua: onServerErrorEvent: " .. serverConnectionHandlerID .. " " .. errorMessage .. " " .. errorCode)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onServerErrorEvent ~= nil then
			events.onServerErrorEvent(serverConnectionHandlerID, errorMessage, errorCode, extraMessage)
		end
	end
end

function onServerStopEvent(serverConnectionHandlerID, shutdownMessage)
    debugPrint("Lua: onServerStopEvent: serverConnectionHandlerID = " .. serverConnectionHandlerID .. ", shutdownMessage = " .. shutdownMessage)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onServerStopEvent ~= nil then
			events.onServerStopEvent(serverConnectionHandlerID, shutdownMessage)
		end
	end
end

function onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
    debugPrint("Lua: onTextMessageEvent: " .. serverConnectionHandlerID .. " " .. targetMode .. " " .. toID .. " " .. fromID .. " " .. fromName .. " " .. fromUniqueIdentifier .. " " .. message .. " " .. ffIgnored)
	local retVal = 0
    for script,events in pairs(ts3RegisteredModules) do
        if events.onTextMessageEvent ~= nil then
            local result = events.onTextMessageEvent(serverConnectionHandlerID, targetMode, toID, fromID, fromName, fromUniqueIdentifier, message, ffIgnored)
            if result > 0 then
                retVal = 1  -- If at least one Lua module returns 1, this function will also return 1 and let the client ignore the text message
            end
        end
    end
	return retVal  -- Return 0: Client will handle the text message as usual. Return 1: Client will ignore the test message.
end

function onTalkStatusChangeEvent(serverConnectionHandlerID, status, isReceivedWhisper, clientID)
    debugPrint("Lua: onTalkStatusChangeEvent: " .. serverConnectionHandlerID .. " " .. status .. " " .. isReceivedWhisper .. " " .. clientID)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onTalkStatusChangeEvent ~= nil then
			events.onTalkStatusChangeEvent(serverConnectionHandlerID, status, isReceivedWhisper, clientID)
		end
	end
end

function onConnectionInfoEvent(serverConnectionHandlerID, clientID)
	debugPrint("Lua: onConnectionInfoEvent: " .. serverConnectionHandlerID .. " " .. clientID)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onConnectionInfoEvent ~= nil then
			events.onConnectionInfoEvent(serverConnectionHandlerID, clientID)
		end
	end
end

function onServerConnectionInfoEvent(serverConnectionHandlerID)
	debugPrint("Lua: onServerConnectionInfoEvent: " .. serverConnectionHandlerID)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onServerConnectionInfoEvent ~= nil then
			events.onServerConnectionInfoEvent(serverConnectionHandlerID)
		end
	end
end

function onChannelSubscribeEvent(serverConnectionHandlerID, channelID)
    debugPrint("Lua: onChannelSubscribeEvent: " .. serverConnectionHandlerID .. " " .. channelID)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onChannelSubscribeEvent ~= nil then
			events.onChannelSubscribeEvent(serverConnectionHandlerID, channelID)
		end
	end
end

function onChannelSubscribeFinishedEvent(serverConnectionHandlerID)
	debugPrint("Lua: onChannelSubscribeFinishedEvent: " .. serverConnectionHandlerID)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onChannelSubscribeFinishedEvent ~= nil then
			events.onChannelSubscribeFinishedEvent(serverConnectionHandlerID)
		end
	end
end

function onChannelUnsubscribeEvent(serverConnectionHandlerID, channelID)
    debugPrint("Lua: onChannelUnsubscribeEvent: " .. serverConnectionHandlerID .. " " .. channelID)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onChannelUnsubscribeEvent ~= nil then
			events.onChannelUnsubscribeEvent(serverConnectionHandlerID, channelID)
		end
	end
end

function onChannelUnsubscribeFinishedEvent(serverConnectionHandlerID)
	debugPrint("Lua: onChannelUnsubscribeFinishedEvent: " .. serverConnectionHandlerID)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onChannelUnsubscribeFinishedEvent ~= nil then
			events.onChannelUnsubscribeFinishedEvent(serverConnectionHandlerID)
		end
	end
end

function onChannelDescriptionUpdateEvent(serverConnectionHandlerID, channelID)
	debugPrint("Lua: onChannelDescriptionUpdateEvent: " .. serverConnectionHandlerID .. " " .. channelID)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onChannelDescriptionUpdateEvent ~= nil then
			events.onChannelDescriptionUpdateEvent(serverConnectionHandlerID, channelID)
		end
	end
end

function onChannelPasswordChangedEvent(serverConnectionHandlerID, channelID)
	debugPrint("Lua: onChannelPasswordChangedEvent: " .. serverConnectionHandlerID .. " " .. channelID)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onChannelPasswordChangedEvent ~= nil then
			events.onChannelPasswordChangedEvent(serverConnectionHandlerID, channelID)
		end
	end
end

function onPlaybackShutdownCompleteEvent(serverConnectionHandlerID)
	debugPrint("Lua: onPlaybackShutdownCompleteEvent: " .. serverConnectionHandlerID)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onPlaybackShutdownCompleteEvent ~= nil then
			events.onPlaybackShutdownCompleteEvent(serverConnectionHandlerID)
		end
	end
end

-- Clientlib rare

function onClientBanFromServerEvent(serverConnectionHandlerID, clientID, oldChannelID, newChannelID, visibility, kickerID, kickerName, kickerUniqueIdentifier, kickTime, kickMessage)
	debugPrint("Lua: onClientBanFromServerEvent: " .. serverConnectionHandlerID .. " " .. clientID .. " " .. oldChannelID .. " " .. newChannelID .. " " .. visibility .. " " .. kickerID .. " " .. kickerName .. " " .. kickerUniqueIdentifier .. " " .. kickTime .. " " .. kickMessage)
	for script,events in pairs(ts3RegisteredModules) do
		if events.XXX ~= nil then
			events.XXX()
		end
	end
end

function onClientPokeEvent(serverConnectionHandlerID, pokerID, pokerName, message, ffIgnored)
    debugPrint("Lua: onClientPokeEvent: " .. serverConnectionHandlerID .. " " .. pokerID .. " " .. pokerName .. " " .. message .. " " .. ffIgnored)
	local retVal = 0
    for script,events in pairs(ts3RegisteredModules) do
        if events.onClientPokeEvent ~= nil then
            local result = events.onClientPokeEvent(serverConnectionHandlerID, pokerID, pokerName, message, ffIgnored)
            if result > 0 then
                retVal = 1  -- If at least one Lua module returns 1, this function will also return 1 and let the client ignore the poke
            end
        end
    end
	return retVal  -- Return 0: Client will handle the poke as usual. Return 1: Client will ignore the poke.
end

function onClientSelfVariableUpdateEvent(serverConnectionHandlerID, flag, oldValue, newValue)
	debugPrint("Lua: onClientSelfVariableUpdateEvent: " .. serverConnectionHandlerID .. " " .. flag .. " " .. oldValue .. " " .. newValue)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onClientSelfVariableUpdateEvent ~= nil then
			events.onClientSelfVariableUpdateEvent(serverConnectionHandlerID, flag, oldValue, newValue)
		end
	end
end

function onServerGroupListEvent(serverConnectionHandlerID, serverGroupID, name, groupType, iconID, saveDB)
	debugPrint("Lua: onServerGroupListEvent: " .. serverConnectionHandlerID .. " " .. serverGroupID .. " " .. name .. " " .. groupType .. " " .. iconID .. " " .. saveDB)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onServerGroupListEvent ~= nil then
			events.onServerGroupListEvent(serverConnectionHandlerID, serverGroupID, name, groupType, iconID, saveDB)
		end
	end
end

function onServerGroupListFinishedEvent(serverConnectionHandlerID)
	debugPrint("Lua: onServerGroupListFinishedEvent: " .. serverConnectionHandlerID)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onServerGroupListFinishedEvent ~= nil then
			events.onServerGroupListFinishedEvent(serverConnectionHandlerID)
		end
	end
end

function onServerGroupByClientIDEvent(serverConnectionHandlerID, name, serverGroupList, clientDatabaseID)
	debugPrint("Lua: onServerGroupByClientIDEvent: " .. serverConnectionHandlerID .. " " .. name .. " " .. serverGroupList .. " " .. clientDatabaseID)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onServerGroupByClientIDEvent ~= nil then
			events.onServerGroupByClientIDEvent(serverConnectionHandlerID, name, serverGroupList, clientDatabaseID)
		end
	end
end

function onServerGroupPermListEvent(serverConnectionHandlerID, serverGroupID, permissionID, permissionValue, permissionNegated, permissionSkip)
	debugPrint("Lua: onServerGroupPermListEvent: " .. serverConnectionHandlerID .. " " .. serverGroupID .. " " .. permissionID .. " " .. permissionValue .. " " .. permissionNegated .. " " .. permissionSkip)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onServerGroupPermListEvent ~= nil then
			events.onServerGroupPermListEvent(serverConnectionHandlerID, serverGroupID, permissionID, permissionValue, permissionNegated, permissionSkip)
		end
	end
end

function onServerGroupClientListEvent(serverConnectionHandlerID, serverGroupID, clientDatabaseID, clientNameIdentifier, clientUniqueID)
	debugPrint("Lua: onServerGroupClientListEvent: " .. serverConnectionHandlerID .. " " .. serverGroupID .. " " .. clientDatabaseID .. " " .. clientNameIdentifier .. " " .. clientUniqueID)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onServerGroupClientListEvent ~= nil then
			events.onServerGroupClientListEvent(serverConnectionHandlerID, serverGroupID, clientDatabaseID, clientNameIdentifier, clientUniqueID)
		end
	end
end

function onChannelGroupListEvent(serverConnectionHandlerID, channelGroupID, name, groupType, iconID, saveDB)
	debugPrint("Lua: onChannelGroupListEvent: " .. serverConnectionHandlerID .. " " .. channelGroupID .. " " .. name .. " " .. groupType .. " " .. iconID .. " " .. saveDB)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onChannelGroupListEvent ~= nil then
			events.onChannelGroupListEvent(serverConnectionHandlerID, channelGroupID, name, groupType, iconID, saveDB)
		end
	end
end

function onChannelGroupListFinishedEvent(serverConnectionHandlerID)
	debugPrint("Lua: onChannelGroupListFinishedEvent: " .. serverConnectionHandlerID)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onChannelGroupListFinishedEvent ~= nil then
			events.onChannelGroupListFinishedEvent(serverConnectionHandlerID)
		end
	end
end

function onChannelGroupPermListEvent(serverConnectionHandlerID, channelGroupID, permissionID, permissionValue, permissionNegated, permissionSkip)
	debugPrint("Lua: onChannelGroupPermListEvent: " .. serverConnectionHandlerID .. " " .. channelGroupID .. " " .. permissionID .. " " .. permissionValue .. " " .. permissionNegated .. " " .. permissionSkip)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onChannelGroupPermListEvent ~= nil then
			events.onChannelGroupPermListEvent(serverConnectionHandlerID, channelGroupID, permissionID, permissionValue, permissionNegated, permissionSkip)
		end
	end
end

function onChannelPermListEvent(serverConnectionHandlerID, channelID, permissionID, permissionValue, permissionNegated, permissionSkip)
	debugPrint("Lua: onChannelPermListEvent: " .. serverConnectionHandlerID .. " " .. channelID .. " " .. permissionID .. " " .. permissionValue .. " " .. permissionNegated .. " " .. permissionSkip)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onChannelPermListEvent ~= nil then
			events.onChannelPermListEvent(serverConnectionHandlerID, channelID, permissionID, permissionValue, permissionNegated, permissionSkip)
		end
	end
end

function onClientChannelGroupChangedEvent(serverConnectionHandlerID, channelGroupID, channelID, clientID, invokerClientID, invokerName, invokerUniqueIdentity)
	debugPrint("Lua: onClientChannelGroupChangedEvent: " .. serverConnectionHandlerID .. " " .. channelGroupID .. " " .. channelID .. " " .. clientID .. " " .. invokerClientID .. " " .. invokerName .. " " .. invokerUniqueIdentity)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onClientChannelGroupChangedEvent ~= nil then
			events.onClientChannelGroupChangedEvent(serverConnectionHandlerID, channelGroupID, channelID, clientID, invokerClientID, invokerName, invokerUniqueIdentity)
		end
	end
end

function onServerPermissionErrorEvent(serverConnectionHandlerID, errorMessage, errorCode, failedPermissionID)
	debugPrint("Lua: onServerPermissionErrorEvent: " .. serverConnectionHandlerID .. " " .. errorMessage .. " " .. errorCode .. " " .. failedPermissionID)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onServerPermissionErrorEvent ~= nil then
			events.onServerPermissionErrorEvent(serverConnectionHandlerID, errorMessage, errorCode, failedPermissionID)
		end
	end
end

function onPermissionListEvent(serverConnectionHandlerID, permissionID, permissionName, permissionDescription)
	debugPrint("Lua: onPermissionListEvent: " .. serverConnectionHandlerID .. " " .. permissionID .. " " .. permissionName .. " " .. permissionDescription)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onPermissionListEvent ~= nil then
			events.onPermissionListEvent(serverConnectionHandlerID, permissionID, permissionName, permissionDescription)
		end
	end
end

function onPermissionListFinishedEvent(serverConnectionHandlerID)
	debugPrint("Lua: onPermissionListFinishedEvent: " .. serverConnectionHandlerID)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onPermissionListFinishedEvent ~= nil then
			events.onPermissionListFinishedEvent(serverConnectionHandlerID)
		end
	end
end

function onPermissionOverviewEvent(serverConnectionHandlerID, clientDatabaseID, channelID, overviewType, overviewID1, overviewID2, permissionID, permissionValue, permissionNegated, permissionSkip)
	debugPrint("Lua: onPermissionOverviewEvent: " .. serverConnectionHandlerID .. " " .. clientDatabaseID .. " " .. channelID .. " " .. overviewType .. " " .. overviewID1 .. " " .. overviewID2 .. " " .. permissionID .. " " .. permissionValue .. " " .. permissionNegated .. " " .. permissionSkip)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onPermissionOverviewEvent ~= nil then
			events.onPermissionOverviewEvent(serverConnectionHandlerID, clientDatabaseID, channelID, overviewType, overviewID1, overviewID2, permissionID, permissionValue, permissionNegated, permissionSkip)
		end
	end
end

function onPermissionOverviewFinishedEvent(serverConnectionHandlerID)
	debugPrint("Lua: onPermissionOverviewFinishedEvent: " .. serverConnectionHandlerID)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onPermissionOverviewFinishedEvent ~= nil then
			events.onPermissionOverviewFinishedEvent(serverConnectionHandlerID)
		end
	end
end

function onServerGroupClientAddedEvent(serverConnectionHandlerID, clientID, clientName, clientUniqueIdentity, serverGroupID, invokerClientID, invokerName, invokerUniqueIdentity)
	debugPrint("Lua: onServerGroupClientAddedEvent: " .. serverConnectionHandlerID .. " " .. clientID .. " " .. clientName .. " " .. clientUniqueIdentity .. " " .. serverGroupID .. " " .. invokerClientID .. " " .. invokerName .. " " .. invokerUniqueIdentity)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onServerGroupClientAddedEvent ~= nil then
			events.onServerGroupClientAddedEvent(serverConnectionHandlerID, clientID, clientName, clientUniqueIdentity, serverGroupID, invokerClientID, invokerName, invokerUniqueIdentity)
		end
	end
end

function onServerGroupClientDeletedEvent(serverConnectionHandlerID, clientID, clientName, clientUniqueIdentity, serverGroupID, invokerClientID, invokerName, invokerUniqueIdentity)
	debugPrint("Lua: onServerGroupClientDeletedEvent: " .. serverConnectionHandlerID .. " " .. clientID .. " " .. clientName .. " " .. clientUniqueIdentity .. " " .. serverGroupID .. " " .. invokerClientID .. " " .. invokerName .. " " .. invokerUniqueIdentity)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onServerGroupClientDeletedEvent ~= nil then
			events.onServerGroupClientDeletedEvent(serverConnectionHandlerID, clientID, clientName, clientUniqueIdentity, serverGroupID, invokerClientID, invokerName, invokerUniqueIdentity)
		end
	end
end

function onClientNeededPermissionsEvent(serverConnectionHandlerID, permissionID, permissionValue)
	debugPrint("Lua: onClientNeededPermissionsEvent: " .. serverConnectionHandlerID .. " " .. permissionID .. " " .. permissionValue)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onClientNeededPermissionsEvent ~= nil then
			events.onClientNeededPermissionsEvent(serverConnectionHandlerID, permissionID, permissionValue)
		end
	end
end

function onClientNeededPermissionsFinishedEvent(serverConnectionHandlerID)
	debugPrint("Lua: onClientNeededPermissionsFinishedEvent: " .. serverConnectionHandlerID)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onClientNeededPermissionsFinishedEvent ~= nil then
			events.onClientNeededPermissionsFinishedEvent(serverConnectionHandlerID)
		end
	end
end

function onClientChatClosedEvent(serverConnectionHandlerID, clientID, clientUniqueIdentity)
	debugPrint("Lua: onClientChatClosedEvent: " .. serverConnectionHandlerID .. " " .. clientID .. " " .. clientUniqueIdentity)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onClientChatClosedEvent ~= nil then
			events.onClientChatClosedEvent(serverConnectionHandlerID, clientID, clientUniqueIdentity)
		end
	end
end

function onClientChatComposingEvent(serverConnectionHandlerID, clientID, clientUniqueIdentity)
	debugPrint("Lua: onClientChatComposingEvent: " .. serverConnectionHandlerID .. " " .. clientID .. " " .. clientUniqueIdentity)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onClientChatComposingEvent ~= nil then
			events.onClientChatComposingEvent(serverConnectionHandlerID, clientID, clientUniqueIdentity)
		end
	end
end

function onServerLogEvent(serverConnectionHandlerID, logMsg)
	debugPrint("Lua: onServerLogEvent: " .. serverConnectionHandlerID .. " " .. logMsg)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onServerLogEvent ~= nil then
			events.onServerLogEvent(serverConnectionHandlerID, logMsg)
		end
	end
end

function onServerLogFinishedEvent(serverConnectionHandlerID, lastPos, fileSize)
	debugPrint("Lua: onServerLogFinishedEvent: " .. serverConnectionHandlerID .. " " .. lastPos .. " " .. fileSize)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onServerLogFinishedEvent ~= nil then
			events.onServerLogFinishedEvent(serverConnectionHandlerID, lastPos, fileSize)
		end
	end
end

function onServerQueryEvent(serverConnectionHandlerID, result)
	debugPrint("Lua: onServerQueryEvent: " .. serverConnectionHandlerID .. " " .. result)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onServerQueryEvent ~= nil then
			events.onServerQueryEvent(serverConnectionHandlerID, result)()
		end
	end
end

function onMessageListEvent(serverConnectionHandlerID, messageID, fromClientUniqueIdentity, subject, timestamp, flagRead)
	debugPrint("Lua: onMessageListEvent: " .. serverConnectionHandlerID .. " " .. messageID .. " " .. fromClientUniqueIdentity .. " " .. subject .. " " .. timestamp .. " " .. flagRead)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onMessageListEvent ~= nil then
			events.onMessageListEvent(serverConnectionHandlerID, messageID, fromClientUniqueIdentity, subject, timestamp, flagRead)()
		end
	end
end

function onMessageGetEvent(serverConnectionHandlerID, messageID, fromClientUniqueIdentity, subject, message, timestamp)
	debugPrint("Lua: onMessageGetEvent: " .. serverConnectionHandlerID .. " " .. messageID .. " " .. fromClientUniqueIdentity .. " " .. subject .. " " .. message .. " " .. timestamp)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onMessageGetEvent ~= nil then
			events.onMessageGetEvent(serverConnectionHandlerID, messageID, fromClientUniqueIdentity, subject, message, timestamp)
		end
	end
end

function onClientDBIDfromUIDEvent(serverConnectionHandlerID, uniqueClientIdentifier, clientDatabaseID)
	debugPrint("Lua: onClientDBIDfromUIDEvent: " .. serverConnectionHandlerID .. " " .. uniqueClientIdentifier .. " " .. clientDatabaseID)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onClientDBIDfromUIDEvent ~= nil then
			events.onClientDBIDfromUIDEvent(serverConnectionHandlerID, uniqueClientIdentifier, clientDatabaseID)
		end
	end
end

function onClientNamefromUIDEvent(serverConnectionHandlerID, uniqueClientIdentifier, clientDatabaseID, clientNickName)
	debugPrint("Lua: onClientNamefromUIDEvent: " .. serverConnectionHandlerID .. " " .. uniqueClientIdentifier .. " " .. clientDatabaseID .. " " .. clientNickName)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onClientNamefromUIDEvent ~= nil then
			events.onClientNamefromUIDEvent(serverConnectionHandlerID, uniqueClientIdentifier, clientDatabaseID, clientNickName)
		end
	end
end

function onClientNamefromDBIDEvent(serverConnectionHandlerID, uniqueClientIdentifier, clientDatabaseID, clientNickName)
	debugPrint("Lua: onClientNamefromDBIDEvent: " .. serverConnectionHandlerID .. " " .. uniqueClientIdentifier .. " " .. clientDatabaseID .. " " .. clientNickName)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onClientNamefromDBIDEvent ~= nil then
			events.onClientNamefromDBIDEvent(serverConnectionHandlerID, uniqueClientIdentifier, clientDatabaseID, clientNickName)
		end
	end
end

function onComplainListEvent(serverConnectionHandlerID, targetClientDatabaseID, targetClientNickName, fromClientDatabaseID, fromClientNickName, complainReason, timestamp)
	debugPrint("Lua: onComplainListEvent: " .. serverConnectionHandlerID .. " " .. targetClientDatabaseID .. " " .. targetClientNickName .. " " .. fromClientDatabaseID .. " " .. fromClientNickName .. " " .. complainReason .. " " .. timestamp)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onComplainListEvent ~= nil then
			events.onComplainListEvent(serverConnectionHandlerID, targetClientDatabaseID, targetClientNickName, fromClientDatabaseID, fromClientNickName, complainReason, timestamp)
		end
	end
end

function onBanListEvent(serverConnectionHandlerID, banid, ip, name, uid, creationTime, durationTime, invokerName, invokercldbid, invokeruid, numberOfEnforcements, lastNickName)
	debugPrint("Lua: onBanListEvent: " .. serverConnectionHandlerID .. " " .. banid .. " " .. ip .. " " .. name .. " " .. uid .. " " .. creationTime .. " " .. durationTime .. " " .. invokerName .. " " .. invokercldbid .. " " .. invokeruid .. " " .. numberOfEnforcements .. " " .. lastNickName)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onBanListEvent ~= nil then
			events.onBanListEvent(serverConnectionHandlerID, banid, ip, name, uid, creationTime, durationTime, invokerName, invokercldbid, invokeruid, numberOfEnforcements, lastNickName)
		end
	end
end

function onClientServerQueryLoginPasswordEvent(serverConnectionHandlerID, loginPassword)
	debugPrint("Lua: onClientServerQueryLoginPasswordEvent: " .. serverConnectionHandlerID .. " " .. loginPassword)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onClientServerQueryLoginPasswordEvent ~= nil then
			events.onClientServerQueryLoginPasswordEvent(serverConnectionHandlerID, loginPassword)
		end
	end
end

function onPluginCommandEvent(serverConnectionHandlerID, pluginName, pluginCommand)
	debugPrint("Lua: onPluginCommandEvent: " .. serverConnectionHandlerID .. " " .. pluginName .. " " .. pluginCommand)
	for script,events in pairs(ts3RegisteredModules) do
		if events.onPluginCommandEvent ~= nil then
			events.onPluginCommandEvent(serverConnectionHandlerID, pluginName, pluginCommand)
		end
	end
end

local menuItemIDMult = 1000

function onMenuItemEvent(serverConnectionHandlerID, menuType, menuItemID, selectedItemID)
	debugPrint("Lua: onMenuItemEvent: " .. serverConnectionHandlerID .. " " .. menuType .. " " .. menuItemID .. " " .. selectedItemID)
	local n = 1
	for script,events in pairs(ts3RegisteredModules) do
		if events.onMenuItemEvent ~= nil then
			if math.floor(menuItemID / menuItemIDMult) == n then
				events.onMenuItemEvent(serverConnectionHandlerID, menuType, menuItemID % menuItemIDMult, selectedItemID)
			end
		end
		n = n + 1
	end
end

function createMenus()
	debugPrint("Lua: createMenus")
	local menus = { "Lua Plugin", "../../gfx/default/16x16_plugins.png" }  -- Submenu name, icon (relative to plugins/lua_plugin/)
	local n = 1
	for script,events in pairs(ts3RegisteredModules) do
		if events.createMenus ~= nil then
			local menu = events.createMenus()
			for i=1, #menu do
				menu[i][2] = n * menuItemIDMult + menu[i][2]
				table.insert(menus, menu[i])
			end
		end
		n = n + 1
	end
	return menus
end

ts3autoload.loadModules()  -- Called once this script is loaded in the Lua interpreter when the Lua plugin is initialized

--[[

Currently available TS3 clientlib functions to be called from Lua:

********** Clientlib **********

*** Common ***
ts3.getClientLibVersion() > version, error
ts3.getClientLibVersionNumber() > versionNumber, error

*** Error handling ***
ts3.getErrorMessage(errorCode) > errorMessage, error

*** Loggin ***
ts3.logMessage(logMessage, severity, channel, logID) > error

*** Preprocessor ***
ts3.getPreProcessorInfoValueFloat(serverConnectionHandlerID, ident) > result, error
ts3.getPreProcessorConfigValue(serverConnectionHandlerID, ident) > result, error
ts3.setPreProcessorConfigValue(serverConnectionHandlerID, ident, value) > error

*** Encoder ***
ts3.getEncodeConfigValue(serverConnectionHandlerID, ident) > result, error

*** Playback ***
ts3.getPlaybackConfigValueAsFloat(serverConnectionHandlerID, ident) > result, error
ts3.setPlaybackConfigValue(serverConnectionHandlerID, ident, value) > error

*** Interaction with the server
ts3.requestClientMove(serverConnectionHandlerID, clientID, newChannelID, password) > error
ts3.requestClientVariables(serverConnectionHandlerID, clientID) > error
ts3.requestClientKickFromChannel(serverConnectionHandlerID, clientID, kickReason) > error
ts3.requestClientKickFromServer(serverConnectionHandlerID, clientID, kickReason) > error
ts3.requestChannelDelete(serverConnectionHandlerID, channelID, force) > error
ts3.requestChannelMove(serverConnectionHandlerID, channelID, newChannelParentID) > error
ts3.requestSendPrivateTextMsg(serverConnectionHandlerID, message, targetClientID) > error
ts3.requestSendChannelTextMsg(serverConnectionHandlerID, message, targetChannelID) > error
ts3.requestSendServerTextMsg(serverConnectionHandlerID, message) > error
ts3.requestConnectionInfo(serverConnectionHandlerID, clientID) > error
ts3.requestChannelSubscribe(serverConnectionHandlerID, channelIDArray) > error
ts3.requestChannelUnsubscribe(serverConnectionHandlerID, channelIDArray) > error
ts3.requestChannelSubscribeAll(serverConnectionHandlerID) > error
ts3.requestChannelUnsubscribeAll(serverConnectionHandlerID) > error
ts3.requestChannelDescription(serverConnectionHandlerID, channelID) > error
ts3.requestMuteClients(serverConnectionHandlerID, clientIDArray) > error
ts3.requestUnmuteClients(serverConnectionHandlerID, clientIDArray) > error

*** Access clientlib information ***
*** Query own client ID ***
ts3.getClientID(serverConnectionHandlerID) > clientID, error

*** Client info ***
ts3.getClientSelfVariableAsInt(serverConnectionHandlerID, flag) > result, error
ts3.getClientSelfVariableAsString(serverConnectionHandlerID, flag) > result, error
ts3.setClientSelfVariableAsInt(serverConnectionHandlerID, flag, value) > error
ts3.setClientSelfVariableAsString(serverConnectionHandlerID, flag, value) > error
ts3.flushClientSelfUpdates(serverConnectionHandlerID) > error
ts3.getClientVariableAsInt(serverConnectionHandlerID, clientID, flag) > result, error
ts3.getClientVariableAsUInt64(serverConnectionHandlerID, clientID, flag) > result, error
ts3.getClientVariableAsString(serverConnectionHandlerID, clientID, flag) > result, error
ts3.getClientList(serverConnectionHandlerID) > clientsList, error
ts3.getChannelOfClient(serverConnectionHandlerID, clientID) > channelID, error

*** Client connection info
ts3.getConnectionStatus(serverConnectionHandlerID) > result, error
getConnectionVariableAsUInt64(serverConnectionHandlerID, clientID, flag) > result, error
getConnectionVariableAsDouble(serverConnectionHandlerID, clientID, flag) > result, error
getConnectionVariableAsString(serverConnectionHandlerID, clientID, flag) > result, error
cleanUpConnectionInfo(serverConnectionHandlerID, clientID) > error

*** Channel info ***
ts3.getChannelVariableAsInt(serverConnectionHandlerID, channelID, flag) > result, error
ts3.getChannelVariableAsString(serverConnectionHandlerID, channelID, flag) > result, error
ts3.getChannelIDFromChannelNames(serverConnectionHandlerID, channelNames) > channelID, error
ts3.setChannelVariableAsInt(serverConnectionHandlerID, channelID, flag, value) > error
ts3.setChannelVariableAsString(serverConnectionHandlerID, channelID, flag, value) > error
ts3.flushChannelUpdates(serverConnectionHandlerID, channelID) > error
ts3.flushChannelCreation(serverConnectionHandlerID, channelParentID) > error
ts3.getChannelList(serverConnectionHandlerID) > channelList, error
ts3.getChannelClientList(serverConnectionHandlerID, channelID) > clientList, error
ts3.getParentChannelOfChannel(serverConnectionHandlerID, channelID) > parentChannelID, error

*** Server info ***
ts3.getServerConnectionHandlerList() > serverConnectionHandlerIDList, error
ts3.getServerVariableAsInt(serverConnectionHandlerID, flag) > result, error
ts3.getServerVariableAsUInt64(serverConnectionHandlerID, flag) > result, error
ts3.getServerVariableAsString(serverConnectionHandlerID, flag) > result, error
ts3.requestServerVariables(serverConnectionHandlerID) > error

********** Clientlib rare **********

*** Sound ***
ts3.playWaveFile(serverConnectionHandlerID, path) > error

*** Interacting with the server - general ***
ts3.requestClientPoke(serverConnectionHandlerID, clientID, message) > error

*** Interacting with the server - banning ***
ts3.banclient(serverConnectionHandlerID, clientID, timeInSeconds, banReason) > error
ts3.banclientdbid(serverConnectionHandlerID, clientDBID, timeInSeconds, banReason) > error
ts3.banadd(serverConnectionHandlerID, ipRegExp, nameRegexp, uniqueIdentity, timeInSeconds, banReason) > error
ts3.bandel(serverConnectionHandlerID, banID) > error
ts3.bandelall(serverConnectionHandlerID) > error
ts3.requestBanList(serverConnectionHandlerID) > error

*** Interacting with the server - complain ***
requestComplainAdd(serverConnectionHandlerID, targetClientDatabaseID, complainReason) > error
requestComplainDel(serverConnectionHandlerID, targetClientDatabaseID, fromClientDatabaseID) > error
requestComplainDelAll(serverConnectionHandlerID, targetClientDatabaseID) > error
requestComplainList(serverConnectionHandlerID, targetClientDatabaseID) > error
	
********** Client functions **********

ts3.getAppPath() > appPath
ts3.getResourcesPath() > resourcesPath
ts3.getConfigPath() > configPath
ts3.getPluginPath() > pluginPath
ts3.getCurrentServerConnectionHandlerID() > serverConnectionHandlerID
ts3.printMessage(serverConnectionHandlerID, message, pluginMessageTargetMode)
ts3.printMessageToCurrentTab(message)
ts3.urlsToBB(textWithURLs) > bbCodeText
ts3.sendPluginCommand(serverConnectionHandlerID, command, targetMode, targetIDsArray) > error
ts3.getDirectories(path) > result

]]--
