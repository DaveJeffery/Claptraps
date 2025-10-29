extends ColorRect

signal escape_pressed(escape_pressed: bool)


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select"):
		get_viewport().set_input_as_handled()
		emit_signal("escape_pressed", false)
	elif event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		emit_signal("escape_pressed", true)
