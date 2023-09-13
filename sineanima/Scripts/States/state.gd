extends Node

onready var parent: Node = get_parent(); # StateMachine is the parent;
var character: KinematicBody2D = owner; # Player or NPc node is the Owner;

var anim_character: AnimationPlayer = null;
var self_anim_name: String = "";

var sound : AudioStreamPlayer2D = null
var self_sound_name : String = "";

var speed: float;

var velocity := Vector2();
var direction := Vector2();

var enemy_position : = Vector2();


func enter() -> void:
	pass


func update(delta) -> void:
	pass


func handle_input(event) -> void:
	pass


func get_direction() -> void:
	if character.is_in_group("Players"):
		direction.x = int(Input.is_action_pressed("ui_right"))-int(Input.is_action_pressed("ui_left"));
		
		character.direction = direction;
		
	
	#Deberia hacer esto en cada estado, para que rebote etc
	if character.is_in_group("Enemies"):
		if(owner.canWalk()):
			
			direction.x = character.get_node("pivot").scale.x
			character.direction = direction
		else:
			direction.x = direction.x * -1
	
	if direction.x != 0:
		character.get_node("pivot").scale = Vector2(direction.x, 1);


func move(delta) -> void:
	
	if(owner.state_machine.previous_state.name != "Idle"):
		
		#Hacer un boolean hasta que no este en idle hace esto
		character.velocity.x = character.speed * direction.x
		return
	
	if(direction.x != 0):
		#character.velocity = character.velocity.linear_interpolate(direction, character.acceleration)
		character.velocity.x = lerp(character.velocity.x, direction.x * character.speed, character.acceleration)
	else:
		character.at_friction = true
		character.velocity.x = lerp(character.velocity.x, 0 , character.friction)
	#character.velocity.x = character.speed * direction.x;

func dash_move(delta) -> void:
	character.velocity.x = character.speed * direction.x
	
func exit() -> void:
	character.velocity.x = 0;
