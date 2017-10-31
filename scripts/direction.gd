#script: direction.gd

extends Node

const NORTH = Vector2(0, 1)
const SOUTH = Vector2(0, -1)
const EAST = Vector2(1, 0)
const WEST = Vector2(-1, 0)

const NE = NORTH + EAST
const NW = NORTH + WEST
const SW = SOUTH + WEST
const SE = EAST + WEST

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass
