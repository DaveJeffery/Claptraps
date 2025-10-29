class_name PlayLevel
extends Node

signal completed(is_completed: bool)

var game_state: GameState
var game_data: EpisodeData
var game_objects: GameObjects

func game(
	current_state: GameState, 
	current_episode: EpisodeData,
	current_objects: GameObjects
) -> void:
	# Store parameters as globals
	game_state = current_state
	game_data = current_episode
	game_objects = current_objects

	## Reset minimum score hit and level flags
	game_state.min_score_hit = false
	game_state.level_finished = false

	## Sets up a spare drawing surface. Python draws on screen, but 
	## also uses old_screen
	#old_screen = pygame.Surface((640, 480))
	#old_rect = old_screen.get_rect()

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

	## These variables are used to keep Dave at least
	## 5 squares from the sides of the map
	_calculate_offset()

	## Quit variable
	var program_quit := false
	
	## Initialise Dave's movement
	var player_right := false
	var player_left := false
	var player_up := false 
	var player_down := false
	var player_dir := Direction.STILL
	game_state.player_moving = Direction.STILL
	
	## These variables are used for scrolling
	#player_move_counter_horiz = 0
	#scroll_horiz = False
	#scroll_horiz_comp = False
	#player_move_counter_vert = 0
	#scroll_vert = False
	#scroll_vert_comp = False

	## These variables are used for animation
	#dave_frame = 0
	#anim_counter = 0
	#dave_wait = 0

## MAIN LOOP
	#while(1):
## Process inputs
		#for event in pygame.event.get():          
			#if event.type == pygame.QUIT or (event.type == pygame.KEYDOWN and event.key == pygame.K_ESCAPE):
				#program_quit = True
#
			#if event.type == pygame.KEYDOWN:
				#if event.key == game_state.keys[0]:
					#player_right = 1
					##player_left = 0
				#if event.key == game_state.keys[1]:
					##player_right = 0
					#player_left = 1
				#if event.key == game_state.keys[2]:
					#player_up = 1
					##player_down = 0
				#if event.key == game_state.keys[3]:
					##player_up = 0
					#player_down = 1
				#if event.key == game_state.keys[4]:
					#game_state.use_key = True
					#
				#if event.key == pygame.K_TAB:
					#game_state.use_key = False
					#player_right = player_left = player_up = player_down = 0
					#if status_screen() == False:
						#program_quit = True
#
				##if event.key == pygame.K_w:
				##    return True
#
			#if event.type == pygame.KEYUP:
				#if event.key == game_state.keys[0]:
					#player_right = 0
					##player_left = 0
				#if event.key == game_state.keys[1]:
					##player_right = 0
					#player_left = 0
				#if event.key == game_state.keys[2]:
					#player_up = 0
					##player_down = 0
				#if event.key == game_state.keys[3]:
					##player_up = 0
					#player_down = 0
				#if event.key == game_state.keys[4]:
					#game_state.use_key = False
#
		#if player_right:
			#player_dir = game_state.EAST
		#elif player_left:
			#player_dir = game_state.WEST
		#elif player_up:
			#player_dir = game_state.NORTH
		#elif player_down:
			#player_dir = game_state.SOUTH
		#else:
			#player_dir = 0
			#
## Exit to menu
		#if program_quit == True:
			#game_state.bg_col = 150, 150, 255
			#screen.fill(game_state.bg_col)
#
			#render_text('Quit Y/N?', 240)
#
			#pygame.display.flip()
			#while(1):
				#wait_event = pygame.event.wait()
				#if wait_event.type == pygame.KEYDOWN:
					#if wait_event.key == pygame.K_y:
						#return False
					#elif wait_event.key == pygame.K_n:
						#program_quit = False
						#break
					#else:
						#pass
			#
#
		#
		#
