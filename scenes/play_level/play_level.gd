class_name PlayLevel
extends Node

signal completed(is_completed: bool)

@onready var tile_map_layer := $TileMapLayer
@onready var dave := $TileMapLayer/Dave

var game_background: GameBackground

var game_state: GameState
var game_data: EpisodeData
var game_objects: GameObjects

var program_quit: bool
var program_status: bool

var minimum_score: int

var player_right: bool
var player_left: bool
var player_up: bool
var player_down: bool
var player_dir: Direction
var player_move_counter: Vector2i
var dave_wait: int


func _init(
	current_state: GameState, 
	current_episode: EpisodeData,
	current_objects: GameObjects
) -> void:
	# Store parameters as globals
	game_state = current_state
	game_data = current_episode
	game_objects = current_objects

	## Reset minimum score hit and level flags
	minimum_score = game_data.levels[game_state.level_number].minimum_score
	game_state.min_score_hit = false
	game_state.level_finished = false

	## Copy level data to our working copy of the map
	## game_state.game_map is our working copy of the current level

	game_state.level_size = (
		game_data.levels[game_state.level_number].map_size
	)
	
	## Fill a working map (game_state.game_map) with instances of Thing 
	## objects rather than integers so we can access their behaviours
	_fill_game_map()
	
	## Initialise Dave's position on the map using the starting 
	## position stored in the episode data
	_init_dave_position()

	## Help the scrolling routing to keep Dave at least
	## 5 squares from the sides of the screen
	_calculate_offset()

	## Quit variable
	program_quit = false
	
	## Initialise Dave's movement
	_init_dave_movement()
	
	## These variables initialise the scrolling and player screen
	tile_map_layer.tile_set = game_objects.tile_set
	#TODO More will probably be added later
	
	## Decremented each frame until it reaches zero.
	## Set to 10 whenever Dave moves, if <8 hits object below it.
	dave_wait = 0 


func _ready() -> void:
	game_background = GameBackground.new()
	game_background.setup(game_state)
	add_child(game_background)
	move_child(game_background, 0)


func _input(event: InputEvent) -> void:

	if event.is_action_pressed("ui_cancel"):
		program_quit = true

	if (
		event.is_action_pressed("clap_right")
		or event.is_action_pressed("ui_right")
	):
		player_right = true
		player_left = false
	elif (
		event.is_action_released("clap_right")
		or event.is_action_released("ui_right")
	):
		player_right = false

	if (
		event.is_action_pressed("clap_left")
		or event.is_action_pressed("ui_left")
	):
		player_left = true
		player_right = false
	elif (
		event.is_action_released("clap_left")
		or event.is_action_released("ui_left")
	):
		player_left = false

	if (
		event.is_action_pressed("clap_up")
		or event.is_action_pressed("ui_up")
	):
		player_up = true
		player_down = false
	elif (
		event.is_action_released("clap_up")
		or event.is_action_released("ui_up")
	):
		player_up = false

	if (
		event.is_action_pressed("clap_down")
		or event.is_action_pressed("ui_down")
	):
		player_down = true
		player_up = false
	elif (
		event.is_action_released("clap_down")
		or event.is_action_released("ui_down")
	):
		player_down = false

	if event.is_action_pressed("clap_use"):
		game_state.use_key = true
	elif event.is_action_released("clap_use"):
		game_state.use_key = false

	if event.is_action_pressed("clap_tab"):
		game_state.use_key = false
		player_up = false
		player_down = false
		player_left = false
		player_right = false
		program_quit = false
		program_status = true


func _process(_delta: float) -> void:

## Process inputs
	if player_right:
		player_dir = Direction.EAST
	elif player_left:
		player_dir = Direction.WEST
	elif player_up:
		player_dir = Direction.NORTH
	elif player_down:
		player_dir = Direction.SOUTH
	else:
		player_dir = Direction.STILL
		
## Exit to menu
	if program_quit:
		program_quit = await _show_quit_screen()
		if program_quit:
			emit_signal("completed", false)

