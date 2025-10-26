class_name Apple
extends Thing

const APPLE_FALLS := [
	"Frog",
	"StartledFrog",
	"RedFrog",
	"AngryRedFrog",
	"Laser",
]

var life: int

func _ready() -> void:
	game_object= 14
	game_object_name = "Apple"
	h_push = true
	move_speed = 4
	life = 60

func action() -> void:

	if moving == Direction.STILL or moved == Direction.STILL:
		startle_frog = true
	else:
		startle_frog = false

	if (
		look(game_state.SOUTH, grid_pos).empty 
		or look(game_state.SOUTH, grid_pos).name in APPLE_FALLS
	):
		move(game_state.SOUTH, self, grid_pos)
	elif (
		look(game_state.SOUTH, grid_pos).name == "Apple" 
		and (
			look(game_state.SW, grid_pos).empty 
			or look(game_state.SW, grid_pos).name in APPLE_FALLS
			) 
		and (
			look(game_state.WEST, grid_pos).empty 
			or look(game_state.WEST, grid_pos).name in APPLE_FALLS
			)
	):
		move(game_state.WEST, self, grid_pos)

	elif (
		look(game_state.SOUTH, grid_pos).name == "Apple" 
		and (
			look(game_state.SE, grid_pos).empty 
			or look(game_state.SE, grid_pos).name in APPLE_FALLS
		) 
		and (
			look(game_state.EAST, grid_pos).empty 
			or look(game_state.EAST, grid_pos).name in APPLE_FALLS
		)
	):
		move(game_state.EAST, self, grid_pos)

	if (
		moved == game_state.SOUTH 
		and look(game_state.SOUTH, grid_pos).is_dave
	):
		game_state.kill_dave = true

func eat() -> void:
	life -= 1
	if life < 0:
		create("Blank", Direction.STILL, grid_pos)