## Move Player
		#if not game_state.player_moving:
			#
			#if player_dir == game_state.EAST and game_state.dave_x < game_state.LEVEL_WIDTH - 1:
				#if game_state.game_map[game_state.dave_x + 1][game_state.dave_y].solid == False:
					#
					#game_state.player_moving = game_state.EAST
					#game_state.dave_dest_x, game_state.dave_dest_y = game_state.dave_x + 1, game_state.dave_y
					#
					#if game_state.dave_x - game_state.x_offset > 8 and game_state.x_offset < game_state.LEVEL_WIDTH - 16:
						##game_state.x_offset += 1
						#scroll_horiz = True
		## Push Horizontally
				#elif game_state.game_map[game_state.dave_x + 1][game_state.dave_y].h_push == True \
						#and game_state.dave_x < game_state.LEVEL_WIDTH - 2 \
						#and game_state.game_map[game_state.dave_x + 2][game_state.dave_y].check_squash(game_state.game_map[game_state.dave_x + 1][game_state.dave_y]) == True:
						##and game_state.game_map[game_state.dave_x + 2][game_state.dave_y].squash == True:
#
						##game_state.game_map[game_state.dave_x + 2][game_state.dave_y].move_speed = 0
						#move(game_state.EAST,
							 #game_state.game_map[game_state.dave_x + 1][game_state.dave_y],
							 #game_state.dave_x + 1, game_state.dave_y)
#
						#game_state.player_moving = game_state.EAST
						#game_state.dave_dest_x, game_state.dave_dest_y = game_state.dave_x + 1, game_state.dave_y
						#
						#if game_state.dave_x - game_state.x_offset > 8 and game_state.x_offset < game_state.LEVEL_WIDTH - 16:
							##game_state.x_offset += 1
							#scroll_horiz = True
#
					#
			#if player_dir == game_state.WEST and game_state.dave_x > 0:
				#if game_state.game_map[game_state.dave_x - 1][game_state.dave_y].solid == False:
#
					#game_state.player_moving = game_state.WEST
					#game_state.dave_dest_x, game_state.dave_dest_y = game_state.dave_x - 1, game_state.dave_y
					#
					#if game_state.dave_x - game_state.x_offset < 7 and game_state.x_offset > 0:
						#scroll_horiz = True
						#scroll_horiz_comp = True
#
			 ## Push Horizontally
				#elif game_state.game_map[game_state.dave_x - 1][game_state.dave_y].h_push == True \
						#and game_state.dave_x > 1 \
						#and game_state.game_map[game_state.dave_x - 2][game_state.dave_y].check_squash(game_state.game_map[game_state.dave_x - 1][game_state.dave_y]) == True:
						##and game_state.game_map[game_state.dave_x - 2][game_state.dave_y].squash == True:
							#
						##game_state.game_map[game_state.dave_x - 2][game_state.dave_y].move_speed = 0
						#move(game_state.WEST,
							 #game_state.game_map[game_state.dave_x - 1][game_state.dave_y],
							 #game_state.dave_x - 1, game_state.dave_y)
#
						#game_state.player_moving = game_state.WEST
						#game_state.dave_dest_x, game_state.dave_dest_y = game_state.dave_x - 1, game_state.dave_y
						#
						#if game_state.dave_x - game_state.x_offset < 7 and game_state.x_offset > 0:
							#scroll_horiz = True
							#scroll_horiz_comp = True
#
				#
			#if player_dir == game_state.NORTH and game_state.dave_y > 0:
				#if game_state.game_map[game_state.dave_x][game_state.dave_y - 1].solid == False:
#
					#game_state.player_moving = game_state.NORTH
					#game_state.dave_dest_x, game_state.dave_dest_y = game_state.dave_x, game_state.dave_y - 1
#
					#
					#if game_state.dave_y - game_state.y_offset < 5 and game_state.y_offset > 0:
						##game_state.y_offset -= 1
						#scroll_vert = True
						#scroll_vert_comp = True
#
			 ## Push Vertically
				#elif game_state.game_map[game_state.dave_x][game_state.dave_y - 1].v_push == True \
						#and game_state.dave_y > 1 \
						#and game_state.game_map[game_state.dave_x][game_state.dave_y - 2].check_squash(game_state.game_map[game_state.dave_x][game_state.dave_y - 1]) == True:
