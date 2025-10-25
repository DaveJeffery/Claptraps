class_name GameFunctions
extends Node

static var game_state: GameState
static var game_objects: GameObjects
static var dave: Dave #TODO This will need to be the *actual* Dave for hitby
static var wall: Wall

static var direction_offsets: Dictionary[int, Vector2i]

static func init(
	_game_state: GameState, 
	_game_objects: GameObjects,
) -> void:
	game_state = _game_state
	game_objects = _game_objects
	dave = Dave.new(game_state)
	wall = Wall.new(game_state)


static func look(direction: Direction, position: Vector2i) -> Thing:
	# Find the position to look at
	var target_pos = position + direction.forward

	# Semantic checks
	var target_cell := _get_cell(target_pos)

	if not target_cell is Blank:
		return target_cell
	elif (
		game_state.dave_pos == target_pos 
		or game_state.dave_dest == target_pos
	):
		return dave
	else:
		return target_cell


static func move(direction: Direction, object: Thing, grid_pos: Vector2i) -> void:
	# Can't move a moving object
	if object.moving != Direction.STILL:
		return

	var target_pos := grid_pos + direction.forward
	var target: Thing = _get_cell(target_pos)
	object.moving = direction
	
	# Handle collisions
	if target.being_moved_into != Direction.STILL:
		var hitting_object := target
		var move_offset := target.being_moved_into
		var destination_pos := target_pos + move_offset.forward
		var destination := _get_cell(destination_pos)
		
		target = destination
		target.moving = Direction.STILL
		target.grid_pos = target_pos
		destination = Blank.new(game_state)
		
		hitting_object.hit(target)
	
	# Update cell properties
	if target is Blank:
		target.solid = object.solid
		target.squash = object.squash
		target.name = object.name
	
	target.empty = false
	target.being_moved_into = direction.backward
	target.move_speed = 0


static func change(object_from: String, object_to: String) -> void:

	for x_pos in range(game_state.LEVEL_WIDTH):
		for y_pos in range(game_state.LEVEL_HEIGHT):
			var pos := Vector2i(x_pos, y_pos)
			var target: Thing = _get_cell(pos)
			
			if target.game_object_name == object_from:
				
				# Handle movement
				if target.moving != Direction.STILL:
					
					#If the target cell is moving...
					# Set the cell it is moving to to a copy of the cell it is moving to
					# reset the  cell to its original, default state
						
					var adjacent_pos := pos + target.moving.forward
					var adjacent_content := _get_cell(adjacent_pos).game_object_name
					_set_cell(adjacent_pos, adjacent_content)

				# Change target cell to the new Thing type
				_set_cell(pos, object_to)



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

static func _get_cell(position: Vector2i) -> Thing:
	var x := position.x
	var y := position.y
	
	# Out-of-bounds check: return wall if outside the map
	if (
		x < 0 
		or x >= game_state.level_size.x
		or y < 0 
		or y >= game_state.level_size.y
	):
		return wall
	
	return game_state.game_map[x][y]

static func _set_cell(position: Vector2i, object_name: String) -> void:
	var x := position.x
	var y := position.y

	# Out-of-bounds check
	if (
		x < 0 
		or x >= game_state.level_size.x
		or y < 0 
		or y >= game_state.level_size.y
	):
		return

	var object_type = game_objects.get(object_name)
	if object_type == null:
		push_warning("Unknown object_name '%s' at position %s" % [object_name, position])
		return

	var object: Thing = object_type.new(game_state)
	object.grid_pos = position
	game_state.game_map[x][y] = object
