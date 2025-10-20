@tool
extends EditorScript
## One-off Editor script to convert a JSON level into a LevelData .tres resource.
## The JSON files are created from the original pickled Python files using
## convert.py

func _run() -> void:
	var json_path := "res://levels/doodles.json"
	var tres_path := "res://levels/doodles.tres"

	# File checks
	if not FileAccess.file_exists(json_path):
		printerr("JSON file not found:", json_path)
		return

	# Read JSON
	var file = FileAccess.open(json_path, FileAccess.READ)
	if file == null:
		printerr("Can't open ", json_path)
		return
	var json_text := file.get_as_text()
	file.close()

	# Parse JSON. JSON.parse_string returns a Dictionary in this context.
	var parse_result = JSON.parse_string(json_text)

	var episode_data:Episode = Episode.new()

	# Fill resource fields
	episode_data.def_file = parse_result.get("def_file")
	
	var level_maps = parse_result.get("level_map")
	var level_size = parse_result.get("level_size")
	var dave_pos = parse_result.get("dave_pos")
	var minimum_score = parse_result.get("minimum_score")
	var level_number:int = level_maps.size()

	for level in range(level_number):
		var level_data:LevelData = LevelData.new()
		
		## Add stuff to the levels
		var map_size:Array = level_size[level]
		level_data.map_size = Vector2i(map_size[0], map_size[1])
		
		var dave_place:Array =  dave_pos[level]
		level_data.dave_pos = Vector2i(dave_place[0], dave_place[1])
		
		level_data.minimum_score = int(minimum_score[level])
		
		#TODO Now sort out the map data!
		var current_map:Array = level_maps[level]

		for col in range (map_size[0]):
			for row in range (map_size[1]):
				var map_element:MapElement = MapElement.new()
				var position:= Vector2i(col, row)
				var cell_content: Array = current_map[col][row]
				var tile: int = cell_content[0]
				var destination:Variant = cell_content[1]
				var dest: Vector2i
				if typeof(destination) == TYPE_FLOAT: 
					dest = Vector2i(-1, -1)
				else:
					dest = Vector2i(destination[0], destination[1])
				map_element.position = position
				map_element.tile = tile
				map_element.destination = dest
				
				level_data.map.append(map_element)
		
		episode_data.levels.append(level_data)

	#
	#var level_size = parse_result.get("level_size")
	#var vector_array: Array[Vector2i] = []
	#for a in level_size:
		#vector_array.append(Vector2i(int(a[0]), int(a[1])))
	#level_data.level_size = vector_array
	#

	
	var err = ResourceSaver.save(episode_data, tres_path)
	if err != OK:
		printerr("Failed to save resource: ", err)
	else:
		print("Saved ", tres_path)
