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
var moving := Vector2i.ZERO
var being_moved_into := Vector2i.ZERO
var moved := 0
var forward := GameState.NORTH
var backward := GameState.SOUTH
var left := GameState.WEST
var right := GameState.EAST
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


func check_squash(obj: Thing) -> bool:
	return squash


## Wrapper functions
func look(direction:Vector2i, grid_pos: Vector2i) -> Thing:
	return GameFunctions.look(direction, grid_pos)


func move(direction:Vector2i, object: Thing, grid_pos: Vector2i) -> void:
	return GameFunctions.move(direction, object, grid_pos)
