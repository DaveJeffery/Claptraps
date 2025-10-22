class_name ButtonOn
extends Thing

func _ready() -> void:
	game_object = 11
	$AnimatedSprite2D.animation = "default"
	needs_target = true
	target = Vector2i.ZERO
	initialise = true
	break_box = true


func action() -> void:
	if initialise:
		initialise = false
		if look(0, target).name == "Gate":
			$AnimatedSprite2D.animation = "on"
		else:
			$AnimatedSprite2D.animation = "off"
			
	if (
		look(game_state.NORTH, grid_pos).trigger_button 
		or look(game_state.SOUTH, grid_pos).trigger_button 
		or look(game_state.EAST, grid_pos).trigger_button 
		or look(game_state.WEST, grid_pos).trigger_button
	):
		if (
			(look(0, target).empty and not look(0, target).is_dave) 
			or look(0, target).name == "Laser"
		):
			create("Gate", 0, target)
			$AnimatedSprite2D.animation = "on"
	elif look(0, target).name == "Gate":
		create("Blank", 0, target)
		$AnimatedSprite2D.animation = "off"
