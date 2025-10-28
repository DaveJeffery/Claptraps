## Sets game_filename, introtext and outrotext

extends ColorRect

signal episode(episode_metadata: EpisodeMetadata)


enum Levelset {
	ONE = 1,
	TWO,
	THREE,
}


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
		print_debug("ui_cancel")
		get_viewport().set_input_as_handled()
		emit_signal("episode", EpisodeMetadata.new(0))  
		hide()


func _process_selection(levelset:int) -> void:
	# Look up the data for the given levelset, set fields and emit the episode signal.
	var episode_metadata := EpisodeMetadata.new(levelset)
	emit_signal("episode", episode_metadata)
