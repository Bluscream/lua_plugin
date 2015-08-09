--
-- TeamSpeak 3 error codes
--

ts3errors = {
	--general
	ERROR_ok                                     = 0x0000,
	ERROR_undefined                              = 0x0001,
	ERROR_not_implemented                        = 0x0002,
	ERROR_ok_no_update                           = 0x0003,
	ERROR_dont_notify                            = 0x0004,

	--dunno
	ERROR_command_not_found                      = 0x0100,
	ERROR_unable_to_bind_network_port            = 0x0101,
	ERROR_no_network_port_available              = 0x0102,

	--client
	ERROR_client_invalid_id                      = 0x0200,
	ERROR_client_nickname_inuse                  = 0x0201,
	ERROR_client_protocol_limit_reached          = 0x0203,
	ERROR_client_invalid_type                    = 0x0204,
	ERROR_client_already_subscribed              = 0x0205,
	ERROR_client_not_logged_in                   = 0x0206,
	ERROR_client_could_not_validate_identity     = 0x0207,
	ERROR_client_version_outdated                = 0x020a,

	--channel
	ERROR_channel_invalid_id                     = 0x0300,
	ERROR_channel_protocol_limit_reached         = 0x0301,
	ERROR_channel_already_in                     = 0x0302,
	ERROR_channel_name_inuse                     = 0x0303,
	ERROR_channel_not_empty                      = 0x0304,
	ERROR_channel_can_not_delete_default         = 0x0305,
	ERROR_channel_default_require_permanent      = 0x0306,
	ERROR_channel_invalid_flags                  = 0x0307,
	ERROR_channel_parent_not_permanent           = 0x0308,
	ERROR_channel_maxclients_reached             = 0x0309,
	ERROR_channel_maxfamily_reached              = 0x030a,
	ERROR_channel_invalid_order                  = 0x030b,
	ERROR_channel_no_filetransfer_supported      = 0x030c,
	ERROR_channel_invalid_password               = 0x030d,

	--server
	ERROR_server_invalid_id                      = 0x0400,
	ERROR_server_running                         = 0x0401,
	ERROR_server_is_shutting_down                = 0x0402,
	ERROR_server_maxclients_reached              = 0x0403,
	ERROR_server_invalid_password                = 0x0404,
	ERROR_server_is_virtual                      = 0x0407,
	ERROR_server_is_not_running                  = 0x0409,
	ERROR_server_is_booting                      = 0x040a,
	ERROR_server_status_invalid                  = 0x040b,

	--parameter
	ERROR_parameter_quote                        = 0x0600,
	ERROR_parameter_invalid_count                = 0x0601,
	ERROR_parameter_invalid                      = 0x0602,
	ERROR_parameter_not_found                    = 0x0603,
	ERROR_parameter_convert                      = 0x0604,
	ERROR_parameter_invalid_size                 = 0x0605,
	ERROR_parameter_missing                      = 0x0606,

	--unsorted, need further investigation
	ERROR_vs_critical                            = 0x0700,
	ERROR_connection_lost                        = 0x0701,
	ERROR_not_connected                          = 0x0702,
	ERROR_no_cached_connection_info              = 0x0703,
	ERROR_currently_not_possible                 = 0x0704,
	ERROR_failed_connection_initialisation       = 0x0705,
	ERROR_could_not_resolve_hostname             = 0x0706,
	ERROR_invalid_server_connection_handler_id   = 0x0707,
	ERROR_could_not_initialise_input_manager     = 0x0708,
	ERROR_clientlibrary_not_initialised          = 0x0709,
	ERROR_serverlibrary_not_initialised          = 0x070a,
	ERROR_whisper_too_many_targets               = 0x070b,
	ERROR_whisper_no_targets                     = 0x070c,

	--sound
	ERROR_sound_preprocessor_disabled            = 0x0900,
	ERROR_sound_internal_preprocessor            = 0x0901,
	ERROR_sound_internal_encoder                 = 0x0902,
	ERROR_sound_internal_playback                = 0x0903,
	ERROR_sound_no_capture_device_available      = 0x0904,
	ERROR_sound_no_playback_device_available     = 0x0905,
	ERROR_sound_could_not_open_capture_device    = 0x0906,
	ERROR_sound_could_not_open_playback_device   = 0x0907,
	ERROR_sound_handler_has_device               = 0x0908,
	ERROR_sound_invalid_capture_device           = 0x0909,
	ERROR_sound_invalid_playback_device          = 0x090a,

	--accounting
	ERROR_accounting_virtualserver_limit_reached = 0x0b00,
	ERROR_accounting_slot_limit_reached          = 0x0b01,
	ERROR_accounting_license_file_not_found      = 0x0b02,
	ERROR_accounting_license_date_not_ok         = 0x0b03,
	ERROR_accounting_unable_to_connect_to_server = 0x0b04,
	ERROR_accounting_unknown_error               = 0x0b05,
	ERROR_accounting_server_error                = 0x0b06,
	ERROR_accounting_instance_limit_reached      = 0x0b07,
	ERROR_accounting_instance_check_error        = 0x0b08,
	ERROR_accounting_license_file_invalid        = 0x0b09,
	ERROR_accounting_running_elsewhere           = 0x0b0a,
	ERROR_accounting_instance_duplicated         = 0x0b0b,
	ERROR_accounting_already_started             = 0x0b0c,
	ERROR_accounting_not_started                 = 0x0b0d,
}
