nox = {
	info = {
		name = "No X Module",
		prefix = "NoX",
		folder = "NoX",
		ext = "lua",
		ver = "0.5",
		author = "CHRiiS,Bluscream",
	},
	setting = {
		active = true,
		debug = false,
		failsave = false,
		slowmode = false,
		auto_slowmode = true,
		IDPrefix = "New identity_",
		AmountOfIDs = 507,
		BanGroups = { 12, 16 },
		SpamGroups = { 13, 14 },
	},
	var = {
		lastID = 0,
		bancount = 0,
		variables_Requested = "false",
	},
	func = {
		checkForSwitch = false,
	},
}
ScriptLog("settings.lua loaded...")