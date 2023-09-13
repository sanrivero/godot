extends "res://Scripts/States/state.gd"


func enter() -> void:
	self_anim_name = "dead"
	anim_character.play(self_anim_name);
	anim_character.connect("animation_finished", self, "dead");


func dead(anim_name) -> void:
	
	if anim_name == "dead":
		print("DEAD");
		character.set_physics_process(false);
		character.set_process(false);
		character.set_process_input(false);
		anim_character.disconnect("animation_finished", self, "dead");
		
		parent.set_active(false);
		owner.queue_free()
