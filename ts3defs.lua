--
-- TeamSpeak 3 definitions
--

local Visibility = {
	ENTER_VISIBILITY = 0,
	RETAIN_VISIBILITY = 1,
	LEAVE_VISIBILITY = 2
}

local ConnectStatus = {
	STATUS_DISCONNECTED = 0,            -- There is no activity to the server, this is the default value
	STATUS_CONNECTING = 1,              -- We are trying to connect, we haven't got a clientID yet, we haven't been accepted by the server
	STATUS_CONNECTED = 2,               -- The server has accepted us, we can talk and hear and we got a clientID, but we don't have the channels and clients yet, we can get server infos (welcome msg etc.)
	STATUS_CONNECTION_ESTABLISHING = 3, -- we are CONNECTED and we are visible
	STATUS_CONNECTION_ESTABLISHED = 4   -- we are CONNECTED and we have the client and channels available
}

local TalkStatus = {
	STATUS_NOT_TALKING = 0,
	STATUS_TALKING = 1,
	STATUS_TALKING_WHILE_DISABLED = 2
}

local SpeexCodec = {
	CODEC_SPEEX_NARROWBAND = 0,     -- mono, 16bit,  8kHz, bitrate dependant on the quality setting
	CODEC_SPEEX_WIDEBAND = 1,       -- mono, 16bit, 16kHz, bitrate dependant on the quality setting
	CODEC_SPEEX_ULTRAWIDEBAND = 2,  -- mono, 16bit, 32kHz, bitrate dependant on the quality setting
	CODEC_CELT_MONO = 3,            -- mono, 16bit, 48kHz, bitrate dependant on the quality setting
	CODEC_DUMMY_MONO = 4            -- mono, 16bit, 48kHz, no compression (=> bitrate == 93.75 KiB/s!)
}

local TextMessageTargetMode = {
	TextMessageTarget_CLIENT = 1,
	TextMessageTarget_CHANNEL = 2,
	TextMessageTarget_SERVER = 3,
	TextMessageTarget_MAX = 4
}

local MuteInputStatus = {
	MUTEINPUT_NONE = 0,
	MUTEINPUT_MUTED = 1
}

local MuteOutputStatus = {
	MUTEOUTPUT_NONE = 0,
	MUTEOUTPUT_MUTED = 1
}

local HardwareInputStatus = {
	HARDWAREINPUT_DISABLED = 0,
	HARDWAREINPUT_ENABLED = 1
}

local HardwareOutputStatus = {
	HARDWAREOUTPUT_DISABLED = 0,
	HARDWAREOUTPUT_ENABLED = 1
}

local InputDeactivationStatus = {
	INPUT_ACTIVE = 0,
	INPUT_DEACTIVATED = 1
}

