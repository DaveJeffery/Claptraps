#script game.gd
extends Node
## Handles playing the built-in levelsets.
##
## The scene handles the user selecting and playing one of the
## built in level sets, including losing lives, game over or
## game completion screen.

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
	$SelectEpisode.set_process_input(true)
	$SelectEpisode.show()


func _on_select_episode_episode(
	filename: String, 
	intro: Array[String], 
	outro: Array[String]
) -> void:
	game_filename = filename
	intro_text = intro
	outro_text = outro
