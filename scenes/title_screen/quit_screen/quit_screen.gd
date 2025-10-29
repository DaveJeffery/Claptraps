#script: retry_screen.gd

extends ColorRect

signal retry_asked(retry: bool)


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("clap_yes"):
		emit_signal("retry_asked", true)
	elif event.is_action_pressed("clap_no"):
		emit_signal("retry_asked", false)
	
	get_viewport().set_input_as_handled()
	hide()
