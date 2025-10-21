#script game.gd
extends Node
## Handles playing the built-in levelsets.
##
## The scene handles the user selecting and playing one of the
## built in level sets, including losing lives, game over or
## game completion screen.

var episode_data: EpisodeData
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
	#update game state
	
	#show intro screen + play twiddle
	
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
	
	$SelectEpisode.set_process_input(false)
	$SelectEpisode.hide()


func load_episode() -> void:
	episode_data = load(game_filename)


func load_definitions() -> void:
	pass
