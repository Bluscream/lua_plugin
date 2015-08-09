channelKicker = {
	info = {
		MODULE = "Channel Kicker Module",
		MODULESHORT = "CK",
		MODULEFOLDER = "channelKicker",
		MODULEEXT = "lua",
		MODULEVERSION = "1.0",
		MODULEAUTHOR = "Bluscream",
	},
	setting = {
		active = true,
		DEBUG = true,
		textdebug = false,
		language = "german",
		mode = "",-- musicbot
		channelkick_active = true,
		channelban_active = false,
		serverkick_active = false,
		serverban_active = false,
		add_complain = false,
		client_mute = true,
		client_block = true,
		log_auto_kicks = true,
		log_not_welcome_kicks = true,
		msg_instead_of_log = false,
		ck_send_infotext = true,
		send_verified_text = false,
		auto_channel_commander = true,
		
	},
	func = {
		auto_switch_back = {
			enabled = false,
		},
		auto_reconnect = {
			enabled = true,
		},
		autojoin_channel = {
			enabled = true,
			channelName = "Blu's Matrix | ♪☆♫ JukeBox ♫☆♪"
		},
		troll_mode = {
			enabled = false,
		},
		troll_mode_tp = {
			enabled = true, 
		},
		kick_on_not_welcome = {
			enabled = true,
			channelkick_active = true,
			channelban_active = true,
			serverkick_active = false,
			serverban_active = false,
			add_complain = false,
			client_mute = false,
			kick_on_move = false,
			lang = { 
				en = "",
				de = "",
			},
		},
		kick_on_default_channel = {
			enabled = true,
			visibility_check = false,
			channelkick_active = false,
			channelban_active = false,
			serverkick_active = false,
			serverban_active = false,
			add_complain = false,
			client_mute = false,
		},
		kick_on_recording_started = {
			enabled = true,
			channelkick_active = true,
			channelban_active = true,
			serverkick_active = false,
			serverban_active = false,
			add_complain = false,
			client_mute = true,
		},
		kick_on_join_recording = {
			enabled = true,
			channelkick_active = true,
			channelban_active = true,
			serverkick_active = false,
			serverban_active = false,
			add_complain = false,
			client_mute = false,
		},
		kick_on_ts3server_link = {
			enabled = true,
			channelkick_active = true,
			channelban_active = true,
			serverkick_active = false,
			serverban_active = false,
			add_complain = false,
			client_mute = false,
		},
		kick_on_ip_adress = {
			enabled = true,
			channelkick_active = true,
			channelban_active = true,
			serverkick_active = false,
			serverban_active = false,
			add_complain = false,
			client_mute = false,
		},
		kick_on_less_connects = {
			enabled = false,
			channelkick_active = true,
			channelban_active = true,
			serverkick_active = false,
			serverban_active = false,
			add_complain = false,
			client_mute = false,
		},
		kick_on_freeze_code = {
			enabled = true,
			channelkick_active = true,
			channelban_active = true,
			serverkick_active = false,
			serverban_active = false,
			add_complain = true,
			client_mute = true,
		},
		kick_on_clear_code = {
			enabled = true,
			channelkick_active = true,
			channelban_active = true,
			serverkick_active = false,
			serverban_active = false,
			add_complain = false,
			client_mute = true,
		},
		kick_on_spam = {
			enabled = true,
			channelkick_active = true,
			channelban_active = false,
			serverkick_active = false,
			serverban_active = false,
			add_complain = false,
			client_mute = false,
		},
		kick_on_bad_name = {
			enabled = true,
		},
			kick_on_default_nick = {
				enabled = false,
				channelkick_active = true,
				channelban_active = true,
				serverkick_active = false,
				serverban_active = false,
				add_complain = false,
				client_mute = false,
			},
			kick_on_bad_char = {
				enabled = true,
				channelkick_active = true,
				channelban_active = true,
				serverkick_active = false,
				serverban_active = false,
				add_complain = false,
				client_mute = false,
			},
			kick_on_bad_nick = {
				enabled = true,
				channelkick_active = true,
				channelban_active = true,
				serverkick_active = false,
				serverban_active = false,
				add_complain = false,
				client_mute = false,
			},
			kick_on_banned_nick = {
				enabled = true,
				channelkick_active = true,
				channelban_active = true,
				serverkick_active = false,
				serverban_active = false,
				add_complain = false,
				client_mute = false,
			},
			kick_on_banned_uid = {
				enabled = true,
				channelkick_active = true,
				channelban_active = true,
				serverkick_active = false,
				serverban_active = false,
				add_complain = false,
				client_mute = false,
			},
		kick_useless_clients = {
			enabled = true,
		},
			kick_on_output_muted = {
				enabled = false,
				channelkick_active = true,
				channelban_active = true,
				serverkick_active = false,
				serverban_active = false,
				add_complain = false,
				client_mute = false,			
			},
			kick_on_output_only_muted = {
				enabled = false,
				channelkick_active = true,
				channelban_active = true,
				serverkick_active = false,
				serverban_active = false,
				add_complain = false,
				client_mute = false,
			},
			kick_on_away = {
				enabled = true,
				channelkick_active = true,
				channelban_active = true,
				serverkick_active = false,
				serverban_active = false,
				add_complain = false,
				client_mute = false,
			},
			kick_on_idle = {
				enabled = false,
				channelkick_active = true,
				channelban_active = true,
				serverkick_active = false,
				serverban_active = false,
				add_complain = false,
				client_mute = false,
			},
		kick_on_bad_words = {
			enabled = true,
			channelkick_active = true,
			channelban_active = true,
			serverkick_active = false,
			serverban_active = false,
			add_complain = false,
			client_mute = false
		},
		kick_on_blocked_msg = {
			enabled = true,
			channelkick_active = true,
			channelban_active = true,
			serverkick_active = false,
			serverban_active = false,
			add_complain = false,
			client_mute = false,
		},
		kick_on_links = {
			enabled = false,
			channelkick_active = true,
			channelban_active = true,
			serverkick_active = false,
			serverban_active = false,
			add_complain = false,
			client_mute = false,
		},
		kick_on_bad_servergroup = {
			enabled = true,		
			channelkick_active = true,
			channelban_active = true,
			serverkick_active = false,
			serverban_active = false,
			add_complain = false,
			client_mute = false,
		},
		kick_on_bad_os = {
			enabled = false,		
			channelkick_active = true,
			channelban_active = true,
			serverkick_active = false,
			serverban_active = false,
			add_complain = false,
			client_mute = false,
		},
		kick_on_bad_country = {
			enabled = false,		
			channelkick_active = true,
			channelban_active = true,
			serverkick_active = false,
			serverban_active = false,
			add_complain = false,
			client_mute = false,
		},
		auto_talk_power_request = {
			enabled = false,
		},
		auto_talk_power_request_others = {
			enabled = false,
		},
		convert_tv_meetings = {
			enabled = true,
		},
		inform_spoofed_link = {
			enabled = true,
		},
	},
}
if channelKicker.setting.active == false then
	return
end
if channelKicker.setting.mode == "musicbot" then
	ts3.printMessageToCurrentTab("CK Mode: "..channelKicker.setting.mode)
	channelKicker.func.kick_on_default_channel.enabled = false
	channelKicker.func.kick_on_recording_started.enabled = false
	channelKicker.func.kick_on_join_recording.enabled = false
	channelKicker.func.kick_on_less_connects.enabled = false
	channelKicker.func.kick_useless_clients.enabled = true
		channelKicker.func.kick_on_output_muted.enabled = true
		channelKicker.func.kick_on_output_only_muted.enabled = true
		channelKicker.func.kick_on_away.enabled = false
		channelKicker.func.kick_on_idle.enabled = false
	channelKicker.func.kick_on_links.enabled = false
end