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


func hit(hitby: Thing) -> void:
	if hitby.is_dave:
		game_state.score +=1


func action() -> void:
	if look(left, grid_pos).empty:
		move(left, self, grid_pos)
	elif look(forward, grid_pos).empty:
		move(forward, self, grid_pos)
	elif look(right, grid_pos).empty:
		move(right, self, grid_pos)
	elif look(backward, grid_pos).empty:
		move(backward, self, grid_pos)

	if self.forward == game_state.NORTH:
		$AnimatedSprite2D.animation = "north"
	elif self.forward == game_state.EAST:
		$AnimatedSprite2D.animation = "east"
	elif self.forward == game_state.SOUTH:
		$AnimatedSprite2D.animation = "south"
	elif self.forward == game_state.WEST:
		$AnimatedSprite2D.animation = "west"


func check_squash(obj) -> bool:
	if obj.name in ["Box", "Chopper", "Key"]:
		return false
	else:
		return true
