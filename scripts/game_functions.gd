class_name GameFunctions
extends Node

static var game_state: GameState
#static var game_objects: GameObjects
static var dave: Dave #TODO This will need to be the *actual* Dave for hitby
static var wall: Wall

static var direction_offsets: Dictionary[int, Vector2i]

static func init(
	gs: GameState, 
	#go: GameObjects,
) -> void:
	game_state = gs
	#game_objects = go
	dave = Dave.new(game_state)
	wall = Wall.new(game_state)
	
	direction_offsets = {
		game_state.EAST: Vector2i(1, 0),
		game_state.WEST: Vector2i(-1, 0),
		game_state.NORTH: Vector2i(0, -1),
		game_state.SOUTH: Vector2i(0, 1),
		game_state.NORTHEAST: Vector2i(1, -1),
		game_state.NORTHWEST: Vector2i(-1, -1),
		game_state.SOUTHEAST: Vector2i(1, 1),
		game_state.SOUTHWEST: Vector2i(-1, 1),
	}


static func look(direction: int, position: Vector2i) -> Thing:
	# Look up the offset; default to zero if unknown direction
	var offset: Vector2i = direction_offsets.get(direction, Vector2i.ZERO)
	var target_pos = position + offset

	# Semantic checks
	var target_cell := _get_cell(target_pos.x, target_pos.y)

	if not target_cell is Blank:
		return target_cell
	elif (
		game_state.dave_pos == target_pos 
		or game_state.dave_dest == target_pos
	):
		return dave
	else:
		return target_cell


static func move(direction: int, object: Thing, grid_pos: Vector2i) -> void:
	if object.moving != 0:
		return
	
	var x := grid_pos.x
	var y := grid_pos.y
	
	var direction_map := {
		game_state.NORTH: { 
			"offset": game_state.NORTH, 
			"opposite": game_state.SOUTH, 
			"left": game_state.WEST, 
			"right": game_state.EAST, 
		},
		game_state.SOUTH: { 
			"offset": game_state.SOUTH,  
			"opposite": game_state.NORTH, 
			"left": game_state.EAST, 
			"right": game_state.WEST, 
		},
		game_state.EAST:  { 
			"offset": game_state.EAST,  
			"opposite": game_state.WEST,  
			"left": game_state.NORTH, 
			"right": game_state.SOUTH, 
		},
		game_state.WEST:  { 
			"offset": game_state.WEST,
			"opposite": game_state.EAST,  
			"left": game_state.SOUTH, 
			"right": game_state.NORTH, 
		},
	}
	
	var dir_data = direction_map[direction]
	var offset = dir_data["offset"]
	var target = _get_cell(x + offset.x, y + offset.y)
	object.moving = direction
	
	# Handle collisions
	if target.being_moved_into > 0:
		var hitting_object = target
		var move_offset := Vector2i.ZERO
		
		match target.being_moved_into:
			game_state.NORTH:
				move_offset = Vector2i(0, -1)
			game_state.SOUTH:
				move_offset = Vector2i(0, 1)
			game_state.EAST:
				move_offset = Vector2i(1, 0)
			game_state.WEST:
				move_offset = Vector2i(-1, 0)
		
		var destination = _get_cell(x + offset.x + move_offset.x, y + offset.y + move_offset.y)
		target = destination
		target.moving = 0
		target.grid_pos = Vector2i(x + offset.x, y + offset.y)
		destination = Blank.new(game_state)
		
		hitting_object.hit(target)
	
	# Update cell properties
	if target is Blank:
		target.solid = object.solid
		target.squash = object.squash
		target.name = object.name
	
	target.empty = false
	target.being_moved_into = dir_data["opposite"]
	target.move_speed = 0
	
	object.forward = direction
	object.backward = dir_data["opposite"]
	object.left = dir_data["left"]
	object.right = dir_data["right"]





