extends ColorRect

signal intro

func init(labels:Array[String]) -> void:
	for i in labels.size():
		var label = $VBoxContainer.get_node("IntroText%d" % i)
		label.text =labels[i]

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_select"):
		get_viewport().set_input_as_handled()
		emit_signal("intro")
