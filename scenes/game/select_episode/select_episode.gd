## Sets game_filename, introtext and outrotext

extends ColorRect

signal episode(episode_metadata: EpisodeMetadata)


enum Levelset {
	NONE,
	ONE,
	TWO,
	THREE,
}

func _ready() -> void:
	set_process_input(true)


func _input(event: InputEvent) -> void:
	print_debug(event)
	if event.is_action_pressed("clap_1"):
		_process_selection(Levelset.ONE)
	elif event.is_action_pressed("clap_2"):
		_process_selection(Levelset.TWO)
	elif event.is_action_pressed("clap_3"):
		_process_selection(Levelset.THREE)
	elif event.is_action_pressed("clap_escape"):
		_process_selection(Levelset.NONE)


func _process_selection(levelset:int) -> void:
	get_viewport().set_input_as_handled()
	
	# Look up the data for the given levelset, set fields and emit the episode signal.
	var episode_metadata := EpisodeMetadata.new(levelset)
	emit_signal("episode", episode_metadata)

	hide()
	set_process_input(false)