## Handle Status Screen
	if program_status:
		program_quit = await _show_quit_screen()
		if program_quit:
			emit_signal("completed", false)

## Move Player
	_move_player()
#
## Perform sprite actions
	_perform_sprite_actions()

## Kill Dave: oh no!
	if game_state.kill_dave:
		_handle_death()
#
## Transport-out effect       
	#if game_state.transporting == True:
		#old_screen.blit(screen, old_rect)
		#
		#for col_val in range(16):
			#game_state.bg_col = 255 - col_val * 16, 255 - col_val * 16, 255 - col_val * 16
			#screen.fill(game_state.bg_col)
			#screen.blit(old_screen, old_rect, None, pygame.BLEND_MIN)
			#pygame.display.flip()
			##game_state.transporting = False
		#game_state.bg_col = 150, 150, 255
#
	#screen.fill(game_state.bg_col)
#
## Draw map
	_draw_map()
#
## Draw player
	_draw_player()
#
## Transport-in effect
	#if game_state.transporting == True:
		#old_screen.blit(screen, old_rect)
		#
		#for col_val in range(16):
			#game_state.bg_col = col_val * 16, col_val * 16, col_val * 16
			#screen.fill(game_state.bg_col)
			#screen.blit(old_screen, old_rect, None, pygame.BLEND_ADD)
			#pygame.display.flip()
			#game_state.transporting = False
		#if game_state.min_score_hit == True:
			#game_state.bg_col = 255, 220, 150
		#else:
			#game_state.bg_col = 150, 150, 255

## Flag to show when Dave should hit objects below him
	if dave_wait > 0:
		dave_wait -= 1
	elif dave_wait == 0:
		dave.animation.animation = Direction.STILL.anim_name

## Dave action function is used for any goal checks etc.
	dave.action()

## If minimum score hit, set game_state.min_score_hit flag
	if game_state.score >= minimum_score:
		game_state.min_score_hit = true
		
## If level has been completed, this signal will be emitted
	if game_state.level_finished:
		emit_signal("completed", true)


## Fill a working map (game_state.game_map) with instances of Thing 
## objects rather than integers so we can access their behaviours
func _fill_game_map() -> void:
	game_state.game_map = []
	
	var width := game_state.level_size.x
	var height := game_state.level_size.y
	var source_map := game_data.levels[game_state.level_number].map
	
	for y in range(height):
		var row: Array = []
		for x in range(width):
			# Read the map contents in the episode level data
			var cell_contents := source_map[y][x]  as Array
			var thing_code:= cell_contents[0] as int
			var thing_target:= cell_contents[1] as Vector2i

			# Instantiate a Thing at x, y in the working map
			var thing_scene := game_objects.objects[thing_code]
			var thing: Thing = thing_scene.instantiate()
			
			# Update the Thing's grid position and target
			thing.grid_pos = Vector2i(x, y)
			thing.target = thing_target
			thing.game_state = game_state
			
			# Append to row
			row.append(thing)
			
		# Append completed row to map
		game_state.game_map.append(row)


## Initialise Dave's position on the map using the starting 
## position stored in the episode data
func _init_dave_position() -> void:
	var source_pos := game_data.levels[game_state.level_number].dave_pos
	game_state.dave_pos = source_pos
	game_state.dave_dest = source_pos


## Initialise Dave's movement
func _init_dave_movement() -> void:
	player_right = false
	player_left = false
	player_up = false 
	player_down = false
	player_dir = Direction.STILL
	game_state.player_moving = Direction.STILL
	
	## x, y go from -4 to 0 or 0 to 4
	player_move_counter = Vector2i(0, 0)


## These variables are used to keep Dave at least
## 5 squares from the sides of the map
func _calculate_offset() -> void: 
	var x_offset: int = clamp(
		game_state.dave_pos.x - 5, 
		0, 
		game_state.level_size.x - 16
	)
	var y_offset: int = clamp(
		game_state.dave_pos.y - 5, 
		0, 
		game_state.level_size.y - 12
	)
	
	game_state.xy_offset = Vector2i(x_offset, y_offset)


