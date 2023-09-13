extends "res://Scripts/States/state.gd"




func enter() -> void:
	
	self_anim_name = "attack_1"
	
	
	owner.get_node("pivot/Attack").visible = true
	owner.get_node("pivot/Attack").set_global_position(owner.player_position)
	owner.get_node("pivot/Attack/AnimationPlayer").play("attack")
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
	owner.get_node("pivot/Attack").visible = false
	parent.change_state("Run")


func handle_input(event) -> void:
	#Mientras ataca puede hacer algo?
	pass


func update(delta) -> void:
	#get_direction();
	
	#if(anim_character.current_animation != self_anim_name):
	#	parent.change_state("Idle");
	
	move(delta);