static func change(obj1: Thing, obj2: Thing) -> void:
	pass
	#for x_counter in range(game_state.LEVEL_WIDTH):
		#for y_counter in range(game_state.LEVEL_HEIGHT):
			#if game_state.game_map[x_counter][y_counter].game_object == game_state.obj_names[obj1]:
				#
				#if game_state.game_map[x_counter][y_counter].moving:
					#if game_state.game_map[x_counter][y_counter].forward == game_state.NORTH:
						#game_state.game_map[x_counter][y_counter-1] = copy.deepcopy(game_objects[game_state.game_map[x_counter][y_counter-1].game_object])
					#elif game_state.game_map[x_counter][y_counter].forward == game_state.EAST:
						#game_state.game_map[x_counter+1][y_counter] = copy.deepcopy(game_objects[game_state.game_map[x_counter+1][y_counter].game_object])
					#elif game_state.game_map[x_counter][y_counter].forward == game_state.SOUTH:
						#game_state.game_map[x_counter][y_counter+1] = copy.deepcopy(game_objects[game_state.game_map[x_counter][y_counter+1].game_object])
					#elif game_state.game_map[x_counter][y_counter].forward == game_state.WEST:
						#game_state.game_map[x_counter-1][y_counter] = copy.deepcopy(game_objects[game_state.game_map[x_counter-1][y_counter].game_object])
#
				#game_state.game_map[x_counter][y_counter] = copy.deepcopy(game_objects[game_state.obj_names[obj2]])
				#game_state.game_map[x_counter][y_counter].x = x_counter
				#game_state.game_map[x_counter][y_counter].y = y_counter

static func dave_is_to(direction, grid_pos: Vector2i) -> bool:
	return true
	#if direction == game_state.NORTH:
		#if y > game_state.dave_y:
			#return True
#
	#if direction == game_state.SOUTH:
		#if y < game_state.dave_y:
			#return True
#
	#if direction == game_state.EAST:
		#if x < game_state.dave_x:
			#return True
#
	#if direction == game_state.WEST:
		#if x > game_state.dave_x:
			#return True
#
	#return False

static func create(obj: Thing, direction, grid_pos) -> void:
	pass
	#if direction == game_state.NORTH:
		#dx = x
		#dy = y - 1
	#elif direction == game_state.SOUTH:
		#dx = x
		#dy = y + 1
	#elif direction == game_state.EAST:
		#dx = x + 1
		#dy = y
	#elif direction == game_state.WEST:
		#dx = x - 1
		#dy = y
	#elif direction == game_state.NE:
		#dx = x + 1
		#dy = y - 1
	#elif direction == game_state.SE:
		#dx = x + 1
		#dy = y + 1
	#elif direction == game_state.SW:
		#dx = x - 1
		#dy = y + 1
	#elif direction == game_state.NW:
		#dx = x - 1
		#dy = y - 1
	#else:
		#dx = x
		#dy = y
#
	#hitting_object = game_state.game_map[dx][dy]
#
	#if hitting_object.moving:
		#if hitting_object.forward == game_state.NORTH:
			##game_state.game_map[dx][dy - 1] = copy.deepcopy(game_objects[game_state.game_map[dx][dy - 1].game_object])
			#reset_flags(dx, dy-1)
		#elif hitting_object.forward == game_state.EAST:
			##game_state.game_map[dx+1][dy] = copy.deepcopy(game_objects[game_state.game_map[dx+1][dy].game_object])
			#reset_flags(dx + 1, dy)
		#elif hitting_object.forward == game_state.SOUTH:
			##game_state.game_map[dx][dy + 1] = copy.deepcopy(game_objects[game_state.game_map[dx][dy + 1].game_object])
			#reset_flags(dx, dy+1)
		#elif hitting_object.forward == game_state.WEST:
			##game_state.game_map[dx-1][dy] = copy.deepcopy(game_objects[game_state.game_map[dx-1][dy].game_object])
			#reset_flags(dx - 1, dy)
