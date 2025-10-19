class_name EpisodeData
extends Node

var game_filename: String
var intro_text: Array[String]
var outro_text: Array[String]


func _init(episode:int) -> void:
	match episode:
		1:
			game_filename = "episode1.json"
			intro_text = [
				"SET1_INTRO1",
				"SET1_INTRO2",
				"SET1_INTRO3",
				"SET1_INTRO4",
			]
			outro_text = [
				"SET1_OUTRO1",
				"SET1_OUTRO2",
				"SET1_OUTRO3",
				"SET1_OUTRO4",
			]
		2:
			game_filename = "episode2.json"
			intro_text = [
				"SET2_INTRO1",
				"SET2_INTRO2",
				"SET2_INTRO3",
				"SET2_INTRO4",
			]
			outro_text = [
				"SET2_OUTRO1",
				"SET2_OUTRO2",
				"SET2_OUTRO3",
				"SET2_OUTRO4",
			]
		3:
			game_filename = "episode3.json"
			intro_text = [
				"SET3_INTRO1",
				"SET3_INTRO2",
				"SET3_INTRO3",
				"SET3_INTRO4",
			]
			outro_text = [
				"SET3_OUTRO1",
				"SET3_OUTRO2",
				"SET3_OUTRO3",
				"SET3_OUTRO4",
			]
		_:
			game_filename = ""
			intro_text = [""]
			outro_text = [""]
