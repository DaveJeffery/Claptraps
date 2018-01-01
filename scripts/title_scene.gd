#script: title_scene.gd

extends Node

var menu_items = ["MENU_USER", "MENU_EDITOR", "MENU_MUSIC", "MENU_REDEFINE", 
		"MENU_EXIT"]
var menu_counter = 0
var audio_position = 0.0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	$QuitScreen.set_process_input(false)
	$QuitScreen.hide()
	$MenuTimer.start()
	if Settings.audio:
		$AudioStreamPlayer.play()

func _input(event):
	if event.is_action_pressed("ui_select"):
		get_tree().set_input_as_handled()
		print("Space!")
	elif event.is_action_pressed("ui_cancel"):
		get_tree().set_input_as_handled()
		$QuitScreen.show()
	elif event.is_action_pressed("clap_music"):
		get_tree().set_input_as_handled()
		toggle_music()
	elif event.is_action_pressed("clap_redefine"):
		get_tree().set_input_as_handled()
		$RedefineScreen.show()

func toggle_music():
	if Settings.audio:
		$AudioStreamPlayer.stop()
		audio_position = 0.0
		Settings.audio = false
	else:
		$AudioStreamPlayer.play()
		Settings.audio = true

func _on_MenuTimer_timeout():
	# Called every second to update the text shown in the MenuLabel label
	menu_counter = (menu_counter + 1) % menu_items.size()
	$VBoxContainer/MenuContainer/MenuLabel.text = menu_items[menu_counter]

func _on_QuitScreen_hide():
	# Resumes audio and menu when QuitScreen hidden
	$QuitScreen.set_process_input(false)
	get_tree().set_pause(false)
	if Settings.audio:
		$AudioStreamPlayer.play(audio_position)

func _on_QuitScreen_draw():
	# Pauses audio and menu when QuitScreen shown
	audio_position = $AudioStreamPlayer.get_playback_position()
	$AudioStreamPlayer.stop()
	$QuitScreen.set_process_input(true)
	get_tree().set_pause(true)