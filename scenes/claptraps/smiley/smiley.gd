class_name Smiley
extends Thing

const smiley_squash: = [
	"Frog",
	"Startled_Frog",
	"Red_Frog",
	"Angry_Red_Frog",
	"Transporter",
	"Laser",
	]

func _ready() -> void:
	game_object = 2
	game_object_name = "Smiley"
	sprite = 2
	h_push = true
	v_push = true
	move_speed = 2
	trigger_button = true
	break_box = true
		
func action() -> void:
	if moving == Direction.STILL and moved == Direction.STILL:
		startle_frog = false
	else:
		startle_frog = true

	var target_cell := look(moved, grid_pos)

	if moved != Direction.STILL:
		if (
			target_cell.empty 
			or target_cell.name in smiley_squash
		):
			move(moved, self, grid_pos)
			
		if target_cell.game_object_name == "Box":
			create("CalmFrog", moved, grid_pos)