#
						##game_state.game_map[game_state.dave_x][game_state.dave_y - 2].move_speed = 0
	#
						#move(game_state.NORTH,
							 #game_state.game_map[game_state.dave_x][game_state.dave_y - 1],
							 #game_state.dave_x, game_state.dave_y - 1)
#
						#game_state.player_moving = game_state.NORTH
						#game_state.dave_dest_x, game_state.dave_dest_y = game_state.dave_x, game_state.dave_y - 1
#
						#
						#if game_state.dave_y - game_state.y_offset < 5 and game_state.y_offset > 0:
							##game_state.y_offset -= 1
							#scroll_vert = True
							#scroll_vert_comp = True
					#
			#if player_dir == game_state.SOUTH and game_state.dave_y < game_state.LEVEL_HEIGHT - 1:
				#if game_state.game_map[game_state.dave_x][game_state.dave_y + 1].solid == False:
#
					#game_state.player_moving = game_state.SOUTH
					#game_state.dave_dest_x, game_state.dave_dest_y = game_state.dave_x, game_state.dave_y + 1
					#
					#if game_state.dave_y - game_state.y_offset > 6 and game_state.y_offset < game_state.LEVEL_HEIGHT - 12:
						##game_state.y_offset += 1
						#scroll_vert = True
#
			 ## Push Vertically
				#elif game_state.game_map[game_state.dave_x][game_state.dave_y + 1].v_push == True \
						#and game_state.dave_y < game_state.LEVEL_HEIGHT - 2 \
						#and game_state.game_map[game_state.dave_x][game_state.dave_y + 2].check_squash(game_state.game_map[game_state.dave_x][game_state.dave_y + 1]) == True:
#
						##game_state.game_map[game_state.dave_x][game_state.dave_y + 2].move_speed = 0
#
						#move(game_state.SOUTH,
							 #game_state.game_map[game_state.dave_x][game_state.dave_y + 1],
							 #game_state.dave_x, game_state.dave_y + 1)
#
						#game_state.player_moving = game_state.SOUTH
						#game_state.dave_dest_x, game_state.dave_dest_y = game_state.dave_x, game_state.dave_y + 1
						#
						#if game_state.dave_y - game_state.y_offset > 6 and game_state.y_offset < game_state.LEVEL_HEIGHT - 12:
							##game_state.y_offset += 1
							#scroll_vert = True
					#
#
		#if game_state.player_moving == game_state.EAST:
			#player_move_counter_horiz += 1
			#
			#if anim_counter == 0:
				#dave_frame +=1
			#if dave_frame > 4:
				#dave_frame = 1
			#dave_wait = 10
			#
			#if player_move_counter_horiz == 4:
				#player_move_counter_horiz = 0
				#game_state.player_moving = 0
				#game_state.dave_x += 1
								#
				#if scroll_horiz:
					#scroll_horiz = False
					#game_state.x_offset += 1
					#
## Let Dave hit objects
				#if game_state.game_map[game_state.dave_x][game_state.dave_y].solid == False:
					#Dave_hit()
#
				#
		#if game_state.player_moving == game_state.WEST:
			#player_move_counter_horiz -= 1
			#
			#if dave_frame < 4:
				#dave_frame = 4
			#if anim_counter == 0:
				#dave_frame +=1
			#if dave_frame > 8:
				#dave_frame = 5
			#dave_wait = 10
			#
			#if player_move_counter_horiz == -4:
				#player_move_counter_horiz = 0
				#game_state.player_moving = 0
				#game_state.dave_x -= 1
				#
				#if scroll_horiz:
					#scroll_horiz = False
					#scroll_horiz_comp = False
					#game_state.x_offset -= 1
					#
## Let Dave hit objects
				#if game_state.game_map[game_state.dave_x][game_state.dave_y].solid == False:
					#Dave_hit()
#
#
		#if game_state.player_moving == game_state.NORTH:
			#player_move_counter_vert -= 1
