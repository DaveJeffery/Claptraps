class_name TurretS
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
	game_object = 17
	game_object_name = "TurretS"


func action() -> void:
	if look(Direction.SOUTH, grid_pos).name not in SOLID_TO_TURRET:
		create("Laser", Direction.SOUTH, grid_pos)
		look(Direction.SOUTH, grid_pos).forward = Direction.SOUTH