## Move the Dave Thing instance on the TileMapLayer  TODO
func _draw_player() -> void:
	#player_rect.left = (game_state.dave_x - game_state.x_offset) * 40 + (player_move_counter_horiz * 10) * (not scroll_horiz)
	#player_rect.top = (game_state.dave_y - game_state.y_offset) * 40 + (player_move_counter_vert * 10) * (not scroll_vert) 
	#screen.blit(sprite_dave[dave_frame], player_rect)
	pass


## Show the quit screen
func _show_quit_screen() -> bool:
	set_process_input(false)

	$QuitScreen.show()
	$QuitScreen.set_process_input(true)
	
	program_quit = await $QuitScreen.quit_requested
	
	$QuitScreen.set_process_input(false)

	return program_quit


## Show the status screen
func _show_status_screen() -> bool:
	set_process_input(false)
	
	$StatusScreen.show()
	$StatusScreen.set_process_input(true)
	
	program_quit = await $StatusScreen.escape_pressed
	
	$StatusScreen.set_process_input(false)
	
	return program_quit


# Moves the player TODO more useful notes to follow
func _move_player() -> void:
	if not game_state.player_moving:
		_move_static_player()
		return

	var dir: Direction = game_state.player_moving
	if dir == Direction.STILL:
		return

	# Movement
	player_move_counter += dir.forward
	dave.animation.animation = dir.anim_name
	dave_wait = 10

	# Check for move completion

	if abs(player_move_counter.x) == 4 or abs(player_move_counter.y) == 4:
		player_move_counter = Vector2i.ZERO
		game_state.player_moving = Direction.STILL
		game_state.dave_pos += dir.forward

		# Let Dave hit objects
		var pos = game_state.dave_pos
		var tile: Thing = game_state.game_map[pos.y][pos.x]
		if not tile.solid:
			GameFunctions.dave_hit()

	# Standing still (but not just moved)
	if dave_wait < 8:
		GameFunctions.dave_hit()


## If the player is not moving, start the player moving, change their 
## destination position and push any objects that are in the way.
func _move_static_player():
	_try_move(Direction.EAST)
	_try_move(Direction.WEST)
	_try_move(Direction.NORTH)
	_try_move(Direction.SOUTH)


func _try_move(dir: Direction) -> bool:

	var new_pos := game_state.dave_pos + dir.forward

	# Bounds check for the target cell
	if new_pos.x < 0 or new_pos.y < 0 \
	or new_pos.x >= game_state.level_size.x \
	or new_pos.y >= game_state.level_size.y:
		return false

	var target_cell := game_state.game_map[new_pos.y][new_pos.x] as Thing

	if not target_cell.solid:
		# Simple move
		game_state.player_moving = dir
		game_state.dave_dest = new_pos
		return true

	# Determine if the push property applies for this direction
	var can_push := false
	if dir == Direction.EAST or dir == Direction.WEST:
		can_push = target_cell.h_push
	elif dir == Direction.NORTH or dir == Direction.SOUTH:
		can_push = target_cell.v_push

	if can_push:
		var push_pos := new_pos + dir.forward

		# Bounds check for pushed cell
		if push_pos.x < 0 or push_pos.y < 0 \
		or push_pos.x >= game_state.level_size.x \
		or push_pos.y >= game_state.level_size.y:
			return false

		var push_cell := game_state.game_map[push_pos.y][push_pos.x] as Thing

		if push_cell.check_squash(target_cell.game_object_name):
			GameFunctions.move(dir, target_cell, new_pos)  # existing push function
			game_state.player_moving = dir
			game_state.dave_dest = new_pos
			return true

	return false  # blocked


func _perform_sprite_actions() -> void:
	for y in range(game_state.level_size.y): 
		for x in range(game_state.level_size.x):
			var current_sprite = game_state.game_map[y][x]