local ClientProperties = {
	CLIENT_UNIQUE_IDENTIFIER = 0,                -- automatically up-to-date for any client "in view", can be used to identify this particular client installation
	CLIENT_NICKNAME = 1,                         -- automatically up-to-date for any client "in view"
	CLIENT_VERSION = 2,                          -- for other clients than ourself, this needs to be requested (=> requestClientVariables)
	CLIENT_PLATFORM = 3,                         -- for other clients than ourself, this needs to be requested (=> requestClientVariables)
	CLIENT_FLAG_TALKING = 4,                     -- automatically up-to-date for any client that can be heard (in room / whisper)
	CLIENT_INPUT_MUTED = 5,                      -- automatically up-to-date for any client "in view", this clients microphone mute status
	CLIENT_OUTPUT_MUTED = 6,                     -- automatically up-to-date for any client "in view", this clients headphones/speakers mute status
	CLIENT_OUTPUTONLY_MUTED = 7,                 -- automatically up-to-date for any client "in view", this clients headphones/speakers only mute status
	CLIENT_INPUT_HARDWARE = 8,                   -- automatically up-to-date for any client "in view", this clients microphone hardware status (is the capture device opened?)
	CLIENT_OUTPUT_HARDWARE = 9,                  -- automatically up-to-date for any client "in view", this clients headphone/speakers hardware status (is the playback device opened?)
	CLIENT_INPUT_DEACTIVATED = 10,               -- only usable for ourself, not propagated to the network
	CLIENT_IDLE_TIME = 11,                       -- internal use
	CLIENT_DEFAULT_CHANNEL = 12,                 -- only usable for ourself, the default channel we used to connect on our last connection attempt
	CLIENT_DEFAULT_CHANNEL_PASSWORD = 13,        -- internal use
	CLIENT_SERVER_PASSWORD = 14,                 -- internal use
	CLIENT_META_DATA = 15,                       -- automatically up-to-date for any client "in view", not used by TeamSpeak, free storage for sdk users
	CLIENT_IS_MUTED = 16,                        -- only make sense on the client side locally, "1" if this client is currently muted by us, "0" if he is not
	CLIENT_IS_RECORDING = 17,                    -- automatically up-to-date for any client "in view"
	CLIENT_VOLUME_MODIFICATOR = 18,
	CLIENT_ENDMARKER = 19,
	CLIENT_DUMMY_1 = 19,                         -- (Must be the same as CLIENT_ENDMARKER)
	CLIENT_DUMMY_2 = 20,
	CLIENT_DUMMY_3 = 21,
	CLIENT_DUMMY_4 = 22,
	CLIENT_DUMMY_5 = 23,
	CLIENT_DUMMY_6 = 24,
	CLIENT_DUMMY_7 = 25,
	CLIENT_DUMMY_8 = 26,
	CLIENT_DUMMY_9 = 27,
	CLIENT_KEY_OFFSET = 28,                      -- internal use
	CLIENT_LAST_VAR_REQUEST = 29,                -- internal use
	CLIENT_LOGIN_NAME = 30,                      -- used for serverquery clients, makes no sense on normal clients currently
	CLIENT_LOGIN_PASSWORD = 31,                  -- used for serverquery clients, makes no sense on normal clients currently
	CLIENT_DATABASE_ID = 32,                     -- automatically up-to-date for any client "in view", only valid with PERMISSION feature, holds database client id
	CLIENT_CHANNEL_GROUP_ID = 33,                -- automatically up-to-date for any client "in view", only valid with PERMISSION feature, holds database client id
	CLIENT_SERVERGROUPS = 34,                    -- automatically up-to-date for any client "in view", only valid with PERMISSION feature, holds all servergroups client belongs too
	CLIENT_CREATED = 35,                         -- this needs to be requested (=> requestClientVariables), first time this client connected to this server
	CLIENT_LASTCONNECTED = 36,                   -- this needs to be requested (=> requestClientVariables), last time this client connected to this server
	CLIENT_TOTALCONNECTIONS = 37,                -- this needs to be requested (=> requestClientVariables), how many times this client connected to this server
	CLIENT_AWAY = 38,                            -- automatically up-to-date for any client "in view", this clients away status
	CLIENT_AWAY_MESSAGE = 39,                    -- automatically up-to-date for any client "in view", this clients away message
	CLIENT_TYPE = 40,                            -- automatically up-to-date for any client "in view", determines if this is a real client or a server-query connection
	CLIENT_FLAG_AVATAR = 41,                     -- automatically up-to-date for any client "in view", this client got an avatar
	CLIENT_TALK_POWER = 42,                      -- automatically up-to-date for any client "in view", only valid with PERMISSION feature, holds database client id
	CLIENT_TALK_REQUEST = 43,                    -- automatically up-to-date for any client "in view", only valid with PERMISSION feature, holds timestamp where client requested to talk
	CLIENT_TALK_REQUEST_MSG = 44,                -- automatically up-to-date for any client "in view", only valid with PERMISSION feature, holds matter for the request
	CLIENT_DESCRIPTION = 45,                     -- automatically up-to-date for any client "in view"
	CLIENT_IS_TALKER = 46,                       -- automatically up-to-date for any client "in view"
	CLIENT_MONTH_BYTES_UPLOADED = 47,            -- this needs to be requested (=> requestClientVariables)
	CLIENT_MONTH_BYTES_DOWNLOADED = 48,          -- this needs to be requested (=> requestClientVariables)
	CLIENT_TOTAL_BYTES_UPLOADED = 49,            -- this needs to be requested (=> requestClientVariables)
	CLIENT_TOTAL_BYTES_DOWNLOADED = 50,	         -- this needs to be requested (=> requestClientVariables)
	CLIENT_IS_PRIORITY_SPEAKER = 51,             -- automatically up-to-date for any client "in view"
	CLIENT_UNREAD_MESSAGES = 52,                 -- automatically up-to-date for any client "in view"
	CLIENT_NICKNAME_PHONETIC = 53,               -- automatically up-to-date for any client "in view"
	CLIENT_NEEDED_SERVERQUERY_VIEW_POWER = 54,   -- automatically up-to-date for any client "in view"
	CLIENT_DEFAULT_TOKEN = 55,                   -- only usable for ourself, the default token we used to connect on our last connection attempt
	CLIENT_ICON_ID = 56,                         -- automatically up-to-date for any client "in view"
	CLIENT_IS_CHANNEL_COMMANDER = 57,            -- automatically up-to-date for any client "in view"
	CLIENT_ENDMARKER_RARE = 58
}