#
			#
	#game_state.game_map[dx][dy] = copy.deepcopy(game_objects[game_state.obj_names[obj]])
	#game_state.game_map[dx][dy].x = dx
	#game_state.game_map[dx][dy].y = dy
#
	#hitting_object.hit(game_state.game_map[dx][dy])
#
	#game_state.game_map[dx][dy].being_moved_into = hitting_object.being_moved_into
	


static func transport(hitby: Thing, tself: Thing, grid_pos: Vector2i) -> void:
	pass
		#if hitby.is_dave:
		#
#
#
			#game_state.transporting = True
			#
#
			#game_state.dave_x = game_state.dave_dest_x = tself.target[0]
			#game_state.dave_y = game_state.dave_dest_y = tself.target[1]
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
			#Dave_hit()
			#
		#else:
			#
			#if game_state.game_map[tself.target[0]][tself.target[1]].being_moved_into > 0:
				#
				#if game_state.game_map[tself.target[0]][tself.target[1]].being_moved_into == game_state.NORTH:
					#game_state.game_map[tself.target[0]][tself.target[1]] = game_state.game_map[tself.target[0]][tself.target[1]-1]
					#game_state.game_map[tself.target[0]][tself.target[1]].moving = 0
					#game_state.game_map[tself.target[0]][tself.target[1]-1] = copy.deepcopy(game_objects[0])
					#
				#if game_state.game_map[tself.target[0]][tself.target[1]].being_moved_into == game_state.EAST:
					#game_state.game_map[tself.target[0]][tself.target[1]] = game_state.game_map[tself.target[0]+1][tself.target[1]]
					#game_state.game_map[tself.target[0]][tself.target[1]].moving = 0
					#game_state.game_map[tself.target[0]+1][tself.target[1]] = copy.deepcopy(game_objects[0])
					#
				#if game_state.game_map[tself.target[0]][tself.target[1]].being_moved_into == game_state.SOUTH:
					#game_state.game_map[tself.target[0]][tself.target[1]] = game_state.game_map[tself.target[0]][tself.target[1]+1]
					#game_state.game_map[tself.target[0]][tself.target[1]].moving = 0
					#game_state.game_map[tself.target[0]][tself.target[1]+1] = copy.deepcopy(game_objects[0])
					#
				#if game_state.game_map[tself.target[0]][tself.target[1]].being_moved_into == game_state.WEST:
					#game_state.game_map[tself.target[0]][tself.target[1]] = game_state.game_map[tself.target[0]-1][tself.target[1]]
					#game_state.game_map[tself.target[0]][tself.target[1]].moving = 0
					#game_state.game_map[tself.target[0]-1][tself.target[1]] = copy.deepcopy(game_objects[0])
					#
			#hitting_object = game_state.game_map[tself.target[0]][tself.target[1]]
#
			## Top line creates a new object, bottom line copies old one
			##game_state.game_map[tself.target[0]][tself.target[1]] = copy.deepcopy(game_objects[hitby.game_object])
			#game_state.game_map[tself.target[0]][tself.target[1]] = copy.deepcopy(game_state.game_map[x][y])
			#game_state.game_map[tself.target[0]][tself.target[1]].x = tself.target[0]
			#game_state.game_map[tself.target[0]][tself.target[1]].y = tself.target[1]
#
			#hitting_object.hit(game_state.game_map[tself.target[0]][tself.target[1]])
