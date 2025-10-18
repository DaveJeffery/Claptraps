#script: game_state.gd
class_name GameState
extends Node

var score: int

var game_map: Array
var dave_x: int
var dave_y: int
var dave_dest_x: int
var dave_dest_y: int
var x_offset: int
var y_offset: int
var player_moving: bool
var kill_dave: bool
var obj_names: Dictionary
var use_key: bool
var level_number: int
var min_score_hit: bool
var level_finished: bool
var lives: int
var transporting: bool
var message: String
var bg_col := Color(0.588, 0.588, 1.0) # 150,150,255 / 255
var play_music: bool
var default_message: String
var keys: Array
var no_of_objects: int
var target_img: Texture2D

func _init():
	score = 0
	game_map = []
	dave_x = 0 #TODO Make Vector 2i
	dave_y = 0 #TODO Make Vector 2i
	dave_dest_x = 0 #TODO Make Vector 2i
	dave_dest_y = 0 #TODO Make Vector 2i
	x_offset = 0 #TODO Make Vector 2i
	y_offset = 0 #TODO Make Vector 2i
	player_moving = false
	kill_dave = false
	obj_names = {}
	use_key = false
	level_number = 0
	min_score_hit = false
	level_finished = false
	lives = 3
	transporting = false
	message = "Blank!"
	play_music = true
	default_message = "Grab those frogs!" #TODO tr()
	keys = ["ui_right", "ui_left", "ui_up", "ui_down", "ui_accept"]
	no_of_objects = 0
	target_img = load("res://sprites/target.png")