local ChannelProperties = {
	CHANNEL_NAME = 0,                              -- Available for all channels that are "in view", always up-to-date
	CHANNEL_TOPIC = 1,                             -- Available for all channels that are "in view", always up-to-date
	CHANNEL_DESCRIPTION = 2,                       -- Must be requested (=> requestChannelDescription)
	CHANNEL_PASSWORD = 3,                          -- not available client side
	CHANNEL_CODEC = 4,                             -- Available for all channels that are "in view", always up-to-date
	CHANNEL_CODEC_QUALITY = 5,                     -- Available for all channels that are "in view", always up-to-date
	CHANNEL_MAXCLIENTS = 6,                        -- Available for all channels that are "in view", always up-to-date
	CHANNEL_MAXFAMILYCLIENTS = 7,                  -- Available for all channels that are "in view", always up-to-date
	CHANNEL_ORDER = 8,                             -- Available for all channels that are "in view", always up-to-date
	CHANNEL_FLAG_PERMANENT = 9,                    -- Available for all channels that are "in view", always up-to-date
	CHANNEL_FLAG_SEMI_PERMANENT = 10,              -- Available for all channels that are "in view", always up-to-date
	CHANNEL_FLAG_DEFAULT = 11,                     -- Available for all channels that are "in view", always up-to-date
	CHANNEL_FLAG_PASSWORD = 12,                    -- Available for all channels that are "in view", always up-to-date
	CHANNEL_ENDMARKER = 13,
	CHANNEL_DUMMY_0 = 13,                          -- (Must be the same as CHANNEL_ENDMARKER)
	CHANNEL_DUMMY_1 = 14,
	CHANNEL_DUMMY_2 = 15,
	CHANNEL_DUMMY_3 = 16,
	CHANNEL_DUMMY_4 = 17,
	CHANNEL_DUMMY_5 = 18,
	CHANNEL_DUMMY_6 = 19,
	CHANNEL_DUMMY_7 = 20,
	CHANNEL_DUMMY_8 = 21,
	CHANNEL_DUMMY_9 = 22,
	CHANNEL_FLAG_MAXCLIENTS_UNLIMITED = 23,       -- Available for all channels that are "in view", always up-to-date
	CHANNEL_FLAG_MAXFAMILYCLIENTS_UNLIMITED = 24, -- Available for all channels that are "in view", always up-to-date
	CHANNEL_FLAG_MAXFAMILYCLIENTS_INHERITED = 25, -- Available for all channels that are "in view", always up-to-date
	CHANNEL_FLAG_ARE_SUBSCRIBED = 26,             -- Only available client side, stores whether we are subscribed to this channel
	CHANNEL_FILEPATH = 27,                        -- not available client side, the folder used for file-transfers for this channel
	CHANNEL_NEEDED_TALK_POWER = 28,               -- Available for all channels that are "in view", always up-to-date
	CHANNEL_FORCED_SILENCE = 29,                  -- Available for all channels that are "in view", always up-to-date
	CHANNEL_NAME_PHONETIC = 30,                   -- Available for all channels that are "in view", always up-to-date
	CHANNEL_ICON_ID = 31,                         -- Available for all channels that are "in view", always up-to-date
	CHANNEL_ENDMARKER_RARE = 32
}

