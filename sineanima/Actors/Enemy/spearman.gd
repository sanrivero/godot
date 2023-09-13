extends "res://Actors/enemy.gd"



var attack_timer := Timer.new()
var in_attack_area = false
var player_position = null
var enemy_position
var cooldown = true

var initial_position := Vector2()
var max_right := Vector2()
var max_left := Vector2()

func _ready():
	initial_position = self.get_global_position()
	max_right = initial_position + Vector2(10,0)
	max_left = initial_position + Vector2(-10,0)
	
	attack_timer.set_wait_time(2)
	attack_timer.set_one_shot(true)
	set_process(false)
	attack_timer.connect("timeout", self, "finish_cooldown")
	
	add_child(attack_timer)
	
	state_machine = $StateMachine
	animation_player = $Anim
	state_machine.start()


func _process(delta):
	if(in_attack_area and enemy_position.is_on_floor()):
		player_position = enemy_position.get_global_position()
		attack()

	#Terminar proceso si no esta el persnaje adentro y termino el time
	if($pivot/AttackArea.get_overlapping_bodies().empty() and attack_timer.time_left == 0):
		set_process((false))


#Limits functions
func canWalk()->bool:
	if(inRoamArea() and notWallorFall()):
		return true
	
	return false

func notWallorFall() -> bool:
	if($pivot/RayCast2D.is_colliding()):
		return false
	if(!$pivot/RayCast2D2.is_colliding()):
		return false
	
	return true

func inRoamArea() -> bool:
	#print("Mi posicion actual es x" + str(self.get_global_position().x) + "Y el maximo derecha es" + str(max_right.x) + ",,, izquierda es" + str(max_left.x))
	return self.get_global_position().x < max_right.x or self.get_global_position().x > max_left.x



func attack() -> void:
	if(cooldown):
		state_machine.change_state("Attack")
		cooldown = false
		attack_timer.start()

func finish_cooldown() -> void:
	cooldown = true


func _on_DamageDetector_area_entered(area):
	if area and area.is_in_group("Weapon"):
		take_damage(area.get_damage())
		if(health > 0):
			pass
			#state_machine.change_state("Hit")
		else:
			state_machine.change_state("Dead")


func _on_AttackArea_body_entered(body):
	if body and body.is_in_group("Players") and (animation_player.current_animation != "dead"):
		in_attack_area = true
		player_position = body.get_global_position()
		enemy_position = body
		set_process(true)


func _on_AttackArea_body_exited(body):
	if body and body.is_in_group("Players"):
		in_attack_area= false
		#set_process(false)
		#attack_timer.timeout()
		yield(get_node("Anim"), "animation_finished")
		state_machine.change_state("Run")


func _on_Spearman_health_changed(value):
	if(value <= 0 ):
		state_machine.change_state("Dead")