#
			if (
				Vector2i(x, y) == game_state.dave_pos 
				and not current_sprite.solid
			):
				dave.dave_hit()

			if not current_sprite.ignore:
				current_sprite.action()

				if current_sprite.moved > 0:
					current_sprite.moved = 0
			else:
				current_sprite.ignore = false

			if current_sprite.moving == Direction.STILL:
				continue
#
			current_sprite.move_counter += current_sprite.move_speed
			
			if current_sprite.move_counter < 4:
				continue

			if current_sprite.moving not in [Direction.STILL, null]:
				GameFunctions.move_thing_in_direction(Vector2i(x, y), current_sprite.moving)


func _handle_death() -> void:
	game_state.kill_dave = false
	game_state.lives -= 1
	game_state.use_key = false
	game_state.transporting = false
	
	# Stop Dave from moving
	_init_dave_movement()
	
	# Reset Dave's position
	_init_dave_position()

	# Adjust the scrolling for Dave's new position
	_calculate_offset()
	
	#if game_state.lives == 0:
		#render_text('Poor Dave', 240)
		#pygame.display.flip()
		#while(1):
			#wait_event = pygame.event.wait()
			#if wait_event.type == pygame.KEYDOWN:
				#if wait_event.key == pygame.K_SPACE:
					#break
				#else:
					#pass
		#return False
	#else:
		#render_text('Watch out Dave! That killed you!', 240)
		#pygame.display.flip()
		#while(1):
			#wait_event = pygame.event.wait()
			#if wait_event.type == pygame.KEYDOWN:
				#if wait_event.key == pygame.K_SPACE:
					#break
				#else:
					#pass
#
	#if status_screen() == False:
		#program_quit = True

func _draw_map() -> void:
	#for y_counter in range(12 + scroll_vert):
		#for x_counter in range(16 + scroll_horiz):
#
			#map_sprite = game_state.game_map[x_counter - scroll_horiz_comp + game_state.x_offset][y_counter - scroll_vert_comp + game_state.y_offset]
#
			#if map_sprite.sprite > 0:
				#if map_sprite.moving == game_state.NORTH:
					#
					#screen.blit(game_sprites[map_sprite.sprite]
					#,((x_counter - scroll_horiz_comp) * 40 - (player_move_counter_horiz * 10) * scroll_horiz
					#, (y_counter - scroll_vert_comp) * 40 - \
					  #(player_move_counter_vert * 10) * scroll_vert - map_sprite.move_counter * 10))
#
				#elif map_sprite.moving == game_state.EAST:
					#
					#screen.blit(game_sprites[map_sprite.sprite]
					#,((x_counter - scroll_horiz_comp) * 40 - \
					  #(player_move_counter_horiz * 10) * scroll_horiz + map_sprite.move_counter * 10
					#, (y_counter - scroll_vert_comp) * 40 - (player_move_counter_vert * 10) * scroll_vert))
#
				#elif map_sprite.moving == game_state.SOUTH:
					#
					#screen.blit(game_sprites[map_sprite.sprite]
					#,((x_counter - scroll_horiz_comp) * 40 - (player_move_counter_horiz * 10) * scroll_horiz
					#, (y_counter - scroll_vert_comp) * 40 - \
					  #(player_move_counter_vert * 10) * scroll_vert + map_sprite.move_counter * 10))
#
				#elif map_sprite.moving == game_state.WEST:
					#
					#screen.blit(game_sprites[map_sprite.sprite]
					#,((x_counter - scroll_horiz_comp) * 40 - \
					  #(player_move_counter_horiz * 10) * scroll_horiz - map_sprite.move_counter * 10
					#, (y_counter - scroll_vert_comp) * 40 - (player_move_counter_vert * 10) * scroll_vert))
#
				#else:
#
					#screen.blit(game_sprites[map_sprite.sprite]
					#,((x_counter - scroll_horiz_comp) * 40 - (player_move_counter_horiz * 10) * scroll_horiz
					#, (y_counter - scroll_vert_comp) * 40 - (player_move_counter_vert * 10) * scroll_vert))
					#
	pass
