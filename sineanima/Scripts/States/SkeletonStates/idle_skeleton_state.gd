extends "res://Scripts/States/state.gd"


func enter():
	pass
	#self_anim_name = "idle"
	#anim_character.play(self_anim_name);

func handle_input(event) -> void:
	pass
	


func update(delta) -> void:
	get_direction()
	
	if direction:
		
		parent.change_state("Run");