#
			#if hitting_object.moving:
				#if hitting_object.forward == game_state.NORTH:
					##game_state.game_map[tself.target[0]][tself.target[1] - 1] = copy.deepcopy(game_objects[game_state.game_map[tself.target[0]][tself.target[1] - 1].game_object])
					#reset_flags(tself.target[0], tself.target[1] - 1)
				#elif hitting_object.forward == game_state.EAST:
					##game_state.game_map[tself.target[0]+1][tself.target[1]] = copy.deepcopy(game_objects[game_state.game_map[tself.target[0]+1][tself.target[1]].game_object])
					#reset_flags(tself.target[0]+1, tself.target[1])
				#elif hitting_object.forward == game_state.SOUTH:
					##game_state.game_map[tself.target[0]][tself.target[1] + 1] = copy.deepcopy(game_objects[game_state.game_map[tself.target[0]][tself.target[1] + 1].game_object])
					#reset_flags(tself.target[0], tself.target[1] + 1)
				#elif hitting_object.forward == game_state.WEST:
					##game_state.game_map[tself.target[0]-1][tself.target[1]] = copy.deepcopy(game_objects[game_state.game_map[tself.target[0]-1][tself.target[1]].game_object])
					#reset_flags(tself.target[0]-1, tself.target[1])

static func reset_flags(grid_pos: Vector2i) -> void:
	pass
	#game_state.game_map[x][y].solid = game_objects[game_state.game_map[x][y].game_object].solid
	#game_state.game_map[x][y].squash = game_objects[game_state.game_map[x][y].game_object].squash
	#game_state.game_map[x][y].name = game_objects[game_state.game_map[x][y].game_object].name
	#game_state.game_map[x][y].empty = game_objects[game_state.game_map[x][y].game_object].empty
	#game_state.game_map[x][y].being_moved_into = 0
	#game_state.game_map[x][y].move_speed = game_objects[game_state.game_map[x][y].game_object].move_speed
	#game_state.game_map[x][y].ignore = False


static func dave_hit() -> void:
	pass
	#hitting_object = game_state.game_map[game_state.dave_x][game_state.dave_y]
#
	#if game_state.game_map[game_state.dave_x][game_state.dave_y].moving:
		#if game_state.game_map[game_state.dave_x][game_state.dave_y].forward == game_state.NORTH:
			##game_state.game_map[game_state.dave_x][game_state.dave_y-1] = copy.deepcopy(game_objects[game_state.game_map[game_state.dave_x][game_state.dave_y-1].game_object])
			#reset_flags(game_state.dave_x, game_state.dave_y - 1)
			#
		#elif game_state.game_map[game_state.dave_x][game_state.dave_y].forward == game_state.EAST:
			##game_state.game_map[game_state.dave_x+1][game_state.dave_y] = copy.deepcopy(game_objects[game_state.game_map[game_state.dave_x+1][game_state.dave_y].game_object])
			#reset_flags(game_state.dave_x + 1, game_state.dave_y)
			#
		#elif game_state.game_map[game_state.dave_x][game_state.dave_y].forward == game_state.SOUTH:
			##game_state.game_map[game_state.dave_x][game_state.dave_y+1] = copy.deepcopy(game_objects[game_state.game_map[game_state.dave_x][game_state.dave_y+1].game_object])
			#reset_flags(game_state.dave_x, game_state.dave_y + 1)
			#
		#elif game_state.game_map[game_state.dave_x][game_state.dave_y].forward == game_state.WEST:
			##game_state.game_map[game_state.dave_x-1][game_state.dave_y] = copy.deepcopy(game_objects[game_state.game_map[game_state.dave_x-1][game_state.dave_y].game_object])
			#reset_flags(game_state.dave_x - 1, game_state.dave_y)
#
#
#
	#game_state.game_map[game_state.dave_x][game_state.dave_y] = copy.deepcopy(game_objects[0])
#
	#hitting_object.hit(Dave())

static func _get_cell(x: int, y: int) -> Thing:
	# Out-of-bounds check: return wall if outside the map
	if (
		x < 0 
		or x >= game_state.level_size.x
		or y < 0 
		or y >= game_state.level_size.y
	):
		return wall
	
	return game_state.game_map[x][y]

static func _set_cell(x: int, y: int, object: Thing) -> void:
	game_state.game_map[x][y] = object
