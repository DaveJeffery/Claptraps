#script: title_scene.gd

extends Node

var menu_items = ["MENU_USER", "MENU_EDITOR", "MENU_MUSIC", 
				  "MENU_REDEFINE", "MENU_EXIT"]
var menu_counter = 0

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	$MenuTimer.start()
	$AudioStreamPlayer.play()

func _on_MenuTimer_timeout():
	# Called every second to update the text shown in the MenuLabel label
	menu_counter = (menu_counter + 1) % menu_items.size()
	$VBoxContainer/MenuContainer/MenuLabel.text = menu_items[menu_counter]