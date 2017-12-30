#script: settings.gd

extends Node

const SAVE_PATH = "res://config.cfg"
const ARROW_KEYS = {"clap_right": KEY_RIGHT, "clap_left": KEY_LEFT, 
		"clap_up": KEY_UP, "clap_down": KEY_DOWN, "clap_use": KEY_ENTER}

var audio setget audio_set, audio_get
var keys

var _config_file = ConfigFile.new()
var _settings

func _ready():
	init_settings()
	load_settings()

func init_settings():
	audio = true
	keys = {"clap_right": KEY_X, "clap_left": KEY_Z, "clap_up": KEY_APOSTROPHE, 
			"clap_down": KEY_SLASH, "clap_use": KEY_ENTER}
	
	_settings = {"audio":{"audio": audio}, "keys": keys}

func save_settings():
	for section in _settings.keys():
		for key in _settings[section].keys():
			_config_file.set_value(section, key, _settings[section][key])
	
	_config_file.save(SAVE_PATH)

func load_settings():
	var error = _config_file.load(SAVE_PATH)
	
	if error != OK:
		print("Error loading config.cfg file: %s" % error)
		return
	
	for section in _settings.keys():
		for key in _settings[section].keys():
			_settings[section][key] = _config_file.get_value(section, key, null)
	
	audio = _settings["audio"]["audio"]
	keys = _settings["keys"]
	
	erase_key_events(keys)
	add_key_events(keys)
	add_key_events(ARROW_KEYS)

func erase_key_events(keys):
	for action in keys:
		for old_event in InputMap.get_action_list(action):
			if old_event is InputEventKey:
				InputMap.action_erase_event(action, old_event)

func add_key_events(keys):
	# User-defined key definitions
	var scancode
	var event

	for action in keys:
		# Get the key scancode
		scancode = keys[action]
		
		# Create a new event object based on the saved scancode
		event = InputEventKey.new()
		event.scancode = scancode
		
		# Add the event object to the input map action
		InputMap.action_add_event(action, event)

func audio_set(value):
	audio = value
	_settings["audio"]["audio"] = value
	save_settings()

func audio_get():
	return audio