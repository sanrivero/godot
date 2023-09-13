extends "res://Scripts/States/state.gd"

# The duration of the dash in seconds.
const DASH_DURATION: float = 0.30

# The speed at which the player moves when dashing, measured in pixels per
# second and calculated based on dash duration and dash distance.
var DASH_SPEED: float
var DASH_DISTANCE: float = 100
# The delay between emissions of the dash echo.
var DASH_ECHO_DELAY: float = 0.05

onready var _dash_duration_timer: Timer = Timer.new()
onready var _dash_echo_timer: Timer = Timer.new()

func _ready():
	_dash_duration_timer.wait_time = DASH_DURATION
	_dash_duration_timer.one_shot = true

	# Set up dash echo timer.
	_dash_echo_timer.wait_time = DASH_ECHO_DELAY

	# Calculate dash speed from the specified dash distance and duration.
	DASH_SPEED = DASH_DISTANCE / DASH_DURATION

func enter() -> void:
	print("dash")
	self_anim_name = "run"
	anim_character.play(self_anim_name);
	
	character._start_ghost(0.05)
	_dash_duration_timer.start()
	add_child(_dash_duration_timer)
	
	
	


func handle_input(event) -> void:
	if character.is_in_group("Players"):
		pass


func update(delta) -> void:
	get_direction();
	
	
	
	if _dash_duration_timer.is_stopped():
		character._stop_ghost()
		if character.is_in_air():
			pass
			#Fall state
		else:
			parent.change_state("Idle")

	# Dash in the direction the player is currently facing.
	character.velocity.x = character.direction.x * DASH_SPEED
	move(delta)
	
	
	
	
