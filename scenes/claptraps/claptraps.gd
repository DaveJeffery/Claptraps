class_name Claptraps
extends Node

static var game_objects: GameObjects


func _init() -> void:
	game_objects.names = [
		"Blank",   # Leave Blank where it is
		"Wall",    # There must be a Wall object for the unseen outer wall
		"Smiley",
		"CalmFrog",
		"StartledFrog",
		"Box",
		"Chopper",
		"Transporter",
		"Grass",
		"RedFrog",
		"AngryRedFrog",
		"ButtonOn",
		"ButtonOff",
		"Gate",
		"Apple",
		"TurretN",
		"TurretE",
		"TurretS",
		"TurretW",
		"Laser",
		"Key",
		"Lock",
		"Bush",
		"Wall2",
		"Wall3",
		"Rock",
	]

	game_objects.objects = { 
		0: preload("res://scenes/claptraps/blank/blank.tscn"),
		1: preload("res://scenes/claptraps/wall/wall.tscn"), 
		2: preload("res://scenes/claptraps/smiley/smiley.tscn"),
		3: preload("res://scenes/claptraps/calm_frog/calm_frog.tscn"),
		4: preload("res://scenes/claptraps/startled_frog/startled_frog.tscn"),
		5: preload("res://scenes/claptraps/box/box.tscn"),
		6: preload("res://scenes/claptraps/chopper/chopper.tscn"),
		7: preload("res://scenes/claptraps/transporter/transporter.tscn"),
		8: preload("res://scenes/claptraps/grass/grass.tscn"),
		9: preload("res://scenes/claptraps/red_frog/red_frog.tscn"),
		10: preload("res://scenes/claptraps/angry_red_frog/angry_red_frog.tscn"),
		11: preload("res://scenes/claptraps/button_on/button_on.tscn"),
		12: preload("res://scenes/claptraps/button_off/button_off.tscn"),
		13: preload("res://scenes/claptraps/gate/gate.tscn"),
		14: preload("res://scenes/claptraps/apple/apple.tscn"),
		15: preload("res://scenes/claptraps/turret_n/turret_n.tscn"),
		16: preload("res://scenes/claptraps/turret_e/turret_e.tscn"),
		17: preload("res://scenes/claptraps/turret_s/turret_s.tscn"),
		18: preload("res://scenes/claptraps/turret_w/turret_w.tscn"),
		19: preload("res://scenes/claptraps/laser/laser.tscn"),
		20: preload("res://scenes/claptraps/key/key.tscn"),
		21: preload("res://scenes/claptraps/lock/lock.tscn"),
		22: preload("res://scenes/claptraps/bush/bush.tscn"),
		23: preload("res://scenes/claptraps/wall_2/wall_2.tscn"),
		24: preload("res://scenes/claptraps/wall_3/wall_3.tscn"),
		25: preload("res://scenes/claptraps/rock/rock.tscn"),
	}
