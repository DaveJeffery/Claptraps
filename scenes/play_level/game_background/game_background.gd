class_name GameBackground
extends ColorRect

@onready var tween := create_tween()

const PEACH := Color(1.0, 0.8627, 0.6) # Peach
const BLUE := Color(0.588, 0.588, 1.0)    # Original blue

var game_state: GameState


func _ready() -> void:
	# Optional: start as blue
	color = BLUE

func _process(_delta: float) -> void:
	if game_state.min_score_hit:
		# Fade to peach if not already tweening
		if tween.is_active() == false and color != PEACH:
			tween.tween_property(self, "color", PEACH, 1.5) # 1.5 seconds fade
	else:
		# Fade back to blue if needed
		if tween.is_active() == false and color != BLUE:
			tween.tween_property(self, "color", BLUE, 1.5)

func setup(current_game_state: GameState) -> void:
	game_state = current_game_state
