#script game.gd
extends Node
## Handles playing the built-in levelsets.
##
## The scene handles the user selecting and playing one of the
## built in level sets, including losing lives, game over or
## game completion screen.

var episode_data: EpisodeData
var game_objects: Array[String]
var game_state: GameState
var game_filename: String
var intro_text: Array[String]
var outro_text: Array[String]

var escape_pressed:bool 

func _init() -> void:
	game_state = GameState.new()
	
	game_state.score = 0
	game_state.min_score_hit = false
	game_state.level_finished = false


func _ready() -> void:
	await select_episode()
	
	if game_filename.is_empty():
		_go_to_title_screen()
		return

	load_episode()
	load_definitions()
	update_game_state()
	
	await show_intro_screen()
	await show_status_screen()
	
	# GAME LOOP
	game_loop()
	
	
func select_episode() -> void:
	# This shows the select episode screen and waits for a keypress
	$SelectEpisode.show()
	var episode_metadata:EpisodeMetadata = await $SelectEpisode.episode
	
	# This handles ESCAPE being pressed on the select episode screen
	game_filename = episode_metadata.game_filename
	if game_filename.is_empty():
		return
	
	# This handles a number key being pressed on the select episode screen
	intro_text = episode_metadata.intro_text
	outro_text = episode_metadata.outro_text
	game_state.message = game_state.default_message


func load_episode() -> void:
	episode_data = load(game_filename)


func load_definitions() -> void:
	# FIXME Temporary until we can sort this out
	game_objects = Claptraps.game_objects


func update_game_state() -> void:
	game_state.lives = 3
	game_state.score = 0
	game_state.level_number = 0
	game_state.minimum_score = _minimum_score()


func show_intro_screen() -> void:
	$IntroScreen.init(intro_text)
	$IntroScreen.show()

	if game_state.play_music:
		$TwiddlePlayer.play()

	$IntroScreen.set_process_input(true)
	escape_pressed = await $IntroScreen.escape_pressed
	if escape_pressed:
		call_deferred("_go_to_title_screen")	
	
	$IntroScreen.set_process_input(false)
	$IntroScreen.hide()


func show_status_screen() -> void:
	$StatusScreen.init(game_state)
	$StatusScreen.show()
	
	$StatusScreen.set_process_input(true)
	escape_pressed = await $StatusScreen.escape_pressed
	if escape_pressed:
		call_deferred("_go_to_title_screen")
		
	$StatusScreen.set_process_input(false)
	$StatusScreen.hide()


func game_loop() -> void:
	while true:
		## Play music
		if game_state.play_music:
			$GameTunePlayer.play()
		
		## $PlayLevel plays a single level, returning true or false
		var is_completed:bool
		is_completed = await $PlayLevel.completed
		
		## Stop music        
		$GameTunePlayer.stop()
		
		if not is_completed:
			## Lost all ives without completing level, 
			## so show Retry screen
			var retry:bool
			retry = await $RetryScreen.retry_asked
			if retry:
				game_state.lives = 3
				game_state.score = 0
				game_state.message = game_state.default_message
			else:
				_go_to_title_screen()

			## Show the status screen
			await show_status_screen()
			
		else:
			## Add 1 to level number, reset the score
			game_state.level_number += 1
			game_state.score = 0
			
			## If you have completed all of the levels, show outro screen
			var num_of_levels:int = episode_data.levels.size()
			
			if game_state.level_number > num_of_levels:
				await show_intro_screen()

			## Draw the level complete screen
			await level_complete_screen()
			
			## Show the status screen. If you press escape, go to title screen
			await show_status_screen()


func show_outro_screen() -> void:
	$OutroScreen.init(outro_text)
	$OutroScreen.show()

	$OutroScreen.set_process_input(true)
	escape_pressed = await $OutroScreen.escape_pressed
	if escape_pressed:
		call_deferred("_go_to_title_screen")	
	
	$OutroScreen.set_process_input(false)
	$OutroScreen.hide()


func level_complete_screen() -> void:
	$CompleteScreen.init(game_state)
	$CompleteScreen.show()
	$CompleteScreen.set_process_input(true)
	
	if game_state.play_music:
		$TwiddlePlayer.play()
	
	escape_pressed = await $CompleteScreen.escape_pressed
	if escape_pressed:
		call_deferred("_go_to_title_screen")
		
	$CompleteScreen.set_process_input(false)
	$CompleteScreen.hide()


func _minimum_score() -> int:
	return episode_data.levels[game_state.level_number].minimum_score


func _go_to_title_screen() -> void:
	get_tree().change_scene_to_file(
		"res://scenes/title_screen/title_screen.tscn"
	)
