class_name RedFrog
extends Thing

func _ready() -> void:
	game_object_name = "Red_Frog"
	game_object = 9
	#TODO self.sprite = 17
	solid = false
	squash = true

func action() -> void:
	if (
		look(game_state.NORTH, grid_pos).startle_frog 
		or look(game_state.SOUTH, grid_pos).startle_frog 
		or look(game_state.EAST, grid_pos).startle_frog 
		or look(game_state.WEST, grid_pos).startle_frog
	):
		create("Angry_Red_Frog", 0, grid_pos)

func check_squash(obj: Thing) -> bool:
	if obj.name in ["Box", "Chopper", "Key"]:
		return false
	else:
		return true
