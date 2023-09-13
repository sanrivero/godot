extends KinematicBody2D

export var lifes: int = 5 setget set_life;
export var max_attacks: int = 3;
export var speed: float = 25.00;
var original_gravity: float = 450;
export var gravity: float = 450;
export var max_jumps: int = 2;

export var jump_duration = 0.3;
var max_jump_velocity;
var max_jump_height = 1.30 * 32;

onready var state_machine: Node;
onready var animation_player: AnimationPlayer;

var at_friction = false
export var friction = 0.2
export var acceleration = 0.15

var direction := Vector2();
var velocity := Vector2();


func _ready():
	gravity = 2 * max_jump_height / pow(jump_duration, 2);
	max_jump_velocity = -jump_duration * gravity;


func _physics_process(delta) -> void:
	apply_gravity(delta);


func apply_gravity(delta) -> void:
	velocity.y += gravity * delta;
	
	velocity  = move_and_slide_with_snap(velocity, Vector2(0, 16), Vector2(0, -1), true, 4, 0.9);
	#velocity = move_and_slide(velocity,Vector2.UP)
	
	if is_on_floor():
		velocity.y = 0;
	
	if is_on_ceiling():
		velocity.y = 0;
	
	


func set_life(new_life) -> void:
	lifes = new_life;
	
	if lifes <= 0:
		state_machine.change_state("Dead");


func cancel_velocity() -> void:
	velocity = Vector2.ZERO;
	
func is_in_air() -> bool:
	return not .is_on_floor()
