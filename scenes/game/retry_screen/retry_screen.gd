#script: quit_screen.gd

extends ColorRect

func _ready() -> void:
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("clap_yes"):
		get_tree().quit()
	elif event.is_action_pressed("clap_no"):
		get_viewport().set_input_as_handled()
		hide()
