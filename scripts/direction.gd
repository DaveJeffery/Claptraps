class_name Direction
extends Node

static var NORTH := Direction.new(Vector2i(0, -1))
static var EAST  := Direction.new(Vector2i(1, 0))
static var SOUTH := Direction.new(Vector2i(0, 1))
static var WEST  := Direction.new(Vector2i(-1, 0))
static var STILL := Direction.new(Vector2i(0, 0))

static var NE := Direction.new(Vector2i(1, -1))
static var SE := Direction.new(Vector2i(1, 1))
static var SW := Direction.new(Vector2i(-1, 1))
static var NW := Direction.new(Vector2i(-1, -1))

var forward: Vector2i
var backward: Direction
var left: Direction
var right: Direction

func _ready() -> void:
	NORTH.backward = SOUTH
	SOUTH.backward = NORTH
	EAST.backward  = WEST
	WEST.backward  = EAST
	STILL.backward = STILL
	NE.backward = SW
	SE.backward = NW
	SW.backward = NE
	NW.backward = SE

	# Cardinal left/right turns
	NORTH.left = WEST
	NORTH.right = EAST
	EAST.left = NORTH
	EAST.right = SOUTH
	SOUTH.left = EAST
	SOUTH.right = WEST
	WEST.left = SOUTH
	WEST.right = NORTH

	# Diagonals (optional)
	NE.left = NW
	NE.right = SE
	SE.left = NE
	SE.right = SW
	SW.left = SE
	SW.right = NW
	NW.left = SW
	NW.right = NE

	# STILL
	STILL.left = STILL
	STILL.right = STILL

func _init(_forward: Vector2i):
	forward = _forward
