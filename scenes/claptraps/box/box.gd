class_name Box
extends Thing


func _ready() -> void:
	self.gobject = 5
	self.name = "Box"
	self.sprite = 4
	self.h_push = true
	self.v_push = true
	self.move_speed = 1


func action() -> void:
	if moving != Direction.STILL or moved != Direction.STILL:
		startle_frog = true
	else:
		startle_frog = false

	if (
		self.moved == game_state.SOUTH 
		and look(game_state.SOUTH, grid_pos).break_box
	):
		create("Frog", Direction.STILL, grid_pos)

	if look(game_state.SOUTH, grid_pos).empty:
		move(game_state.SOUTH, self, grid_pos)
