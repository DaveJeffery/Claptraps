#script game.gd
extends Node

var game_state:GameState

func _init() -> void:
	game_state = GameState.new()
	
	game_state.score = 0
	game_state.min_score_hit = false
	game_state.level_finished = false
	
	
