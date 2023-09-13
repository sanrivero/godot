extends "res://Scripts/States/state.gd"


var current_jump: int;


func enter() -> void:
	self_anim_name = "jump"
	current_jump = 0;
	anim_character.play(self_anim_name);
	
	
	if parent.previous_state.name == "Hit":
		jump(character.max_jump_velocity/2);
	else:
		jump();


func jump(jump_height = character.max_jump_velocity) -> void:
	
	character.velocity.y = jump_height;
	#character.move_and_slide(character.velocity,Vector2(0,-1));
	character.velocity = character.move_and_slide(character.velocity,Vector2(0,-1));
	current_jump += 1;


func handle_input(event) -> void:
	if character.is_in_group("Players"):
		if Input.is_action_just_pressed("jump"):
			if character.max_jumps > current_jump:
				jump();
		if Input.is_action_just_pressed("attack"):
			parent.change_state("Attack_Air")


func update(delta) -> void:
	get_direction();
	
	if character.is_on_floor():
		if !direction.x:
			parent.change_state("Idle");
		else:
			parent.change_state("Run");
	move(delta);
