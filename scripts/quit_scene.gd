#script: quit_scene.gd

extends ColorRect

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

func _input(event):
	if event.is_action_pressed("clap_yes"):
		get_tree().quit()
	elif event.is_action_pressed("clap_no"):
		get_tree().set_input_as_handled()
		hide()