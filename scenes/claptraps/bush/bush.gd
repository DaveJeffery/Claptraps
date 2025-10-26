class_name Bush
extends Thing

func _ready() -> void:
	game_object = 22
	game_object_name = "Bush"


func action() -> void:
	if (
		not game_state.player_moving == 0 
		and (
			look(game_state.NORTH, grid_pos).is_dave 
			or look(game_state.SOUTH, grid_pos).is_dave 
			or look(game_state.WEST, grid_pos).is_dave 
			or look(game_state.EAST, grid_pos).is_dave)
		and game_state.use_key
	):
		create("Blank", Direction.STILL, grid_pos)
