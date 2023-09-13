extends "res://Scripts/States/state.gd"




func enter() -> void:
	
	self_anim_name = "attack"
	anim_character.play(self_anim_name);
	anim_character.connect("animation_finished", self, "attack");
	
	"""
	if parent.previous_state.name == "Hit":
		jump(character.max_jump_velocity/2);
	else:
		jump();
	"""


func attack(varrr):
	anim_character.disconnect("animation_finished", self, "attack");
	parent.change_state("Run")


func handle_input(event) -> void:
	#Mientras ataca puede hacer algo?
	pass


func update(delta) -> void:
	#get_direction();
	
	#if(anim_character.current_animation != self_anim_name):
	#	parent.change_state("Idle");
	
	move(delta);
