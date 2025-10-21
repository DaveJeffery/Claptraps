class_name Thing
extends Node2D

var game_object := 0
var game_object_name := ""
var sprite := 1
var x :=0
var y := 0
var solid := true
var squash := false
var ignore := false
var h_push := false
var v_push := false
var moving := 0
var being_moved_into := 0
var moved := 0
var forward := 1
var backward := 3
var left := 4
var right := 2
var move_counter := 0
var move_speed := 0
var is_dave := false
var empty := false
var needs_target := false
var target := 0
var animation := 0
var anim_frame := 0
var anim_timer := 0
var trigger_button := false
var solid_to_red_frog := true
var break_box := false

var startle_frog := false

func hit(hitby: Thing) -> void:
	return

func action() -> void:
	return

func check_squash(obj: Thing) -> bool:
	return squash
