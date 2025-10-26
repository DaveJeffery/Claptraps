class_name TurretW
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
	game_object = 18
	game_object_name = "TurretW"


func action() -> void:
	if look(Direction.WEST, grid_pos).name not in SOLID_TO_TURRET:
		create("Laser", Direction.WEST, grid_pos)
		look(Direction.WEST, grid_pos).forward = Direction.WEST
