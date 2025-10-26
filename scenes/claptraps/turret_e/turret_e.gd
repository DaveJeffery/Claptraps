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
		"TurretN", 
		"TurretS", 
		"TurretE", 
		"TurretW"
	]


func _ready() -> void:
	game_object = 16
	game_object_name = "TurretE"


func action() -> void:
	if look(Direction.EAST, grid_pos).name not in SOLID_TO_TURRET:
		create("Laser", Direction.EAST, grid_pos)
		look(Direction.EAST, grid_pos).forward = Direction.EAST
