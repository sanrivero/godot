extends "res://Scripts/States/state.gd"


var _input_time : Timer = Timer.new()
const INPUT_TIMEOUT = 0.3
var last_key_delta = 0    # Time since last keypress

func enter() -> void:
	
	self_anim_name = "run"
	self_sound_name = "Run"
	
	anim_character.play(self_anim_name);

func handle_input(event) -> void:
	if character.is_in_group("Players"):
		if Input.is_action_pressed("dash"):
			if last_key_delta > INPUT_TIMEOUT:
				last_key_delta = 0     
				parent.change_state("Dash")
			
			
		if Input.is_action_just_pressed("jump"):
			parent.change_state("Jump")
		if Input.is_action_just_pressed("attack"):
			parent.change_state("Attack")





func update(delta) -> void:
	last_key_delta += delta        
	get_direction();
	
	
	move(delta);
	if character.velocity.x == 0 and !direction.x:
		parent.change_state("Idle");
		character.at_friction = false
	
	if direction.x and character.at_friction:
		anim_character.play("run")
	elif character.at_friction:
		anim_character.play("idle")
		
	
	