#
			#if dave_frame < 11:
				#dave_frame = 11
			#if anim_counter == 0:
				#dave_frame +=1
			#if dave_frame > 12:
				#dave_frame = 11
			#dave_wait = 10
#
			#if player_move_counter_vert == -4:
				#player_move_counter_vert = 0
				#game_state.player_moving = 0
				#game_state.dave_y -= 1
				#
				#if scroll_vert:
					#scroll_vert = False
					#scroll_vert_comp = False
					#game_state.y_offset -= 1
					#
## Let Dave hit objects
				#if game_state.game_map[game_state.dave_x][game_state.dave_y].solid == False:
					#Dave_hit()
				#
#
		#if game_state.player_moving == game_state.SOUTH:
			#player_move_counter_vert += 1
#
			#if dave_frame < 9:
				#dave_frame = 9
			#if anim_counter == 0:
				#dave_frame +=1
			#if dave_frame > 10:
				#dave_frame = 9
			#dave_wait = 10
#
			#if player_move_counter_vert == 4:
				#player_move_counter_vert = 0
				#game_state.player_moving = 0
				#game_state.dave_y += 1
				#
				#if scroll_vert:
					#scroll_vert = False
					#game_state.y_offset += 1
					#
## Let Dave hit objects
				#if game_state.game_map[game_state.dave_x][game_state.dave_y].solid == False:
					#Dave_hit()
				#
## If Dave's standing still (but not just moved) hit objects beneath him
		#if dave_wait < 8:
			#Dave_hit()
#
#
## Perform sprite actions
#
		#for y_counter in range(game_state.LEVEL_HEIGHT): 
			#for x_counter in range(game_state.LEVEL_WIDTH):
			   #
				#current_sprite = game_state.game_map[x_counter][y_counter]
#
				#if x_counter == game_state.dave_x and y_counter == game_state.dave_y and current_sprite.solid == False:
					#Dave_hit()
#
				## Animate sprite
				#if current_sprite.animation != 0:
					#if current_sprite.anim_timer < current_sprite.animation[current_sprite.anim_frame][1] - 1:
						#current_sprite.anim_timer += 1
					#else:
						#current_sprite.anim_timer = 0
						#current_sprite.anim_frame += 1
						#if current_sprite.anim_frame == len(current_sprite.animation):
							#current_sprite.anim_frame = 0
							#
					#current_sprite.sprite = current_sprite.animation[current_sprite.anim_frame][0]
						#
#
				#if current_sprite.ignore == False:
					#
					#current_sprite.action()
					#
					#if current_sprite.moved > 0:
						#current_sprite.moved = 0
				#else:
					#current_sprite.ignore = False
#
				#if current_sprite.moving > 0:
					#current_sprite.move_counter += current_sprite.move_speed
					#if current_sprite.move_counter > 3:
						#
						#if current_sprite.moving == game_state.NORTH:
#
							#hitting_object = game_state.game_map[x_counter][y_counter - 1]
#
							#game_state.game_map[x_counter][y_counter - 1] = copy.deepcopy(game_state.game_map[x_counter][y_counter])
							#game_state.game_map[x_counter][y_counter] = copy.deepcopy(game_objects[0])
							##game_state.game_map[x_counter][y_counter - 1].ignore = True
							#game_state.game_map[x_counter][y_counter - 1].x = x_counter
							#game_state.game_map[x_counter][y_counter - 1].y = y_counter - 1
							#game_state.game_map[x_counter][y_counter - 1].move_counter = 0
							#game_state.game_map[x_counter][y_counter - 1].moving = 0
							#
							#game_state.game_map[x_counter][y_counter - 1].moved = game_state.NORTH
							## Blank above line and uncomment below if multiple Repton shuffles shouldn't kill
							##if y_counter > 1 and \
							##   game_state.game_map[x_counter][y_counter-2].gobject == 0:
							##    game_state.game_map[x_counter][y_counter-1].moved = game_state.NORTH
#
							#hitting_object.hit(game_state.game_map[x_counter][y_counter - 1])
