extends ColorRect

onready var label = $CenterContainer/Label
onready var action_names = Settings.keys.keys()

var key_names = [tr("KEY_RIGHT"), tr("KEY_LEFT"), tr("KEY_UP"), 
		tr("KEY_DOWN"), tr("KEY_USE")]
var arrows = [KEY_LEFT, KEY_RIGHT, KEY_UP, KEY_DOWN]

signal key_pressed

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	define_keys()

func _unhandled_input(event):
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		emit_signal("key_pressed", event.scancode)

func define_keys():
	var i = 0
	var keycode
	var selection = []
	
	while(i < key_names.size()):
		label.text = tr("KEY_SET") + key_names[i]
		keycode = yield(self, "key_pressed")
		
		# Check key is not a duplicate or arrow key
		if (not keycode in arrows) and (not keycode in selection):
			selection.append(keycode)
			Settings.keys[action_names[i]] = keycode
			i += 1
	
	Settings.update_key_events()
	Settings.save_settings()
	hide()