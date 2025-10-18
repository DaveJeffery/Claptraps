#script: redefine_keys.gd
extends ColorRect

signal key_pressed

@onready var label := $CenterContainer/Label
@onready var action_names: Array = Settings.keys.keys()

var key_names := [
	tr("KEY_RIGHT"), 
	tr("KEY_LEFT"), 
	tr("KEY_UP"), 
	tr("KEY_DOWN"), 
	tr("KEY_USE"),
]
		
var arrows := [
	KEY_LEFT, 
	KEY_RIGHT, 
	KEY_UP, 
	KEY_DOWN,
]

func _ready() -> void:
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.is_pressed() and not event.is_echo():
		# Allow the user to cancel remapping with Escape by emitting a null
		if event.keycode == KEY_ESCAPE:
			emit_signal("key_pressed", null)
		else:
			emit_signal("key_pressed", event.keycode)

func define_keys() -> void:
	# Start remapping sequence. This function uses `await self.key_pressed`
	# to receive keycodes emitted from _unhandled_input.
	var i := 0
	var keycode
	var selection := []
	show()
	
	while (i < key_names.size()):
		label.text = tr("KEY_SET") + key_names[i]
		keycode = await self.key_pressed
		
		# Cancel requested (Escape) -> discard local selection, do not modify Settings
		if keycode == null:
			label.text = tr("KEY_CANCELLED")
			await get_tree().create_timer(1).timeout
			hide()
			return
		
		# Check key is not a duplicate or arrow key (validate against local selection only)
		if (not keycode in arrows) and (not keycode in selection):
			selection.append(keycode)
			i += 1
		else:
			# Visual feedback for invalid selection (duplicate or disallowed arrow)
			var prev: String = String(label.text)
			label.text = tr("KEY_INVALID")
			await get_tree().create_timer(1).timeout
			# restore prompt for the same key
			label.text = prev
			# continue to wait for a valid key for the same index
	
	# Only now commit all changes so partial state cannot be left behind
	for j in range(selection.size()):
		Settings.keys[action_names[j]] = selection[j]

	Settings.update_key_events()
	Settings.save_settings()
	hide()
