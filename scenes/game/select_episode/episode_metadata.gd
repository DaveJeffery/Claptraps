class_name EpisodeMetadata
extends Node

var game_filename: String
var intro_text: Array[String]
var outro_text: Array[String]


func _init(episode:int) -> void:
	# This is used by SelectEpisode and Game to indicate Escape
	# being pressed.
	if episode == 0:
		return
	
	game_filename = "res://levels/episode%d.tres" % episode
	intro_text = [
		"SET%d_INTRO1" % episode,
		"SET%d_INTRO2" % episode,
		"SET%d_INTRO3" % episode,
		"SET%d_INTRO4" % episode,
	]
	outro_text = [
		"SET%d_OUTRO1" % episode,
		"SET%d_OUTRO2" % episode,
		"SET%d_OUTRO3" % episode,
		"SET%d_OUTRO4" % episode,
	]
