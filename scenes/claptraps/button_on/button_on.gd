class_name ButtonOn
extends Thing

var initialise: bool

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
		if look(Direction.STILL, target).name == "Gate":
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
			(look(Direction.STILL, target).empty and not look(Direction.STILL, target).is_dave) 
			or look(Direction.STILL, target).name == "Laser"
		):
			create("Gate", Direction.STILL, target)
			$AnimatedSprite2D.animation = "on"
	elif look(Direction.STILL, target).name == "Gate":
		create("Blank", Direction.STILL, target)
		$AnimatedSprite2D.animation = "off"
