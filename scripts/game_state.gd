#script: game_state.gd
class_name GameState
extends Node

const NORTH := 1
const EAST := 2
const SOUTH := 3
const WEST := 4
const NE := 5
const SE := 6
const SW := 7
const NW := 8

var score: int
var level_size: Vector2i
var game_map: Array
var dave_pos: Vector2i
var dave_dest: Vector2i
var xy_offset: Vector2i
var player_moving: int
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
	level_size = Vector2i(16, 12)
	dave_pos = Vector2i.ZERO
	dave_dest = Vector2i.ZERO
	xy_offset = Vector2i.ZERO
	player_moving = 0
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
