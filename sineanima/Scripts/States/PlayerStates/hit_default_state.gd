extends "res://Scripts/States/state.gd"


func enter() -> void:
	#hit()
	self_anim_name = "hit";
	anim_character.play(self_anim_name);
	anim_character.connect("animation_finished", self, "hited");


func handle_input(event) -> void:
	if Input.is_action_just_pressed("attack"):
		parent.change_state("Attack");
	
func hit():
	parent.change_state("Jump")
	
func hited(anim_name) -> void:
	if anim_name == self_anim_name:
		parent.change_state("Jump");
		anim_character.disconnect("animation_finished", self, "hited");
