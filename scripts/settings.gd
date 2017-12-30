#script: settings.gd

extends Node

const SAVE_PATH = "res://config.cfg"

var audio setget audio_set, audio_get
var keys

var _config_file = ConfigFile.new()
var _settings

func _ready():
	init_settings()
	load_settings()

func init_settings():
	audio = true
	keys = {"KEY_RIGHT": KEY_X, "KEY_LEFT": KEY_Z, "KEY_UP": KEY_APOSTROPHE, 
			"KEY_DOWN": KEY_SLASH, "KEY_USE": KEY_ENTER}
	
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

func audio_set(value):
	audio = value
	_settings["audio"]["audio"] = value
	save_settings()

func audio_get():
	return audio