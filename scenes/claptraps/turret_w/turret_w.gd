class_name TurretW
extends Thing

const SOLID_TO_TURRET := [
		"Wall", 
		"Smiley", 
		"Gate", 
		"Laser", 
		"Lock", 
		"Turret_N", 
		"Turret_S", 
		"Turret_E", 
		"Turret_W"
	]


func _ready() -> void:
	game_object = 18
	game_object_name = "Turret_W"


func action() -> void:
	if look(game_state.WEST, grid_pos).name not in SOLID_TO_TURRET:
		create("Laser", game_state.WEST, grid_pos)
		look(game_state.WEST, grid_pos).forward = game_state.WEST
