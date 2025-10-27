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


func show_intro_screen() -> void:
	$IntroScreen.init(intro_text)
	$IntroScreen.show()

	if game_state.play_music:
		$TwiddlePlayer.play()

	$IntroScreen.set_process_input(true)
	await $IntroScreen.intro
	
	$IntroScreen.set_process_input(false)
	$IntroScreen.hide()


func show_status_screen() -> void:
	pass
	#
	#
	#if status_screen() == False:
		#break
