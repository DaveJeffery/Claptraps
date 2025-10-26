class_name AngryRedFrog
extends Thing


func _ready() -> void:
	game_object_name= "AngryRedFrog"
	game_object = 10
	$AnimatedSprite2D.animation = "south"
	solid = false
	squash = true
	move_speed = 1
	startle_frog = true
	trigger_button = true


func action() -> void:
	if (
		look(moving, grid_pos).name == "Apple" 
		and look(moving, grid_pos).being_moved_into == Direction.STILL
	):
		look(moving, grid_pos).eat()
		return
	if (
		look(moving.left, grid_pos).name == "Apple" 
		and look(moving.left, grid_pos).being_moved_into == Direction.STILL
	):
		look(moving.left, grid_pos).eat()
		return
	if (
		look(moving.backward, grid_pos).name == "Apple" 
		and look(moving.backward, grid_pos).being_moved_into == Direction.STILL
	):
		look(moving.backward, grid_pos).eat()
		return
	if (
		look(moving.right, grid_pos).name == "Apple" 
		and look(moving.right, grid_pos).being_moved_into == Direction.STILL
	):
		look(moving.right, grid_pos).eat()
		return

	if dave_is_to(Direction.NORTH, grid_pos):
		if (
			not look(Direction.NORTH, grid_pos).solid_to_red_frog 
			and look(Direction.NORTH, grid_pos).being_moved_into == Direction.STILL
		):
			move(Direction.NORTH, self, grid_pos)
			$AnimatedSprite2D.animation = "north"
	if dave_is_to(Direction.SOUTH, grid_pos):
		if (
			not look(Direction.SOUTH, grid_pos).solid_to_red_frog  
			and look(Direction.SOUTH, grid_pos).being_moved_into == Direction.STILL
		):
			move(Direction.SOUTH, self, grid_pos)
			$AnimatedSprite2D.animation = "south"
	if dave_is_to(Direction.EAST, grid_pos):
		if (
			not look(Direction.EAST, grid_pos).solid_to_red_frog
			and look(Direction.EAST, grid_pos).being_moved_into == Direction.STILL
		):
			move(Direction.EAST, self, grid_pos)
			$AnimatedSprite2D.animation = "east"
	if dave_is_to(Direction.WEST, grid_pos):
		if (
			not look(Direction.WEST, grid_pos).solid_to_red_frog
			and look(Direction.WEST, grid_pos).being_moved_into == Direction.STILL
		):
			move(Direction.WEST, self, grid_pos)
			$AnimatedSprite2D.animation = "west"

func hit(hitby: Thing):
	if hitby.is_dave:
		game_state.kill_dave = true

func check_squash(object: String) -> bool:
	if object in ["Box", "Chopper", "Key"]:
		return false
	else:
		return true
