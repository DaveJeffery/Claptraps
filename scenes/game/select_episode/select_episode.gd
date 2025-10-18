## Sets game_filename, introtext and outrotext

extends ColorRect

signal episode(
	game_filename:String, 
	intro_text:Array[String], 
	outro_text:Array[String],
)

enum Levelset {
	ONE = 1,
	TWO,
	THREE,
}

var game_filename: String
var intro_text: Array[String]
var outro_text: Array[String]


func _init() -> void:
	pass


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("clap_1"):
		get_viewport().set_input_as_handled()
		set_variables(Levelset.ONE)
		hide()
	elif event.is_action_pressed("clap_2"):
		get_viewport().set_input_as_handled()
		set_variables(Levelset.TWO)
		hide()
	elif event.is_action_pressed("clap_3"):
		get_viewport().set_input_as_handled()
		set_variables(Levelset.THREE)
		hide()
	elif event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		#TODO $QuitScreen.show()  


func set_variables(levelset:int) -> void:
	match levelset:
		Levelset.ONE:
			game_filename = "game_data1.json"
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
		Levelset.TWO:
			game_filename = "game_data2.json"
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
		Levelset.THREE:
			game_filename = "game_data2.json"
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
	emit_signal("episode", game_filename, intro_text, outro_text)
