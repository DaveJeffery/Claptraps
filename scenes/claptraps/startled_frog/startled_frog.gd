class_name StartledFrog
extends Thing

func _ready() -> void:
	game_object = 4
	game_object_name = "Startled_Frog"
	$AnimatedSprite2D.animation = "default"
	solid = false
	startle_frog = true
	trigger_button = true
	move_speed = 1
	moving = Direction.NORTH


func hit(hitby: Thing) -> void:
	if hitby.is_dave:
		game_state.score +=1


func action() -> void:
	
	if look(moving.left, grid_pos).empty:
		move(moving.left, self, grid_pos)
	elif look(moving, grid_pos).empty:
		move(moving, self, grid_pos)
	elif look(moving.right, grid_pos).empty:
		move(moving.right, self, grid_pos)
	elif look(moving.backward, grid_pos).empty:
		move(moving.backward, self, grid_pos)

	if moving == Direction.NORTH:
		$AnimatedSprite2D.animation = "north"
	elif moving == Direction.EAST:
		$AnimatedSprite2D.animation = "east"
	elif moving == Direction.SOUTH:
		$AnimatedSprite2D.animation = "south"
	elif moving == Direction.WEST:
		$AnimatedSprite2D.animation = "west"


func check_squash(object: String) -> bool:
	if object in ["Box", "Chopper", "Key"]:
		return false
	else:
		return true
