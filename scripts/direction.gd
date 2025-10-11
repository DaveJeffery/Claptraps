#script: direction.gd

extends Node

# direction.gd
const NORTH := Vector2i.UP
const SOUTH := Vector2i.DOWN
const EAST  := Vector2i.RIGHT
const WEST  := Vector2i.LEFT
const NE := NORTH + EAST
const NW := NORTH + WEST
const SE := SOUTH + EAST
const SW := SOUTH + WEST

func _ready() -> void:
	# Called every time the node is added to the scene.
	# Initialization here
	pass
