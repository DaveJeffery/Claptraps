#script: level_set.gd
class_name LevelSet
extends Node

# Default values for game data
const POSITION := Vector2i.ZERO			# Default position for Dave
const LEVEL_SIZE := Vector2i(16, 12)	# Default level size
const MIN_SCORE := 0					# Default minimum score
const MAP_CONTENT = [0, 0]				# Default map square content [Object, Target (optional)]

var minimum_score: Array
var level_size: Array      
var dave_pos: Array
var map: Array

func _ready() -> void:
	# Called every time the node is added to the scene.
	
	# Arrays that store data for each map in current set
	map = [create_map(LEVEL_SIZE)]
	dave_pos = [POSITION]
	level_size = [LEVEL_SIZE]
	minimum_score = [MIN_SCORE]

func create_map(size: Vector2i) -> Array:
	# Creates a blank map of size
	var blank_map := []
	
	for x in range(size.x):
		# We have to append a *different* col each time
		var col := []
		col.resize(size.y)
		blank_map.append(col)

	return blank_map
