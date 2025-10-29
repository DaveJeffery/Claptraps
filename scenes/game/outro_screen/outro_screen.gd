extends ColorRect

signal escape_pressed(escape_pressed: bool)

func init(labels:Array[String]) -> void:
	for i in labels.size():
		var label = $VBoxContainer.get_node("OutroText%d" % i)
		label.text =labels[i]

func _unhandled_key_input(event: InputEvent) -> void:
	if event.is_action_released("ui_select"):
		get_viewport().set_input_as_handled()
		emit_signal("escape_pressed", false)
	if event.is_action_released("ui_cancel"):
		get_viewport().set_input_as_handled()
		emit_signal("escape_pressed", true)