#
							#if hitting_object.moving:
								#if hitting_object.forward == game_state.NORTH:
									##game_state.game_map[x_counter][y_counter - 2] = copy.deepcopy(game_objects[game_state.game_map[x_counter][y_counter - 2].gobject])
									#reset_flags(x_counter, y_counter - 2)
								#elif hitting_object.forward == game_state.EAST:
									##game_state.game_map[x_counter+1][y_counter - 1] = copy.deepcopy(game_objects[game_state.game_map[x_counter+1][y_counter - 1].gobject])
									#reset_flags(x_counter + 1, y_counter - 1)
								#elif hitting_object.forward == game_state.SOUTH:
									##game_state.game_map[x_counter][y_counter] = copy.deepcopy(game_objects[game_state.game_map[x_counter][y_counter].gobject])
									#reset_flags(x_counter, y_counter)
								#elif hitting_object.forward == game_state.WEST:
									##game_state.game_map[x_counter-1][y_counter - 1] = copy.deepcopy(game_objects[game_state.game_map[x_counter-1][y_counter - 1].gobject])
									#reset_flags(x_counter - 1, y_counter - 1)
#
			   #
						#if current_sprite.moving == game_state.SOUTH:
#
							#hitting_object = game_state.game_map[x_counter][y_counter + 1]
#
							#game_state.game_map[x_counter][y_counter+1] = copy.deepcopy(game_state.game_map[x_counter][y_counter])
##                            game_state.game_map[x_counter][y_counter+1] = copy.deepcopy(game_objects[game_state.game_map[x_counter][y_counter].object])
							#game_state.game_map[x_counter][y_counter] = copy.deepcopy(game_objects[0])
							#game_state.game_map[x_counter][y_counter+1].ignore = True
							#game_state.game_map[x_counter][y_counter+1].x = x_counter
							#game_state.game_map[x_counter][y_counter+1].y = y_counter + 1
							#game_state.game_map[x_counter][y_counter+1].move_counter = 0
							#game_state.game_map[x_counter][y_counter+1].moving = 0
							#
							#game_state.game_map[x_counter][y_counter+1].moved = game_state.SOUTH
							## Blank above line and uncomment below if multiple Repton shuffles shouldn't kill
							##if y_counter < game_state.LEVEL_WIDTH - 2 and \
							##   game_state.game_map[x_counter][y_counter+2].gobject == 0:
							##    game_state.game_map[x_counter][y_counter+1].moved = game_state.SOUTH
#
							#hitting_object.hit(game_state.game_map[x_counter][y_counter + 1])
				#
							#if hitting_object.moving:
								#if hitting_object.forward == game_state.NORTH:
									##game_state.game_map[x_counter][y_counter] = copy.deepcopy(game_objects[game_state.game_map[x_counter][y_counter].gobject])
									#reset_flags(x_counter, y_counter)
								#elif hitting_object.forward == game_state.EAST:
									##game_state.game_map[x_counter+1][y_counter + 1] = copy.deepcopy(game_objects[game_state.game_map[x_counter+1][y_counter + 1].gobject])
									#reset_flags(x_counter + 1, y_counter + 1)
								#elif hitting_object.forward == game_state.SOUTH:
									##game_state.game_map[x_counter][y_counter + 2] = copy.deepcopy(game_objects[game_state.game_map[x_counter][y_counter + 2].gobject])
									#reset_flags(x_counter, y_counter + 2)
								#elif hitting_object.forward == game_state.WEST:
									##game_state.game_map[x_counter-1][y_counter + 1] = copy.deepcopy(game_objects[game_state.game_map[x_counter-1][y_counter + 1].gobject])
									#reset_flags(x_counter - 1, y_counter + 1)
#
#
						#if current_sprite.moving == game_state.EAST:
#
							#hitting_object = game_state.game_map[x_counter + 1][y_counter]
#
							#game_state.game_map[x_counter + 1][y_counter] = copy.deepcopy(game_state.game_map[x_counter][y_counter])
