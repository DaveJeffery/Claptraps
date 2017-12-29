#script: level_set.gd

extends Node

# Default values for game data
const POSITION = Vector2(0, 0)		# Default position for Dave
const LEVEL_SIZE = Vector2(16, 12)	# Default level size
const MIN_SCORE = 0					# Default minimum score
const MAP_CONTENT = [0, 0]			# Default map square content [Object, Target (optional)]

var minimum_score 
var level_size      
var dave_pos
var map

func _ready():
	# Called every time the node is added to the scene.
	
	# Arrays that store data for each map in current set
	map = [create_map(LEVEL_SIZE)]
	dave_pos = [POSITION]
	level_size = [LEVEL_SIZE]
	minimum_score = [MIN_SCORE]

func create_map(size):
	# Creates a blank map of size
	var map = []
	
	for x in range(size.x):
		var col = []
		col.resize(size.y)
		map.append(col)

		return map