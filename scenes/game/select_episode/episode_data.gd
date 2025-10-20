class_name EpisodeData
extends Node

var game_filename: String
var intro_text: Array[String]
var outro_text: Array[String]


func _init(episode:int) -> void:
	game_filename = "res://levels/episode{episode}.tres"
	intro_text = [
		"SET{episode}_INTRO1",
		"SET{episode}_INTRO2",
		"SET{episode}_INTRO3",
		"SET{episode}_INTRO4",
	]
	outro_text = [
		"SET{episode}_OUTRO1",
		"SET{episode}_OUTRO2",
		"SET{episode}_OUTRO3",
		"SET{episode}_OUTRO4",
	]
