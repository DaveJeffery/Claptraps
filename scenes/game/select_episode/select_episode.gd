## Sets game_filename, introtext and outrotext

extends ColorRect

signal episode(game_filename:String, intro_text:String, outro_text:String)

var game_filename:String
var intro_text:String
var outro_text:String


func _init() -> void:
	pass


func _input(event: InputEvent) -> void:
	emit_signal("episode")


func set_variables(levelset:int) -> void:
	pass
