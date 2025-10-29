#script game.gd
extends Node
## Handles playing the built-in levelsets.
##
## The scene handles the user selecting and playing one of the
## built in level sets, including losing lives, game over or
## game completion screen.

var episode_data: EpisodeData
var game_objects: Array[String]
var game_state: GameState
var game_filename: String
var intro_text: Array[String]
var outro_text: Array[String]

var escape_pressed:bool 

func _init() -> void:
	game_state = GameState.new()
	
	game_state.score = 0
	game_state.min_score_hit = false
	game_state.level_finished = false


func _ready() -> void:
	await select_episode()
	
	if game_filename.is_empty():
		_go_to_title_screen()
		return

	load_episode()
	load_definitions()
	update_game_state()
	
	await show_intro_screen()
	await show_status_screen()
	
	# GAME LOOP
	game_loop()
	
	
func select_episode() -> void:
	# This shows the select episode screen and waits for a keypress
	$SelectEpisode.show()
	var episode_metadata:EpisodeMetadata = await $SelectEpisode.episode
	
	# This handles ESCAPE being pressed on the select episode screen
	game_filename = episode_metadata.game_filename
	if game_filename.is_empty():
		return
	
	# This handles a number key being pressed on the select episode screen
	intro_text = episode_metadata.intro_text
	outro_text = episode_metadata.outro_text
	game_state.message = game_state.default_message


func load_episode() -> void:
	episode_data = load(game_filename)


func load_definitions() -> void:
	# FIXME Temporary until we can sort this out
	game_objects = Claptraps.game_objects


func update_game_state() -> void:
	game_state.lives = 3
	game_state.score = 0
	game_state.level_number = 0
	game_state.minimum_score = _minimum_score()


func show_intro_screen() -> void:
	$IntroScreen.init(intro_text)
	$IntroScreen.show()

	if game_state.play_music:
		$TwiddlePlayer.play()

	$IntroScreen.set_process_input(true)
	escape_pressed = await $IntroScreen.escape_pressed
	if escape_pressed:
		call_deferred("_go_to_title_screen")	
	
	$IntroScreen.set_process_input(false)
	$IntroScreen.hide()


func show_status_screen() -> void:
	$StatusScreen.init(game_state)
	$StatusScreen.show()
	
	$StatusScreen.set_process_input(true)
	escape_pressed = await $StatusScreen.escape_pressed
	if escape_pressed:
		call_deferred("_go_to_title_screen")
		
	$StatusScreen.set_process_input(false)
	$StatusScreen.hide()


func game_loop() -> void:

	while true:

		## Play music
		if game_state.play_music:
			$GameTunePlayer.play()
		
		## $PlayLevel plays a single level, returning true or false
		var is_completed:bool
		is_completed = await $PlayLevel.completed
		
		## Stop music        
		$GameTunePlayer.stop()
		
		if not is_completed:
			## Lost all ives without completing level, 
			## so show Retry screen
			var retry:bool
			retry = await $RetryScreen.retry_asked
			if retry:
				game_state.lives = 3
				game_state.score = 0
				game_state.message = game_state.default_message
			else:
				_go_to_title_screen()

			## Show the status screen. If you press escape, go to title screen
			show_status_screen()
			
		else:
			## Add 1 to level number, reset the score
			game_state.level_number += 1
			game_state.score = 0
			
			## If you have completed all of the levels, show outro screen
				#if game_state.level_number > len(game_data.level_map) - 1:
				#game_state.bg_col = 150, 150, 255
				#screen.fill(game_state.bg_col)
				#render_text(outro_text[0], 180)
				#render_text(outro_text[1], 220)
				#render_text(outro_text[2], 260)
				#render_text(outro_text[3], 300)
				#pygame.display.flip()
				#if game_state.play_music:
					#sound_twiddle.play()
				#
				#while(1):
					#wait_event = pygame.event.wait()
					#if wait_event.type == pygame.KEYDOWN:
						#if wait_event.key == pygame.K_SPACE:
							#break
						#else:
							#pass
				#break
			## Draw the level complete screen
			#prompt_rect = pygame.Rect(0, 0, 300, 100)
			#prompt_rect.centerx = screen.get_rect().centerx
			#prompt_rect.centery = screen.get_rect().centery
			#pygame.draw.rect(screen, (0, 0, 0), prompt_rect)
			#render_text('Level Complete!', 210)
			#render_text('Press Space', 270)
			#pygame.display.flip()
			#if game_state.play_music:
				#sound_twiddle.play()
			#while(1):
				#wait_event = pygame.event.wait()
				#if wait_event.type == pygame.KEYDOWN:
					#if wait_event.key == pygame.K_SPACE:
						#
						#break
					#else:
						#pass
						
			## Show the status screen. If you press escape, go to title screen
			#if status_screen() == False:
				#break

func _minimum_score() -> int:
	return episode_data.levels[game_state.level_number].minimum_score


func _go_to_title_screen() -> void:
	get_tree().change_scene_to_file(
		"res://scenes/title_screen/title_screen.tscn"
	)
