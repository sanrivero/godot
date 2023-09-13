extends "res://Scripts/States/state.gd"


var hit_count : int = 0
var max_hit : int = 0
var hit :bool = false

func enter() -> void:
	
	attack()
	
	

func attack():
	match hit_count:
		0:
			anim_character.play("attack_air_1")
		1:
			anim_character.play("attack_air_2")
	hit = false

func handle_input(event) -> void:
	if Input.is_action_just_pressed("attack") and hit_count < max_hit:              
		hit = true




func _on_Anim_animation_finished(anim_name):
	if hit:
		hit_count+=1
		attack()
		return
		
	if anim_name == "attack_air_1" or anim_name == "attack_air_2":
		hit_count = 0
		hit= false
		parent.change_state("Idle")


