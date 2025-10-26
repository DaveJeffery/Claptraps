class_name Laser
extends Thing

const SOLID_TO_LASER := [
	"Wall", 
	"Smiley", 
	"Gate", 
	"Laser", 
	"Lock", 
	"Turret_N", 
	"Turret_S", 
	"Turret_E", 
	"Turret_W",
]


func _ready() -> void:
	game_object = 19
	game_object_name = "Laser"
	$AnimatedSprite2D.animation = "default"
	squash = true
	solid = false


func hit(hitby: Thing) -> void:
	if hitby.is_dave:
		game_state.kill_dave = true


func action() -> void:
	# If this is a north facing laser...
	if moving == game_state.NORTH:
		if (
			# If there is either a north facing turret
			# or a North facing laser below it...
			look(Direction.SOUTH, grid_pos).name == "TurretN" 
			or (
					look(Direction.SOUTH, grid_pos).name == "Laser" 
					and look(Direction.SOUTH, grid_pos).moving == Direction.NORTH
				)
		):
			# ...if the tile above it isn't solid to lasers...
			if look(Direction.NORTH, grid_pos).name not in SOLID_TO_LASER:
				# ...create a north facing laser there.
				create("Laser", Direction.NORTH, grid_pos)
		else:
			# If there is neither a north facing turret
			# nor a North facing laser below it 
			# replace the laser with a blank
			create("Blank", Direction.STILL, grid_pos)
		return
	elif self.forward == game_state.EAST:
		ignore = true
		if (
			look(Direction.WEST, grid_pos).name == "TurretE" 
			or (
				look(Direction.WEST, grid_pos).name == "Laser" 
				and look(Direction.WEST, grid_pos).forward == Direction.EAST
			)
		):
			if look(Direction.EAST, grid_pos).name not in SOLID_TO_LASER:
				create("Laser", Direction.EAST, grid_pos)
				look(Direction.EAST, grid_pos).get_node("AnimatedSprite2D").animation = "horiz"
				look(Direction.EAST, grid_pos).ignore = true
		else:
			create("Blank", Direction.STILL, grid_pos)
	elif self.forward == game_state.SOUTH:
		ignore = true
		if (
			look(Direction.NORTH, grid_pos).name == "TurretS" 
			or (
				look(Direction.NORTH, grid_pos).name == "Laser" 
				and look(Direction.NORTH, grid_pos).forward == Direction.SOUTH
			)
		):
			if look(Direction.SOUTH, grid_pos).name not in SOLID_TO_LASER:
				create("Laser", Direction.SOUTH, grid_pos)
				look(Direction.SOUTH, grid_pos).ignore = true
		else:
			create("Blank", Direction.STILL, grid_pos)

	elif self.forward == game_state.WEST:
		if (
			look(Direction.EAST, grid_pos).name == "TurretW" 
			or (
				look(Direction.EAST, grid_pos).name == "Laser" 
				and look(Direction.EAST, grid_pos).forward == Direction.WEST
			)
		):
			if look(Direction.WEST, grid_pos).name not in SOLID_TO_LASER:
				create("Laser", game_state.WEST, grid_pos)
				look(Direction.WEST, grid_pos).get_node("AnimatedSprite2D").animation = "horiz"
		else:
			create("Blank", Direction.STILL, grid_pos)
