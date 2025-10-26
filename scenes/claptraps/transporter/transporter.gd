class_name Transporter
extends Thing


func _ready() -> void:
	game_object = 7
	game_object_name = "Transporter"
	solid = false
	needs_target = true
	squash = true


func hit(hitby: Thing) -> void:
	transport(hitby, self, grid_pos)

	# Keep this part in for regenerating transporters
	create("Transporter", Direction.STILL, grid_pos, target)
