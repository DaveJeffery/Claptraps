extends ColorRect

signal status

func init(game_state:GameState) -> void:
	$VBoxContainer/Level.text = tr("LEVEL") + " %d" % (game_state.level_number + 1)

	pass
