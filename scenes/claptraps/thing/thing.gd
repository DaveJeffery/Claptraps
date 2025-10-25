class_name Thing
extends Node

var game_state: GameState
var game_object := 0
var game_object_name := ""
var sprite := 1
var grid_pos := Vector2i.ZERO
var solid := true
var squash := false
var ignore := false
var h_push := false
var v_push := false
var moving := Direction.STILL
var being_moved_into := Direction.STILL
var moved := 0
var move_counter := 0
var move_speed := 0
var is_dave := false
var empty := false
var needs_target := false
var target := Vector2i(-1,-1)
#NOTE animation should probably be changed into a string for animated sprites
var animation := 0  
var anim_frame := 0
var anim_timer := 0
var trigger_button := false
var solid_to_red_frog := true
var break_box := false
var startle_frog := false


func _init(current_game_state: GameState) -> void:
	game_state = current_game_state


func hit(hitby: Thing) -> void:
	return


func action() -> void:
	return


func check_squash(object: Thing) -> bool:
	return squash


## Wrapper functions
func look(direction:Direction, location: Vector2i) -> Thing:
	return GameFunctions.look(direction, location)


func move(direction:Direction, object: Thing, location: Vector2i) -> void:
	return GameFunctions.move(direction, object, location)


func change(object_1: String, object_2: String) -> void:
	return GameFunctions.change(object_1, object_2)


func dave_is_to(direction:Direction, location: Vector2i) -> bool:
	return GameFunctions.dave_is_to(direction, location)


func create(object: Thing, direction: Direction, location: Vector2i) -> void:
	return GameFunctions.create(object, direction, location)
	
	
func dave_hit() -> void:
	return GameFunctions.dave_hit()
