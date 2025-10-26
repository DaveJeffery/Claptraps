class_name TurretN
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
		"TurretN", 
		"TurretS", 
		"TurretE", 
		"TurretW"
	]


func _ready() -> void:
	game_object = 15
	game_object_name = "TurretN"


func action() -> void:
	if look(Direction.NORTH, grid_pos).name not in SOLID_TO_TURRET:
		create("Laser", Direction.NORTH, grid_pos)
		look(Direction.NORTH, grid_pos).forward = Direction.NORTH
