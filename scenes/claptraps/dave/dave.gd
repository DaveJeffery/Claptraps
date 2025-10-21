class_name Dave
extends Thing

func _ready() -> void:
	game_object = 0
	is_dave = true
	game_object_name = 'Dave'
	startle_frog = true
	trigger_button = true
	solid_to_red_frog = false

# Dave action function called once per loop, 
# so you can put goal checks and things in here
func action() -> void:
	if game_state.min_score_hit:
		game_state.message = 'Get to the Chopper!'
		col_a, col_b, col_c = game_state.bg_col
		if game_state.bg_col[0] < 255:
			col_a += 2
			if col_a > 255:
				col_a = 255
		if game_state.bg_col[1] < 220:
			col_b += 2
			if col_b > 220:
				col_b = 220
		if game_state.bg_col[2] > 150:
			col_c -= 2
			if col_c < 150:
				col_c = 150
		game_state.bg_col = col_a, col_b, col_c
