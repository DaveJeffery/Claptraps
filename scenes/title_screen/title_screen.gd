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
	set_process_input(true)
	$QuitScreen.set_process_input(false)
	$QuitScreen.hide()
	$MenuTimer.start()
	if Settings.audio:
		$AudioStreamPlayer.play()


func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select"):
		get_tree().change_scene_to_file(
			"res://scenes/game/game.tscn"
		)
	elif event.is_action_pressed("ui_cancel"):
		$QuitScreen.show()
	elif event.is_action_pressed("clap_music"):
		toggle_music()
	elif event.is_action_pressed("clap_redefine"):
		$RedefineScreen.show()
		set_process_input(false)
	elif event.is_action_pressed("clap_userdef"):
		print_debug("User Levels!")
	elif event.is_action_pressed("clap_editor"):
		get_tree().change_scene_to_file("res://scenes/editor_scene.tscn") #BUG

 
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


func _on_QuitScreen_draw() -> void:
	# Pauses TitleScreen audio and menu when QuitScreen shown
	set_process_input(false)
	audio_position = $AudioStreamPlayer.get_playback_position()
	$AudioStreamPlayer.stop()
	
	# Allow quit screen to receive keypresses
	$QuitScreen.set_process_input(true)


func _on_RedefineScreen_draw() -> void:
	$RedefineScreen.define_keys()


func _on_redefine_screen_hidden() -> void:
	set_process_input(true)


func _on_quit_screen_hidden() -> void:
	# Stop QuitScreen from to receiving keypresses
	$QuitScreen.set_process_input(false)
	
	# Resume TitleScreen audio and menu
	set_process_input(true)
	if Settings.audio:
		$AudioStreamPlayer.play(audio_position)
