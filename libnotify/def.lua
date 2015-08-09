--
-- libNotify Defines
--
-- Alle globalen Definitionen sind hier zu finden
--

-- System - Konfiguration
libNotifySystemConfig = {
	-- Aktives Betriebssystem
	activeOS				=	"linux",
	-- Supportete Betriebssysteme
	supportedOS				=	{
		-- Windows 7 (evtl. ältere)
		WINDOWS				=	"windows",
		-- Linux
		LINUX				=	"linux",
	},
	-- Konfigurationen für die einzelnen Betriebbsysteme
	OSConfig				=	{
		-- Windows
		WINDOWS				=	{
			-- Growl - Notifications
			GROWL_Exec		=	{
				-- Pfad zur Exe
				PATH		=	"C:\\Growl\\growlnotify.exe",
				-- Plugin aktiv
				ACTIVE		=	true,
			},
		},
		-- Linux
		LINUX				=	{
			-- LibNotify - Notifications
			LIBNOTIFY_Exec	=	{
				-- Pfad zur Executable
				PATH		=	"/usr/bin/notify-send",
				-- Plugin aktiv
				ACTIVE		=	true,
			},
		},
	},
}

-- Konfiguration
notificationConfig = {
	-- Listing-Feature aktivieren
	activateList		=	true,
	-- Listen-Typ (Nutzbare Werte: "blacklist", "whitelist")
	activatedListType	=	"whitelist",
	-- Sprache
	language = "EN",
	-- Pfad zur Liste
	listFile			=	ts3.getConfigPath() .. "libNotify.list",
	-- Pfad zum Standard-Icon
	notificationIcon	=	ts3.getAppPath() .. "gfx/default/32x32_player_on.png",
	-- Pfad zum Whisper-Icon
	whisperIcon		=	ts3.getAppPath() .. "gfx/default/32x32_player_whisper.png",
	-- Pfad zum Chat-Icon
	chatIcon		=	ts3.getAppPath() .. "gfx/default/32x32_player_chat.png",
	-- Channel-Nachrichten anzeigen
	chatShowChan		=	false,
	-- Chat-Event aktiv
	chatCheckActive		=	true,
	-- Chat-Event global (Black-/Whitelist übergehen)
	chatCheckListOverride = false,
	-- Poke-Event aktiv
	pokeCheckActive		=	true,
	-- Poke-Event global (Black-/Whitelist übergehen)
	pokeCheckListOverride	=	true,
	-- Move-Event aktiv
	moveCheckActive		=	true,
	-- Move-Moved-Event aktiv
	moveMovedCheckActive	=	true,
	-- Whisper-Event aktiv
	whisperCheckActive	=	true,
}

-- Notification-Messages
notificationMessages = {
	DE = {
		joinChannel		=	"hat deinen Channel auf {SERVERNAME} betreten!!",
		leaveChannel	=	"hat deinen Channel auf {SERVERNAME} verlassen!!",
		leaveServer		=	"hat den Server {SERVERNAME} verlassen!!",
		movedToChannel	=	"wurde von {MOVERNAME} auf {SERVERNAME} in ihren Channel geschoben!!",
		movedOutChannel	=	"wurde von {MOVERNAME} auf {SERVERNAME} aus ihrem Channel geschoben!!",
		movedChannel	=	"wurde von {MOVERNAME} auf {SERVERNAME} in {CHANNELNAME} geschoben!!",
		whisper			=	"whispert sie auf {SERVERNAME} an!!",
		poke			=	"stupst sie mit '{MESSAGE}' auf {SERVERNAME} an!!",
		privChat		=	"hat ihnen eine Nachricht auf {SERVERNAME} geschrieben!!",
		chanChat		=	"hat eine Nachricht in ihrem Channel auf {SERVERNAME} geschrieben!!",
	},
	EN	= {
		joinChannel		=	"has entered your Channel on {SERVERNAME}!",
		leaveChannel	=	"has left your Channel on {SERVERNAME}!",
		leaveServer		=	"has left the server {SERVERNAME}!",
		movedToChannel	=	"has been moved by {MOVERNAME} on {SERVERNAME} to your Channel!",
		movedOutChannel	=	"has been moved by {MOVERNAME} on {SERVERNAME} from your channel!",
		movedChannel	=	"has been moved by {MOVERNAME} on {SERVERNAME} to {CHANNELNAME}!",
		whisper			=	"whispered you on {SERVERNAME}!",
		poke			=	"poked you with '{MESSAGE}' on {SERVERNAME}!",
		privChat		=	"has written a message to you on {SERVERNAME}!",
		chanChat		=	"wrote a message to your channel on {SERVERNAME}!",
	}
}
