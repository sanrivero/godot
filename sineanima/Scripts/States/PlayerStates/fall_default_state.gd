extends "res://Scripts/States/state.gd"


func enter():
	anim_character.play(self_anim_name);


func update(delta):
	if character.is_on_floor():
		parent.change_state("Idle");
