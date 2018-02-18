extends ColorRect

var level_list
var file_number
var file_selected
var new_level_set

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	set_process_input(false)
	pass
	
func _input(event):
	if event.is_action_pressed("ui_down"):
		get_tree().set_input_as_handled()
		file_selected = (file_selected + 1) % file_number
		$VBoxContainer/FilenameLabel.text = level_list[file_selected].split(".")[0]
	elif event.is_action_pressed("ui_up"):
		get_tree().set_input_as_handled()
		file_selected = (file_selected - 1) % file_number
		$VBoxContainer/FilenameLabel.text = level_list[file_selected].split(".")[0]
	elif event.is_action_pressed("clap_new"):
		get_tree().set_input_as_handled()
		new_level_set = true
		hide()
	elif event.is_action_pressed("ui_accept"):
		get_tree().set_input_as_handled()
		hide()
	elif event.is_action_pressed("ui_cancel"):
		get_tree().set_input_as_handled()
		get_tree().change_scene("res://scenes/title_scene.tscn")

func init(level_list):
	self.level_list = level_list
	file_number = level_list.size()
	new_level_set = false	
	file_selected = 0
	$VBoxContainer/FilenameLabel.text = level_list[file_selected].split(".")[0]
	
	set_process_input(true)