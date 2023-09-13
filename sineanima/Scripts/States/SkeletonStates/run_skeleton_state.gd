extends "res://Scripts/States/state.gd"



func enter() -> void:

	self_anim_name = "run"
	anim_character.play(self_anim_name);

func handle_input(event) -> void:
	pass





func update(delta) -> void:
	get_direction();
	
	#test_move para ver si se cae
	
	
	
	#if !direction.x:
	#	parent.change_state("Idle");
	
	move(delta);
