#script: editor_scene.gd

extends Node

const GAME_LEVEL_LOCATION: String = "res://levels/"
const USER_LEVEL_LOCATION: String = "user://levels/"

var level_list: Array
var new_level_set: bool
var file_selected: String


func _ready() -> void:
	level_list = get_level_list(USER_LEVEL_LOCATION)

	if not level_list.size() == 0:
		$SelectLevelSet.show()
	else:
		new_level_set = true
		print("User levels directory empty!")


func get_level_list(level_location: String) -> Array:
	level_list = []
	var dir := DirAccess.open(level_location)

	if dir:
		dir.list_dir_begin()

		var file_name := dir.get_next()
		while file_name != "":
			# Skip "." and ".." (navigation entries) and hidden files
			if (
				not dir.current_is_dir() 
				and not file_name.begins_with(".")
			):
				level_list.append(file_name)

			file_name = dir.get_next()

		dir.list_dir_end()
	else:
		# Directory doesn’t exist — try to create it
		var make_error := DirAccess.make_dir_recursive_absolute(level_location)
		if make_error != OK:
			push_error("Error making levels directory at: %s" % level_location)

	return level_list


func _on_SelectLevelSet_hide() -> void:
	new_level_set = $SelectLevelSet.new_level_set
	file_selected = $SelectLevelSet.file_selected


func _on_SelectLevelSet_draw() -> void:
	$SelectLevelSet.init(level_list)
