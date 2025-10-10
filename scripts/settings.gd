#script: settings.gd

extends Node

const SAVE_PATH := "res://config.cfg"
const ARROW_KEYS := {"clap_right": KEY_RIGHT, "clap_left": KEY_LEFT, 
		"clap_up": KEY_UP, "clap_down": KEY_DOWN, "clap_use": KEY_ENTER}

var audio: bool: 
	get = audio_get, set = audio_set
var keys := {}

var _config_file := ConfigFile.new()
var _settings := {}

func _ready() -> void:
	init_settings()
	load_settings()

func init_settings() -> void:
	keys = {"clap_right": KEY_X, "clap_left": KEY_Z, "clap_up": KEY_APOSTROPHE, 
			"clap_down": KEY_SLASH, "clap_use": KEY_ENTER}
	
	_settings = {"audio":{}, "keys": keys}
	audio = true

func save_settings() -> void:
	for section in _settings.keys():
		for key in _settings[section].keys():
			_config_file.set_value(section, key, _settings[section][key])
	
	_config_file.save(SAVE_PATH)

func load_settings():
	var error := _config_file.load(SAVE_PATH)
	
	if error != OK:
		print("Error loading config.cfg file: %s" % error)
		return
	
	for section in _settings.keys():
		for key in _settings[section].keys():
			_settings[section][key] = _config_file.get_value(section, key, null)
	
	audio = _settings["audio"]["audio"]
	keys = _settings["keys"]
	
	update_key_events()

func update_key_events():
	# It's best to erase old key events before adding new ones
	erase_key_events(keys)
	add_key_events(keys)
	add_key_events(ARROW_KEYS)

func erase_key_events(keymap: Dictionary) -> void:
	for action in keymap:
		for old_event in InputMap.action_get_events(action):
			if old_event is InputEventKey:
				InputMap.action_erase_event(action, old_event)

func add_key_events(keymap: Dictionary) -> void:
	# User-defined key definitions
	var keycode: Key
	var event: InputEventKey

	for action in keymap:
		# Get the key scancode
		keycode = keymap[action]
		
		# Create a new event object based on the saved scancode
		event = InputEventKey.new()
		event.keycode = keycode
		
		# Add the event object to the input map action
		InputMap.action_add_event(action, event)

func audio_set(value: bool) -> void:
	audio = value
	_settings["audio"]["audio"] = value
	save_settings()

func audio_get() -> bool:
	return audio
