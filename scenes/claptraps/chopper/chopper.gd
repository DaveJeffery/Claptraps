class_name  Chopper
extends Thing


func _ready() -> void:
	game_object = 6
	game_object_name = "Chopper"
	h_push = true
	v_push = true
	move_speed = 1


func hit(hitby: Thing) -> void:
	if hitby.is_dave and game_state.min_score_hit:
		game_state.level_finished = true


func action() -> void:
	if game_state.min_score_hit:        
		solid = false
