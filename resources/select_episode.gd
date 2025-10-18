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
var intro_text: Array[String] = []
var outro_text: Array[String] = []

# Centralised level data to remove repetition and make adding new sets trivial
const LEVEL_DATA := {
	Levelset.ONE: {
		"game_filename": "game_data1.json",
		"intro_text": [
			"SET1_INTRO1",
			"SET1_INTRO2",
			"SET1_INTRO3",
			"SET1_INTRO4",
		],
		"outro_text": [
			"SET1_OUTRO1",
			"SET1_OUTRO2",
			"SET1_OUTRO3",
			"SET1_OUTRO4",
		],
	},
	Levelset.TWO: {
		"game_filename": "game_data2.json",
		"intro_text": [
			"SET2_INTRO1",
			"SET2_INTRO2",
			"SET2_INTRO3",
			"SET2_INTRO4",
		],
		"outro_text": [
			"SET2_OUTRO1",
			"SET2_OUTRO2",
			"SET2_OUTRO3",
			"SET2_OUTRO4",
		],
	},
	Levelset.THREE: {
		"game_filename": "game_data2.json",
		"intro_text": [
			"SET3_INTRO1",
			"SET3_INTRO2",
			"SET3_INTRO3",
			"SET3_INTRO4",
		],
		"outro_text": [
			"SET3_OUTRO1",
			"SET3_OUTRO2",
			"SET3_OUTRO3",
			"SET3_OUTRO4",
		],
	},
}


func _init() -> void:
	pass


func _input(event: InputEvent) -> void:
	if event.is_action_pressed("clap_1"):
		get_viewport().set_input_as_handled()
		_process_selection(Levelset.ONE)
		hide()
	elif event.is_action_pressed("clap_2"):
		get_viewport().set_input_as_handled()
		_process_selection(Levelset.TWO)
		hide()
	elif event.is_action_pressed("clap_3"):
		get_viewport().set_input_as_handled()
		_process_selection(Levelset.THREE)
		hide()
	elif event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		# TODO $QuitScreen.show()


func _process_selection(levelset:int) -> void:
	# Look up the data for the given levelset, set fields and emit the episode signal.
	var data := LEVEL_DATA.get(levelset, null)
	if data == null:
		push_error("select_episode: unknown levelset %s" % str(levelset))
		return

	game_filename = data["game_filename"]
	intro_text = data["intro_text"]
	outro_text = data["outro_text"]

	emit_signal("episode", game_filename, intro_text, outro_text)
