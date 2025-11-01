extends ColorRect

signal escape_pressed(escape_pressed: bool)

func init(labels:Array[String]) -> void:
	for i in labels.size():
		var label = $VBoxContainer.get_node("IntroText%d" % i)
		label.text =labels[i]

func _process(_delta):
	if Input.is_action_pressed("ui_select"):
		emit_signal("escape_pressed", false)
	elif Input.is_action_pressed("ui_cancel"):
		emit_signal("escape_pressed", true)
