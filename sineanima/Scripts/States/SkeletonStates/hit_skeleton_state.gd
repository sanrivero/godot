extends "res://Scripts/States/state.gd"


func enter() -> void:

	self_anim_name = "hit";
	anim_character.play(self_anim_name);
	anim_character.connect("animation_finished", self, "hited");


func handle_input(event) -> void:
	pass

func hited(anim_name) -> void:
	if anim_name == self_anim_name:
		parent.change_state("Run");
		anim_character.disconnect("animation_finished", self, "hited");
