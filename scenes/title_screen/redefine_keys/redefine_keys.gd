extends ColorRect

signal key_pressed

@onready var label := $CenterContainer/Label
@onready var action_names: Array = Settings.keys.keys()

var key_names := [
	tr("KEY_RIGHT"), 
	tr("KEY_LEFT"), 
	tr("KEY_UP"), 
	tr("KEY_DOWN"), 
	tr("KEY_USE")
]
		
var arrows := [
	KEY_LEFT, 
	KEY_RIGHT, 
	KEY_UP, 
	KEY_DOWN
]

func _ready() -> void:
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _unhandled_input(event: InputEvent) -> void:
	if (
		event is InputEventKey and event.is_pressed() 
		and not event.is_echo()
	):
		emit_signal("key_pressed", event.keycode)

func define_keys() -> void:
	var i := 0
	var keycode: Key
	var selection := []
	
	while(i < key_names.size()):
		label.text = tr("KEY_SET") + key_names[i]
		keycode = await self.key_pressed
		
		# Check key is not a duplicate or arrow key
		if (not keycode in arrows) and (not keycode in selection):
			selection.append(keycode)
			Settings.keys[action_names[i]] = keycode
			i += 1
	
	Settings.update_key_events()
	Settings.save_settings()
	hide()
