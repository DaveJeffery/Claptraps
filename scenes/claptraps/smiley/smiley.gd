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
	if moving > 0 or moved:
		startle_frog = true
	else:
		startle_frog = false

	if moved > 0:
		if (
			look(moved, grid_pos).empty 
			or look(moved, grid_pos).name in smiley_squash
		):
			move(moved, self, grid_pos)
			
		if look(moved, grid_pos).name == "Box":
			create("Frog", moved, grid_pos)
