class_name AngryRedFrog
extends Thing


func _ready() -> void:
	game_object_name= "Angry_Red_Frog"
	game_object = 10
	$AnimatedSprite2D.animation = "south"
	#TODO self.animation = [(17, 8), (18, 8)]
	solid = false
	squash = true
	move_speed = 1
	startle_frog = true
	trigger_button = true

func action() -> void:
	if (
		look(forward, grid_pos).name == "Apple" 
		and look(forward, grid_pos).being_moved_into == 0
	):
		look(forward, grid_pos).eat()
		return
	if (
		look(left, grid_pos).name == "Apple" 
		and look(left, grid_pos).being_moved_into == 0
	):
		look(left, grid_pos).eat()
		return
	if (
		look(backward, grid_pos).name == "Apple" 
		and look(backward, grid_pos).being_moved_into == 0
	):
		look(backward, grid_pos).eat()
		return
	if (
		look(right, grid_pos).name == "Apple" 
		and look(right, grid_pos).being_moved_into == 0
	):
		look(right, grid_pos).eat()
		return

	if dave_is_to(game_state.NORTH, grid_pos):
		if (
			not look(game_state.NORTH, grid_pos).solid_to_red_frog 
			and look(game_state.NORTH, grid_pos).being_moved_into == 0
		):
			move(game_state.NORTH, self, grid_pos)
			$AnimatedSprite2D.animation = "north"
	if dave_is_to(game_state.SOUTH, grid_pos):
		if (
			not look(game_state.SOUTH, grid_pos).solid_to_red_frog  
			and look(game_state.SOUTH, grid_pos).being_moved_into == 0
		):
			move(game_state.SOUTH, self, grid_pos)
			$AnimatedSprite2D.animation = "south"
	if dave_is_to(game_state.EAST, grid_pos):
		if (
			not look(game_state.EAST, grid_pos).solid_to_red_frog
			and look(game_state.EAST, grid_pos).being_moved_into == 0
		):
			move(game_state.EAST, self, grid_pos)
			$AnimatedSprite2D.animation = "east"
	if dave_is_to(game_state.WEST, grid_pos):
		if (
			not look(game_state.WEST, grid_pos).solid_to_red_frog
			and look(game_state.WEST, grid_pos).being_moved_into == 0
		):
			move(game_state.WEST, self, grid_pos)
			$AnimatedSprite2D.animation = "west"

func hit(hitby: Thing):
	if hitby.is_dave:
		game_state.kill_dave = true

func check_squash(obj: Thing) -> bool:
	if obj.name in ["Box", "Chopper", "Key"]:
		return false
	else:
		return true
