class_name Dave
extends Thing

func _ready() -> void:
	game_object = 0
	is_dave = true
	game_object_name = "Dave"
	startle_frog = true
	trigger_button = true
	solid_to_red_frog = false

# Dave action function called once per loop, 
# so you can put goal checks and things in here
func action() -> void:
	if game_state.min_score_hit:
		game_state.message = "EPISODE_COMPLETE"
			
		# Fade background to orange
		if game_state.bg_col.r8 < 255:
			game_state.bg_col.r8 += 2
		if game_state.bg_col.g8 < 220:
			game_state.bg_col.g8 += 2
		if game_state.bg_col.b8 > 150:
			game_state.bg_col.b8 -= 2
