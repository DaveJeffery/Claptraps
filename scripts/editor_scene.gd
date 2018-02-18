#script: editor_scene.gd

extends Node

const GAME_LEVEL_LOCATION = "res://levels/"
const USER_LEVEL_LOCATION = "user://levels/"

var level_list
var new_level_set
var file_selected

func _ready():
	level_list = get_level_list(USER_LEVEL_LOCATION)
	
	if not level_list.empty():
		$SelectLevelSet.show()
	else:
		new_level_set = true
		print("User levels directory empty!")

func get_level_list(level_location):
	var level_list = []
	var dir = Directory.new()
	
	if dir.open(level_location) == OK:	
		# Parameters skip navigational and hidden entries
		dir.list_dir_begin(true, true)
		
		var file_name = dir.get_next()
		while (file_name != ""):
			if not dir.current_is_dir():
				level_list.append(file_name)
			
			file_name = dir.get_next()
	else:
		var error = dir.make_dir(level_location)
		
		if error != OK:
			print("Error making levels directory at: %s" % level_location)
	
	return level_list

func _on_SelectLevelSet_hide():
	new_level_set = $SelectLevelSet.new_level_set
	file_selected = $SelectLevelSet.file_selected

func _on_SelectLevelSet_draw():
	$SelectLevelSet.init(level_list)
