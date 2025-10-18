#script game.gd
extends Node
## Handles playing the built-in levelsets.
##
## The scene handles the user selecting and playing one of the
## built in level sets, including losing lives, game over or
## game completion screen.

var game_state:GameState

func _init() -> void:
	game_state = GameState.new()
	
	game_state.score = 0
	game_state.min_score_hit = false
	game_state.level_finished = false
	
	
