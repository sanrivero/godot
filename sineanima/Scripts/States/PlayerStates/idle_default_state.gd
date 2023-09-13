extends "res://Scripts/States/state.gd"


func enter():
	self_anim_name = "idle"
	anim_character.play(self_anim_name);

func handle_input(event) -> void:
	if character.is_in_group("Players"):
		
		if Input.is_action_just_pressed("jump"):
			parent.change_state("Jump")
		if Input.is_action_just_pressed("attack"):
			parent.change_state("Attack")
	


func update(delta) -> void:
	get_direction()
	
	if direction:
		parent.change_state("Run");
