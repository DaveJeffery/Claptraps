# LevelLoader.gd
# Godot 4 GDScript. Loads a JSON level file and converts fields into the desired Godot types:
# - level_map -> Array (with numbers normalized to int)
# - def_file -> String
# - level_size -> Array[Vector2i]
# - dave_pos -> Array[Vector2i]
# - minimum score -> Array[int]
#
# Usage:
# var data = LevelLoader.load_level("res://levels/episode1.json")
# print(data.level_map, data.def_file, data.level_size, data.dave_pos, data.minimum_score)

extends Node
class_name LevelLoader

static func _read_json_file(path: String) -> Dictionary:
	var err := {}
	var file = FileAccess.open(path, FileAccess.ModeFlags.READ)
	if file == null:
		err.error = "Unable to open file: %s" % path
		return err
	var text := file.get_as_text()
	file.close()
	var parse_result = JSON.parse_string(text)
	if parse_result.error != OK:
		err.error = "JSON parse error: %s (line %d, col %d)" % [parse_result.error_string, parse_result.error_line, parse_result.error_column]
		return err
	return parse_result.result


static func _normalize_numbers(value):
	# Recursively convert numeric values to ints where appropriate, so your level_map
	# (and nested pairs) become integers rather than floats.
	match typeof(value):
		TYPE_ARRAY:
			var out := []
			for e in value:
				out.append(_normalize_numbers(e))
			return out
		TYPE_DICTIONARY:
			var out := {}
			for k in value.keys():
				out[k] = _normalize_numbers(value[k])
			return out
		TYPE_FLOAT:
			# JSON numbers can come in as floats; cast to int
			return int(value)
		TYPE_INT:
			return value
		_:
			return value


static func _to_vector2i_array(data) -> Array:
	# Accept either:
	# - an array of pairs: [[x,y],[x,y],...]
	# - a single pair: [x,y]
	# - an empty array -> returns []
	if typeof(data) != TYPE_ARRAY:
		return []
	if data.size() == 0:
		return []
	# If first element is an array and looks like a pair -> treat as list of pairs
	if typeof(data[0]) == TYPE_ARRAY and data[0].size() >= 2 and (_is_number(data[0][0]) and _is_number(data[0][1])):
		var out := []
		for pair in data:
			if typeof(pair) == TYPE_ARRAY and pair.size() >= 2:
				out.append(Vector2i(int(pair[0]), int(pair[1])))
		return out
	# Otherwise, if data itself looks like a pair [x,y], return single-element array
	if data.size() >= 2 and (_is_number(data[0]) and _is_number(data[1])):
		return [Vector2i(int(data[0]), int(data[1]))]
	# Fallback: try converting any inner arrays that look like pairs
	var out2 := []
	for item in data:
		if typeof(item) == TYPE_ARRAY and item.size() >= 2 and (_is_number(item[0]) and _is_number(item[1])):
			out2.append(Vector2i(int(item[0]), int(item[1])))
	return out2


static func _is_number(v) -> bool:
	return typeof(v) == TYPE_INT or typeof(v) == TYPE_FLOAT


static func _to_int_array(data) -> Array:
	if typeof(data) != TYPE_ARRAY:
		return []
	var out := []
	for v in data:
		if _is_number(v):
			out.append(int(v))
		elif typeof(v) == TYPE_STRING:
			# try parse int from string
			var n = int(v)
			out.append(n)
	return out


static func load_level(path: String) -> Dictionary:
	# Returns a dictionary with keys:
	# level_map: Array
	# def_file: String
	# level_size: Array[Vector2i]
	# dave_pos: Array[Vector2i]
	# minimum_score: Array[int]
	var result := {}
	var parsed = _read_json_file(path)
	if parsed.has("error"):
		push_error(parsed.error)
		return {}
	# Normalize numbers across the parsed structure (so floats become ints where appropriate)
	parsed = _normalize_numbers(parsed)
	# level_map as-is (Array). If you want to convert the innermost pairs to Vector2i,
	# you'd need a custom mapping depending on your tile format. For now we keep the
	# same nested Arrays but ensure numbers are ints.
	result.level_map = parsed.get("level_map", [])
	# def_file as string (if exists)
	result.def_file = str(parsed.get("def_file", ""))
	# The JSON might use "level_size" or "level-size" or similar; check common variants
	var level_size_raw = parsed.get("level_size", parsed.get("level-size", parsed.get("levels_size", [])))
	result.level_size = _to_vector2i_array(level_size_raw)
	# Dave position(s)
	var dave_raw = parsed.get("dave_pos", parsed.get("dave-position", parsed.get("dave_pos", [])))
	result.dave_pos = _to_vector2i_array(dave_raw)
	# Minimum score: might be "minimum score" or "minimum_score"
	var min_score_raw = null
	if parsed.has("minimum score"):
		min_score_raw = parsed["minimum score"]
	elif parsed.has("minimum_score"):
		min_score_raw = parsed["minimum_score"]
	elif parsed.has("minimum-score"):
		min_score_raw = parsed["minimum-score"]
	else:
		min_score_raw = parsed.get("minimumScore", [])
	result.minimum_score = _to_int_array(min_score_raw)
	return result