local VirtualServerProperties = {
	VIRTUALSERVER_UNIQUE_IDENTIFIER = 0,                            -- available when connected, can be used to identify this particular server installation
	VIRTUALSERVER_NAME = 1,                                         -- available and always up-to-date when connected
	VIRTUALSERVER_WELCOMEMESSAGE = 2,                               -- available when connected,  (=> requestServerVariables)
	VIRTUALSERVER_PLATFORM = 3,                                     -- available when connected
	VIRTUALSERVER_VERSION = 4,                                      -- available when connected
	VIRTUALSERVER_MAXCLIENTS = 5,                                   -- only available on request (=> requestServerVariables), stores the maximum number of clients that may currently join the server
	VIRTUALSERVER_PASSWORD = 6,                                     -- not available to clients, the server password
	VIRTUALSERVER_CLIENTS_ONLINE = 7,                               -- only available on request (=> requestServerVariables),
	VIRTUALSERVER_CHANNELS_ONLINE = 8,                              -- only available on request (=> requestServerVariables),
	VIRTUALSERVER_CREATED = 9,                                      -- available when connected, stores the time when the server was created
	VIRTUALSERVER_UPTIME = 10,                                      -- only available on request (=> requestServerVariables), the time since the server was started
	VIRTUALSERVER_ENDMARKER = 11,           
	VIRTUALSERVER_DUMMY_0 = 11,                                     -- (Must be the same as VIRTUALSERVER_ENDMARKER)
	VIRTUALSERVER_DUMMY_1 = 12,
	VIRTUALSERVER_DUMMY_2 = 13,
	VIRTUALSERVER_DUMMY_3 = 14,
	VIRTUALSERVER_DUMMY_4 = 15,
	VIRTUALSERVER_DUMMY_5 = 16,
	VIRTUALSERVER_DUMMY_6 = 17,
	VIRTUALSERVER_DUMMY_7 = 18,
	VIRTUALSERVER_DUMMY_8 = 19,
	VIRTUALSERVER_DUMMY_9 = 20,
	VIRTUALSERVER_KEYPAIR = 21,                                     -- internal use
	VIRTUALSERVER_HOSTMESSAGE = 22,                                 -- available when connected, not updated while connected
	VIRTUALSERVER_HOSTMESSAGE_MODE = 23,                            -- available when connected, not updated while connected
	VIRTUALSERVER_FILEBASE = 24,                                    -- not available to clients, stores the folder used for file transfers
	VIRTUALSERVER_DEFAULT_SERVER_GROUP = 25,                        -- the client permissions server group that a new client gets assigned
	VIRTUALSERVER_DEFAULT_CHANNEL_GROUP = 26,                       -- the channel permissions group that a new client gets assigned when joining a channel
	VIRTUALSERVER_FLAG_PASSWORD = 27,                               -- available when connected, always up-to-date 
	VIRTUALSERVER_DEFAULT_CHANNEL_ADMIN_GROUP = 28,                 -- the channel permissions group that a client gets assigned when creating a channel
	VIRTUALSERVER_MAX_DOWNLOAD_TOTAL_BANDWIDTH = 29,                -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_MAX_UPLOAD_TOTAL_BANDWIDTH = 30,                  -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_HOSTBANNER_URL = 31,                              -- available when connected, always up-to-date 
	VIRTUALSERVER_HOSTBANNER_GFX_URL = 32,                          -- available when connected, always up-to-date
	VIRTUALSERVER_HOSTBANNER_GFX_INTERVAL = 33,                     -- available when connected, always up-to-date
	VIRTUALSERVER_COMPLAIN_AUTOBAN_COUNT = 34,                      -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_COMPLAIN_AUTOBAN_TIME = 35,                       -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_COMPLAIN_REMOVE_TIME = 36,                        -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_MIN_CLIENTS_IN_CHANNEL_BEFORE_FORCED_SILENCE = 37,-- only available on request (=> requestServerVariables)
	VIRTUALSERVER_PRIORITY_SPEAKER_DIMM_MODIFICATOR = 38,           -- available when connected, always up-to-date
	VIRTUALSERVER_ID = 39,                                          -- available when connected
	VIRTUALSERVER_ANTIFLOOD_POINTS_TICK_REDUCE = 40,                -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_ANTIFLOOD_POINTS_NEEDED_WARNING = 41,             -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_ANTIFLOOD_POINTS_NEEDED_KICK = 42,                -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_ANTIFLOOD_POINTS_NEEDED_BAN = 43,                 -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_ANTIFLOOD_POINTS_BAN_TIME = 44,                   -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_CLIENT_CONNECTIONS = 45,                          -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_QUERY_CLIENT_CONNECTIONS = 46,                    -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_HOSTBUTTON_TOOLTIP = 47,                          -- available when connected, always up-to-date
	VIRTUALSERVER_HOSTBUTTON_URL = 48,                              -- available when connected, always up-to-date
	VIRTUALSERVER_HOSTBUTTON_GFX_URL = 49,                          -- available when connected, always up-to-date
	VIRTUALSERVER_QUERYCLIENTS_ONLINE = 50,                         -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_DOWNLOAD_QUOTA = 51,                              -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_UPLOAD_QUOTA = 52,                                -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_MONTH_BYTES_DOWNLOADED = 53,                      -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_MONTH_BYTES_UPLOADED = 54,                        -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_TOTAL_BYTES_DOWNLOADED = 55,                      -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_TOTAL_BYTES_UPLOADED = 56,                        -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_PORT = 57,                                        -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_AUTOSTART = 58,                                   -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_MACHINE_ID = 59,                                  -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_NEEDED_IDENTITY_SECURITY_LEVEL = 60,              -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_LOG_CLIENT = 61,                                  -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_LOG_QUERY = 62,                                   -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_LOG_CHANNEL = 63,                                 -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_LOG_PERMISSIONS = 64,                             -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_LOG_SERVER = 65,                                  -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_LOG_FILETRANSFER = 66,                            -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_MIN_CLIENT_VERSION = 67,                          -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_NAME_PHONETIC = 68,                               -- available when connected, always up-to-date
	VIRTUALSERVER_ICON_ID = 69,                                     -- available when connected, always up-to-date
	VIRTUALSERVER_RESERVED_SLOTS = 70,                              -- available when connected, always up-to-date
	VIRTUALSERVER_TOTAL_PACKETLOSS_SPEECH = 71,                     -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_TOTAL_PACKETLOSS_KEEPALIVE = 72,                  -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_TOTAL_PACKETLOSS_CONTROL = 73,                    -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_TOTAL_PACKETLOSS_TOTAL = 74,                      -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_TOTAL_PING = 75,                                  -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_IP = 76,                                          -- internal use | contains only ONE binded ip
	VIRTUALSERVER_WEBLIST_ENABLED = 77,                             -- only available on request (=> requestServerVariables)
	VIRTUALSERVER_ENDMARKER_RARE = 78
}

