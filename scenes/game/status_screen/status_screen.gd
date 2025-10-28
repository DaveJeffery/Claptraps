extends ColorRect

signal escape_pressed(escape_pressed: bool)

func init(game_state:GameState) -> void:
	$VBoxContainer/Level.text = tr("LEVEL") + " %d" % (game_state.level_number + 1)
	$VBoxContainer/Message.text = tr("GAME_ON")
	$VBoxContainer/Score.text = tr("SCORE") + " %d" % (game_state.score)
	$VBoxContainer/TargetScore.text = tr("TARGET") + " %d" % (game_state.minimum_score)
	$VBoxContainer/Lives.text = tr("LIVES") + " %d" % (game_state.lives)	


func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select"):
		get_viewport().set_input_as_handled()
		emit_signal("escape_pressed", false)
	elif event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		emit_signal("escape_pressed", true)
