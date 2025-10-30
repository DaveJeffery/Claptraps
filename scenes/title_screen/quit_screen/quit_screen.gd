#script: quit_screen.gd

extends ColorRect

signal quit_requested(retry: bool)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("clap_yes"):
		emit_signal("quit_requested", true)
	elif event.is_action_pressed("clap_no"):
		emit_signal("quit_requested", false)
	
	get_viewport().set_input_as_handled()
	hide()
