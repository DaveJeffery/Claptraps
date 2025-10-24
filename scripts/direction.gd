#script: direction.gd
class_name Direction

var offset: Vector2i
var name: String
var opposite: Direction
var left: Direction
var right: Direction

func _init(_offset: Vector2i, _name: String):
	offset = _offset
	name = _name


# -- Static instances (like constants) ----------------------------

static var NORTH := Direction.new(Vector2i(0, -1), "NORTH")
static var EAST  := Direction.new(Vector2i(1, 0), "EAST")
static var SOUTH := Direction.new(Vector2i(0, 1), "SOUTH")
static var WEST  := Direction.new(Vector2i(-1, 0), "WEST")
static var STILL := Direction.new(Vector2i(0, 0), "STILL")

# Optional diagonals:
static var NE := Direction.new(Vector2i(1, -1), "NE")
static var SE := Direction.new(Vector2i(1, 1), "SE")
static var SW := Direction.new(Vector2i(-1, 1), "SW")
static var NW := Direction.new(Vector2i(-1, -1), "NW")


# -- Initialization of relationships -----------------------------

static func _setup():
	# Opposites
	NORTH.opposite = SOUTH
	SOUTH.opposite = NORTH
	EAST.opposite  = WEST
	WEST.opposite  = EAST
	STILL.opposite = STILL
	NE.opposite = SW
	SE.opposite = NW
	SW.opposite = NE
	NW.opposite = SE

	# Cardinal left/right turns (clockwise)
	NORTH.left = WEST
	NORTH.right = EAST
	EAST.left = NORTH
	EAST.right = SOUTH
	SOUTH.left = EAST
	SOUTH.right = WEST
	WEST.left = SOUTH
	WEST.right = NORTH

	# Diagonals can optionally define turns if needed
	NE.left = NW
	NE.right = SE
	SE.left = NE
	SE.right = SW
	SW.left = SE
	SW.right = NW
	NW.left = SW
	NW.right = NE

	# STILL doesn’t move or turn
	STILL.left = STILL
	STILL.right = STILL


# -- Convenience access ------------------------------------------

static var CARDINALS := [NORTH, EAST, SOUTH, WEST]
static var DIAGONALS := [NE, SE, SW, NW]
static var ALL := [NORTH, EAST, SOUTH, WEST, NE, SE, SW, NW, STILL]

# Call setup when script loads
static func _static_init():
	_setup()
