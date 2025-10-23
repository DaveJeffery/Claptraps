class_name TurretE
extends Thing

const SOLID_TO_TURRET := [
		"Wall",
		"Wall2",
		"Wall3",
		"Rock", 
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
	game_object = 16
	game_object_name = "Turret_E"


func action() -> void:
	if look(game_state.EAST, grid_pos).name not in SOLID_TO_TURRET:
		create("Laser", game_state.EAST, grid_pos)
		look(game_state.EAST, grid_pos).forward = game_state.EAST
