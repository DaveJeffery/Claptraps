extends ColorRect

signal escape_pressed(escape_pressed: bool)

func init(game_state:GameState) -> void:
	$VBoxContainer/Level.text = tr("LEVEL") + " %d" % (game_state.level_number + 1)
	$VBoxContainer/Message.text = tr("GAME_ON")
	$VBoxContainer/Score.text = tr("SCORE") + " %d" % (game_state.score)
	$VBoxContainer/TargetScore.text = tr("TARGET") + " %d" % (game_state.minimum_score)
	$VBoxContainer/Lives.text = tr("LIVES") + " %d" % (game_state.lives)	


func _process(_delta):
	if Input.is_action_pressed("ui_select"):
		emit_signal("escape_pressed", false)
	elif Input.is_action_pressed("ui_cancel"):
		emit_signal("escape_pressed", true)