##                            game_state.game_map[x_counter+1][y_counter] = copy.deepcopy(game_objects[game_state.game_map[x_counter][y_counter].object])
							#game_state.game_map[x_counter][y_counter] = copy.deepcopy(game_objects[0])
							#game_state.game_map[x_counter+1][y_counter].ignore = True
							#game_state.game_map[x_counter+1][y_counter].x = x_counter + 1
							#game_state.game_map[x_counter+1][y_counter].y = y_counter
							#game_state.game_map[x_counter + 1][y_counter].move_counter = 0
							#game_state.game_map[x_counter + 1][y_counter].moving = 0
							#
							#game_state.game_map[x_counter + 1][y_counter].moved = game_state.EAST
							## Blank above line and uncomment below if multiple Repton shuffles shouldn't kill
							##if x_counter < game_state.LEVEL_HEIGHT - 2 and \
							##   game_state.game_map[x_counter + 2][y_counter].gobject == 0:
							##    game_state.game_map[x_counter + 1][y_counter].moved = game_state.EAST
#
							#hitting_object.hit(game_state.game_map[x_counter + 1][y_counter])
#
				#
							#if hitting_object.moving:
								#if hitting_object.forward == game_state.NORTH:
									##game_state.game_map[x_counter + 1][y_counter-1] = copy.deepcopy(game_objects[game_state.game_map[x_counter + 1][y_counter-1].gobject])
									#reset_flags(x_counter + 1, y_counter - 1)
								#elif hitting_object.forward == game_state.EAST:
									##game_state.game_map[x_counter + 2][y_counter] = copy.deepcopy(game_objects[game_state.game_map[x_counter + 2][y_counter].gobject])
									#reset_flags(x_counter + 2, y_counter)
								#elif hitting_object.forward == game_state.SOUTH:
									##game_state.game_map[x_counter + 1][y_counter+1] = copy.deepcopy(game_objects[game_state.game_map[x_counter + 1][y_counter+1].gobject])
									#reset_flags(x_counter + 1, y_counter + 1)
								#elif hitting_object.forward == game_state.WEST:
									##game_state.game_map[x_counter][y_counter] = copy.deepcopy(game_objects[game_state.game_map[x_counter][y_counter].gobject])
									#reset_flags(x_counter, y_counter)
#
				   #
						#if current_sprite.moving == game_state.WEST:
#
							#hitting_object = game_state.game_map[x_counter - 1][y_counter]
#
							#game_state.game_map[x_counter - 1][y_counter] = copy.deepcopy(game_state.game_map[x_counter][y_counter])
##                            game_state.game_map[x_counter-1][y_counter] = copy.deepcopy(game_objects[game_state.game_map[x_counter][y_counter].object])
							#game_state.game_map[x_counter][y_counter] = copy.deepcopy(game_objects[0])
							##game_state.game_map[x_counter - 1][y_counter].ignore = True
							#game_state.game_map[x_counter - 1][y_counter].x = x_counter - 1
							#game_state.game_map[x_counter - 1][y_counter].y = y_counter
							#game_state.game_map[x_counter - 1][y_counter].move_counter = 0
							#game_state.game_map[x_counter - 1][y_counter].moving = 0
							#
							#game_state.game_map[x_counter - 1][y_counter].moved = game_state.WEST
							## Blank above line and uncomment below if multiple Repton shuffles shouldn't kill
							##if x_counter > 1 and \
							##   game_state.game_map[x_counter - 2][y_counter].gobject == 0:
							##    game_state.game_map[x_counter - 1][y_counter].moved = game_state.WEST
