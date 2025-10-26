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
	if forward == game_state.NORTH:
		if (
			# If there is either a north facing turret
			# or a North facing laser below it...
			look(game_state.SOUTH, grid_pos).name == "Turret_N" 
			or (
					look(game_state.SOUTH, grid_pos).name == "Laser" 
					and look(game_state.SOUTH, grid_pos).forward == game_state.NORTH
				)
		):
			# ...if the tile above it isn't solid to lasers...
			if look(game_state.NORTH, grid_pos).name not in SOLID_TO_LASER:
				# ...create a north facing laser there.
				create("Laser", game_state.NORTH, grid_pos)
				look(game_state.NORTH, grid_pos).forward = game_state.NORTH
		else:
			# If there is neither a north facing turret
			# nor a North facing laser below it 
			# replace the laser with a blank
			create("Blank", Direction.STILL, grid_pos)
		return
	elif self.forward == game_state.EAST:
		ignore = true
		if (
			look(game_state.WEST, grid_pos).name == "Turret_E" 
			or (
				look(game_state.WEST, grid_pos).name == "Laser" 
				and look(game_state.WEST, grid_pos).forward == game_state.EAST
			)
		):
			if look(game_state.EAST, grid_pos).name not in SOLID_TO_LASER:
				create("Laser", game_state.EAST, grid_pos)
				look(game_state.EAST, grid_pos).forward = game_state.EAST
				#TODO look(game_state.EAST, grid_pos).$AnimatedSprite2D.animation = "horiz"
				look(game_state.EAST, grid_pos).ignore = true
		else:
			create("Blank", Direction.STILL, grid_pos)
	elif self.forward == game_state.SOUTH:
		ignore = true
		if (
			look(game_state.NORTH, grid_pos).name == "Turret_S" 
			or (
				look(game_state.NORTH, grid_pos).name == "Laser" 
				and look(game_state.NORTH, grid_pos).forward == game_state.SOUTH
			)
		):
			if look(game_state.SOUTH, grid_pos).name not in SOLID_TO_LASER:
				create("Laser", game_state.SOUTH, grid_pos)
				look(game_state.SOUTH, grid_pos).forward = game_state.SOUTH
				look(game_state.SOUTH, grid_pos).ignore = true
		else:
			create("Blank", Direction.STILL, grid_pos)

	elif self.forward == game_state.WEST:
		if (
			look(game_state.EAST, grid_pos).name == "Turret_W" 
			or (
				look(game_state.EAST, grid_pos).name == "Laser" 
				and look(game_state.EAST, grid_pos).forward == game_state.WEST
			)
		):
			if look(game_state.WEST, grid_pos).name not in SOLID_TO_LASER:
				create("Laser", game_state.WEST, grid_pos)
				look(game_state.WEST, grid_pos).forward = game_state.WEST
				#TODO look(game_state.WEST, grid_pos).$AnimatedSprite2D.animation = "horiz"
		else:
			create("Blank", Direction.STILL, grid_pos)
