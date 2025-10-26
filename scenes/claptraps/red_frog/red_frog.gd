class_name RedFrog
extends Thing

func _ready() -> void:
	game_object_name = "RedFrog"
	game_object = 9
	solid = false
	squash = true

func action() -> void:
	if (
		look(game_state.NORTH, grid_pos).startle_frog 
		or look(game_state.SOUTH, grid_pos).startle_frog 
		or look(game_state.EAST, grid_pos).startle_frog 
		or look(game_state.WEST, grid_pos).startle_frog
	):
		create("AngryRedFrog", Direction.STILL, grid_pos)

func check_squash(object: String) -> bool:
	if object in ["Box", "Chopper", "Key"]:
		return false
	else:
		return true
