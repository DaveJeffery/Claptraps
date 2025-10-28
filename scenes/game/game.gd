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
	load_episode()
	load_definitions()
	update_game_state()
	
	await show_intro_screen()
	await show_status_screen()
	
	# GAME LOOP
	#start music
	#play level
	
	
func select_episode() -> void:
	$SelectEpisode.show()
	$SelectEpisode.set_process_input(true)
	
	var episode_metadata:EpisodeMetadata = await $SelectEpisode.episode
	
	if episode_metadata.game_filename == "":
		print_debug("null episode_metadata")
		call_deferred("_go_to_title_screen")
		$SelectEpisode.set_process_input(false)
		$SelectEpisode.hide()
		return
	
	game_filename = episode_metadata.game_filename
	intro_text = episode_metadata.intro_text
	outro_text = episode_metadata.outro_text
	game_state.message = game_state.default_message
	
	$SelectEpisode.set_process_input(false)
	$SelectEpisode.hide()


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


func _minimum_score() -> int:
	return episode_data.levels[game_state.level_number].minimum_score


func _go_to_title_screen() -> void:
	get_tree().change_scene_to_file(
		"res://scenes/title_screen/title_screen.tscn"
	)
