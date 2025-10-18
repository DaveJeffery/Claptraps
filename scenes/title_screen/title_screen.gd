#script: title_screen.gd

extends Node

var menu_items := [
	tr("MENU_USER"),
	tr("MENU_EDITOR"), 
	tr("MENU_MUSIC"),
	tr("MENU_REDEFINE"),
	tr("MENU_EXIT")
]
	
var menu_counter := 0
var audio_position := 0.0


func _ready() -> void:
	# Called every time the node is added to the scene.
	# Initialization here
	$QuitScreen.set_process_input(false)
	$QuitScreen.hide()
	$MenuTimer.start()
	if Settings.audio:
		$AudioStreamPlayer.play()


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select"):
		get_viewport().set_input_as_handled()
		get_tree().change_scene_to_file("res://scenes/game_scene.tscn")
	elif event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		$QuitScreen.show()
	elif event.is_action_pressed("clap_music"):
		get_viewport().set_input_as_handled()
		toggle_music()
	elif event.is_action_pressed("clap_redefine"):
		get_viewport().set_input_as_handled()
		$RedefineScreen.show()
		set_process_input(false)
	elif event.is_action_pressed("clap_userdef"):
		get_viewport().set_input_as_handled()
		print("User Levels!")
	elif event.is_action_pressed("clap_editor"):
		get_viewport().set_input_as_handled()
		get_tree().change_scene_to_file("res://scenes/editor_scene.tscn")

 
func toggle_music() -> void:
	if Settings.audio:
		$AudioStreamPlayer.stop()
		audio_position = 0.0
		Settings.audio = false
	else:
		$AudioStreamPlayer.play()
		Settings.audio = true

func _on_MenuTimer_timeout() -> void:
	# Called every second to update the text shown in the MenuLabel label
	menu_counter = (menu_counter + 1) % menu_items.size()
	$VBoxContainer/MenuContainer/MenuLabel.text = menu_items[menu_counter]


func _on_QuitScreen_hide() -> void:
	# Resumes audio and menu when QuitScreen hidden
	$QuitScreen.set_process_input(false)
	get_tree().set_pause(false)
	if Settings.audio:
		$AudioStreamPlayer.play(audio_position)

func _on_QuitScreen_draw() -> void:
	# Pauses audio and menu when QuitScreen shown
	audio_position = $AudioStreamPlayer.get_playback_position()
	$AudioStreamPlayer.stop()
	$QuitScreen.set_process_input(true)
	get_tree().set_pause(true)


func _on_RedefineScreen_draw() -> void:
	$RedefineScreen.define_keys()


func _on_redefine_screen_hidden() -> void:
	set_process_input(true)