local LogTypes = {
	LogType_NONE          = 0x0000,
	LogType_FILE          = 0x0001,
	LogType_CONSOLE       = 0x0002,
	LogType_USERLOGGING   = 0x0004,
	LogType_NO_NETLOGGING = 0x0008,
	LogType_DATABASE      = 0x0010
}

local LogLevel = {
	LogLevel_CRITICAL = 0, -- these messages stop the program
	LogLevel_ERROR = 1,    -- everything that is really bad, but not so bad we need to shut down
	LogLevel_WARNING = 2,  -- everything that *might* be bad
	LogLevel_DEBUG = 3,    -- output that might help find a problem
	LogLevel_INFO = 4,     -- informational output, like "starting database version x.y.z"
	LogLevel_DEVEL = 5     -- developer only output (will not be displayed in release mode)
}

local PluginMenuType = {
	PLUGIN_MENU_TYPE_GLOBAL = 0,
	PLUGIN_MENU_TYPE_CHANNEL = 1,
	PLUGIN_MENU_TYPE_CLIENT = 2
}

-- Package exports
ts3defs = {
    Visibility = Visibility,
    ConnectStatus = ConnectStatus,
	TalkStatus = TalkStatus,
	SpeexCodec = SpeexCodec,
	TextMessageTargetMode = TextMessageTargetMode,
	MuteInputStatus = MuteInputStatus,
	MuteOutputStatus = MuteOutputStatus,
	HardwareInputStatus = HardwareInputStatus,
	HardwareOutputStatus = HardwareOutputStatus,
	InputDeactivationStatus = InputDeactivationStatus,
	ClientProperties = ClientProperties,
	ChannelProperties = ChannelProperties,
	VirtualServerProperties = VirtualServerProperties,
	LogTypes = LogTypes,
	LogLevel = LogLevel,
	PluginMenuType = PluginMenuType
}
