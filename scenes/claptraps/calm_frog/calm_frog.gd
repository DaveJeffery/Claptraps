class_name CalmFrog
extends Thing


func _ready() -> void:
	game_object = 3
	game_object_name = "CalmFrog"
	solid = false


func hit(hitby: Thing) -> void:
	if hitby.is_dave:
		game_state.score += 1


func action() -> void:
	if (
		look(game_state.NORTH, grid_pos).startle_frog 
		or look(game_state.SOUTH, grid_pos).startle_frog
		or look(game_state.EAST, grid_pos).startle_frog 
		or look(game_state.WEST, grid_pos).startle_frog
	):
		create("StartledFrog", Direction.STILL, grid_pos)


func check_squash(tile: String) -> bool:
	if tile in ["Box", "Chopper", "Key"]:
		return false
	else:
		return true
