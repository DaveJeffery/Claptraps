class_name Game_Data
extends RefCounted

var level_map: Array[Array]
var dave_pos: Array[Vector2i]
var level_size: Array[Vector2i]
var minimum_score: Array[int]
var def_file: String
		
func _init() -> void:
	# The level_map data structure: level_map[x][y] = [gobject(, target)]
	level_map = [[]]  # create outer array first
	for j in range(LevelSet.LEVEL_SIZE.x):
		var row: Array = []
		for i in range(LevelSet.LEVEL_SIZE.y):
			row.append(LevelSet.MAP_CONTENT)
		level_map[0].append(row)
		
	dave_pos = [Vector2i(0,0)]
	level_size = [Vector2i(16, 12)]
	minimum_score = [0]
	def_file = ""
