extends "res://Scripts/States/state.gd"

const COMBO_TIMEOUT = 0.4 # Timeout between key presses
const MAX_COMBO_CHAIN = 2 # Maximum key presses in a combo

var last_key_delta = 0
var key_combo = [] 

var hit_count : int = 0
var max_hit : int = 1
var hit :bool = false

func enter() -> void:
	
	attack()
	
	

func attack():
	match hit_count:
		0:
			anim_character.play("attack_1")
		1:
			anim_character.play("attack_2")
	hit = false

func handle_input(event) -> void:
	if Input.is_action_just_pressed("attack") and hit_count < max_hit:              
		hit = true




func _on_Anim_animation_finished(anim_name):
	if hit:
		hit_count+=1
		attack()
		return
		
	if anim_name == "attack_1" or anim_name == "attack_2":
		hit_count = 0
		hit= false
		parent.change_state("Idle")

"""
func update(delta) -> void:
	last_key_delta += delta
	#get_direction();
	
	if(anim_character.current_animation != self_anim_name):
		parent.change_state("Idle");
	
	move(delta);
"""
