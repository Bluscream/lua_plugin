prefer = {}
--print("PREFER", prefer)
prefer.bot = {
	["welcome"] = "Welcome Message",
	["welcomeMessage"] = "Welcome Message",
	["prefix"] = "Bot Prefix",
	["prefixStyle"] = "Bot Prefix Style",
	["prefixColor"] = "Bot Prefix Color",
	["sayEnabled"] = "Bot Say-Command",
	["slapEnabled"] = "Bot Slap-Command",
	["nameEnabled"] = "Bot Name-Command",
	["spamEnabled"] = "Spam Protection",
	["moveEnabled"] = "Bot Move-Command",
	["mode"] = "Mode",
	["soundtype"] = "Sounds Type",
	["type"] = "Bot Type",
	["defaultChannel"] = "Default Channel",
	["spamProtect"] = "Spam Protection"
}

prefer.bot.order = {
	["welcome"] = "i",
	["welcomeMessage"] = "j",
	["prefix"] = "a",
	["prefixStyle"] = "b",
	["prefixColor"] = "c",
	["sayEnabled"] = "k",
	["slapEnabled"] = "l",
	["nameEnabled"] = "m",
	["spamEnabled"] = "n",
	["moveEnabled"] = "o",
	["mode"] = "f",
	["soundtype"] = "g",
	["type"] = "h",
	["defaultChannel"] = "d",
	["spamProtect"] = "e"
}

prefer.bot.values = {
	["welcome"] = "boolean",
	["welcomeMessage"] = "string",
	["prefix"] = "string",
	["prefixStyle"] = "multicustom",
	["prefixColor"] = "color",
	["sayEnabled"] = "boolean",
	["slapEnabled"] = "boolean",
	["nameEnabled"] = "boolean",
	["spamEnabled"] = "boolean",
	["moveEnabled"] = "boolean",
	["mode"] = "custom",
	["soundtype"] = "custom",
	["type"] = "custom",
	["defaultChannel"] = "channel",
	["spamProtect"] = "time"
}
prefer.bot.restrict = {
	["prefixStyle"] = prefer.styles,
	["spamProtect"] = {["min"] = 1, ["max"] = 5}
}
botModes = {
	[1] = "Idle",
	[2] = "Muted",
	[3] = "Full"
}

botSoundTypes = {
	[1] = "Default",
	[2] = "VAC Mode"
}

botType = {
	[1] = "User",
	[2] = "Dedicated"
}
prefer.styles = {
	["b"] = "Bold",
	["i"] = "Italic",
	["u"] = "Underline"
}
prefer.bot.custom = {
	["type"] = botType,
	["mode"] = botModes,
	["soundtype"] = botSoundTypes
}

prefer.bot.multicustom = {
	["prefixStyle"] = prefer.styles
}

prefer.bot.desc = {
	["welcome"] = "Welcome message on or off",
	["welcomeMessage"] = "Welcome message to send to connecting users.",
	["prefix"] = "What is shown before bot messages are sent. Usually a name.",
	["prefixStyle"] = "The style of the prefix. b = Bold, U = Underline, I = Italicized",
	["prefixColor"] = "The color of the prefix.",
	["UID"] = "The TS3 Unique ID of the current bot. This should be YOUR Unique ID.",
	["sayEnabled"] = "Bot Say command on or off",
	["slapEnabled"] = "Bot Slap command on or off",
	["nameEnabled"] = "Whether or not users with 'bot' permissions can change the bot's name.",
	["spamEnabled"] = "Spam Protection on or off",
	["moveEnabled"] = "Whether or not users with 'bot' permissions can move the bot to different channels.",
	["mode"] = "The bot mode, idle (no commands), muted (no sounds), full (all commands)",
	["soundtype"] = "The bot's sound type, normal or VAC. VAC is for users with a way to relay sounds into their Teamspeak.",
	["type"] = "The bot type, User and Dedicated. User is for people running it on their current computer/client. Dedicated is for people who have it set up on a different machine.",
	["defaultChannel"] = "Default channel of the server. Important for Welcome Message.",
	["commandPrefix"] = "Bot command prefix",
	["spamProtect"] = "Spam Protection in seconds. 1 is usually fine. 2 is for bigger servers. 3 is for huge servers with spammers."
}

prefer.sounds = {
	["enabled"] = "Enabled",
	["forced"] = "Forced Sounds",
	["global"] = "Global Sounds",
	["private"] = "Private Sounds",
	["anon"] = "Anonymous Sounds",
	["topmax"] = "Top Max"
}

prefer.sounds.order = {
	["enabled"] = 1,
	["global"] = 2,
	["private"] = 3,
	["forced"] = 4,
	["anon"] = 5,
	["topmax"] = 6
}

prefer.sounds.desc = {
	["enabled"] = "Whether or not sounds are enabled",
	["forced"] = "Whether or not forced sounds are enabled",
	["global"] = "Whether or not global sounds are enabled",
	["private"] = "Turn on or off private sounds",
	["anon"] = "Turn on/off user's ability to play sounds without showing their name.",
	["topmax"] = "The maximum amount of top sounds a user can view. (A large number may cause lag.)"
}

prefer.sounds.values = {
	["enabled"] = "boolean",
	["forced"] = "boolean",
	["global"] = "boolean",
	["private"] = "boolean",
	["anon"] = "boolean",
	["topmax"] = "integer"
}

prefer.afk = {
	["afkEnabled"] = "Enabled",
	["afkTimeout"] = "AFK Timer",
	["afkType"] = "AFK Action",
	["afkChan"] = "AFK Channel"
}

prefer.afk.order = {
	["afkEnabled"] = 1,
	["afkTimeout"] = 2,
	["afkType"] = 3,
	["afkChan"] = 4
}

prefer.afk.desc = {
	["afkEnabled"] = "Turn the AFK system on or off.",
	["afkTimeout"] = "How long until a user is AFK?",
	["afkType"] = "Kick or move users when they are AFK?",
	["afkChan"] = "What channel should they be moved to?"
}

prefer.afk.values = {
	["afkEnabled"] = "boolean",
	["afkTimeout"] = "integer",
	["afkType"] = "custom",
	["afkChan"] = "channel"
}

afkTypes = {
	[1] = "Move",
	[2] = "Kick"
}

prefer.afk.custom = {
	["afkType"] = afkTypes
}

prefer.groups = {
	["name"] = "Name",
	["color"] = "Color",
	["style"] = "Style",
	["permission level"] = "Permission Level"
}

prefer.slaps = {
	["default"] = ":from: slapped :to: in the face with a slimy fish.",
	["self"] = ":from: slapped himself silly.",
	["pimp"] = ":from: pimp slapped :to:. Ouch."
}