#
							#hitting_object.hit(game_state.game_map[x_counter - 1][y_counter])
				#
							#if hitting_object.moving:
								#if hitting_object.forward == game_state.NORTH:
									##game_state.game_map[x_counter - 1][y_counter-1] = copy.deepcopy(game_objects[game_state.game_map[x_counter - 1][y_counter-1].gobject])
									#reset_flags(x_counter - 1, y_counter - 1)
								#elif hitting_object.forward == game_state.EAST:
									##game_state.game_map[x_counter][y_counter] = copy.deepcopy(game_objects[game_state.game_map[x_counter][y_counter].gobject])
									#reset_flags(x_counter, y_counter)
								#elif hitting_object.forward == game_state.SOUTH:
									##game_state.game_map[x_counter - 1][y_counter+1] = copy.deepcopy(game_objects[game_state.game_map[x_counter - 1][y_counter+1].gobject])
									#reset_flags(x_counter - 1, y_counter + 1)
								#elif hitting_object.forward == game_state.WEST:
									##game_state.game_map[x_counter - 2][y_counter] = copy.deepcopy(game_objects[game_state.game_map[x_counter - 2][y_counter].gobject])
									#reset_flags(x_counter - 2, y_counter)
#
## Kill Dave: oh no!
						#
		#if game_state.kill_dave == True:
			#game_state.kill_dave = False
			#game_state.lives -= 1
			#
			#game_state.use_key = False
			#player_right = player_left = player_up = player_down = 0
			#game_state.dave_x = game_state.dave_dest_x = game_data.dave_pos[game_state.level_number][0]
			#game_state.dave_y = game_state.dave_dest_y = game_data.dave_pos[game_state.level_number][1]
			#player_move_counter_horiz = player_move_counter_vert = 0
			#game_state.player_moving = 0
			#scroll_horiz = scroll_vert = False
#
			#game_state.transporting = False
			#if game_state.min_score_hit == True:
				#game_state.bg_col = 255, 220, 150
			#else:
				#game_state.bg_col = 150, 150, 255
#
			#game_state.x_offset = game_state.dave_x - 5
			#if game_state.x_offset < 0:
				#game_state.x_offset = 0
			#if game_state.x_offset > game_state.LEVEL_WIDTH - 16:
				#game_state.x_offset = game_state.LEVEL_WIDTH - 16
				#
			#game_state.y_offset = game_state.dave_y - 5
			#if game_state.y_offset < 0:
				#game_state.y_offset = 0
			#if game_state.y_offset > game_state.LEVEL_HEIGHT - 12:
				#game_state.y_offset = game_state.LEVEL_HEIGHT - 12
			#
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
#
## Draw player
		#player_rect.left = (game_state.dave_x - game_state.x_offset) * 40 + (player_move_counter_horiz * 10) * (not scroll_horiz)
		#player_rect.top = (game_state.dave_y - game_state.y_offset) * 40 + (player_move_counter_vert * 10) * (not scroll_vert) 
		#screen.blit(sprite_dave[dave_frame], player_rect)
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
			#
		#
		#pygame.display.flip()
		#frames += 1
#
		#if dave_wait > 0:
			#dave_wait -= 1
		#elif dave_wait == 0:
			#dave_frame = 0
#
		#
		#anim_counter += 1
		#if anim_counter > 2:
			#anim_counter = 0
#
#
#
## Dave action function is used for any goal checks etc.
		#Dave().action()
#
## If minimum score hit, set game_state.min_score_hit flag
		#if game_state.score > game_data.minimum_score[game_state.level_number] - 1:
			#game_state.min_score_hit = True
## If level has been completed, this flag will be set
		#if game_state.level_finished:
			#return True
#
		#
		#GameClock.tick(30)
#
	#print "fps:  %d" % ((frames*1000)/(pygame.time.get_ticks()-ticks))
#
	#return True


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


## These variables are used to keep Dave at least
## 5 squares from the sides of the map
func _calculate_offset() -> void:  #TODO
	game_state.x_offset = game_state.dave_x - 5
	if game_state.x_offset < 0:
		game_state.x_offset = 0
	if game_state.x_offset > game_state.LEVEL_WIDTH - 16:
		game_state.x_offset = game_state.LEVEL_WIDTH - 16
		
	game_state.y_offset = game_state.dave_y - 5
	if game_state.y_offset < 0:
		game_state.y_offset = 0
	if game_state.y_offset > game_state.LEVEL_HEIGHT - 12:
		game_state.y_offset = game_state.LEVEL_HEIGHT - 12
