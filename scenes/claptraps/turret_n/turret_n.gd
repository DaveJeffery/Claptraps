class_name TurretN
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
	game_object = 15
	game_object_name = "Turret_N"


func action() -> void:
	if look(game_state.NORTH, grid_pos).name not in SOLID_TO_TURRET:
		create("Laser", game_state.NORTH, grid_pos)
		look(game_state.NORTH, grid_pos).forward = game_state.NORTH
