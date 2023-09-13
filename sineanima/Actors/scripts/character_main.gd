extends "res://Actors/char.gd"
class_name Player



var health : int = 100 setget _set_health

signal health_changed(value)

onready var skillTree = get_parent().get_node("Hud/SkillTree")

#onready var _sound: Node2D = $Sounds
onready var _camera_anchor: Position2D = $CameraAnchor
var curr_room = null
var prev_room = null


var _timer_ghost : Timer = Timer.new()
 


#to_save
var collections

func _ready():
	
	Save.load_game()
	collections = Save.get_coleccionables()
	Save.get_coleccionables_restantes()
	
	$Label.text = str(0)
	
	#speed = 100.00
	state_machine = $StateMachine
	animation_player = $Anim
	state_machine.start()
	
	
	_timer_ghost.set_one_shot(false)
	_timer_ghost.connect("timeout",self,"_on_timer_ghost_timeout")
	add_child(_timer_ghost)

func init_camera(starting_room_path) -> void:
	#Camera
	assert(starting_room_path.name != '')
	curr_room = starting_room_path
	prev_room = curr_room
	get_camera().fit_camera_limits_to_room(curr_room)



func _on_Detector_colision_body_entered(body: KinematicBody2D):
	if body and body.is_in_group("Enemies"):
		
		state_machine.change_state("Hit")


func  _set_health(value:int) -> void:
	health +=  value
	emit_signal("health_changed", health)
	$Label.text = str(health)
	
func take_damage( value:int)-> void:
	if(!isImmune()):
		if(isTakeLessDamage()):
			_set_health(- ( value - get_percentage(value,getTakeLessDamageValue())))
		else:
			_set_health(-value)
	
	
func _on_Player_health_changed(value):
	if(value <= 0):
		pass
		#die()
	#barra_vida.establecer_vida(value)


func _on_Detector_colision_area_entered(area):
	if area and area.is_in_group("EnemyWeapon"):
		take_damage(area.get_damage())
		state_machine.change_state("Hit")

#Powers


#Double Jump
func canDoubleJump() -> bool:
	return skillTree.skill_avaiable.double_jump.isOn

func canDash() -> bool: 
	return skillTree.skill_avaiable.dash.isOn
	
#Lifesteal/Leech
func canLifeSteal() -> bool:
	return skillTree.skill_avaiable.lifesteal.isOn

func doLifeSteal()->void:
	_set_health(skillTree.skill_avaiable.lifesteal.value)
	
#Inmunity / take_no_damage
func isImmune()->bool:
	return skillTree.skill_avaiable.take_no_damage.pressed

#LessDamage
func isTakeLessDamage()->bool:
	return skillTree.skill_avaiable.lessDamageTaken.isOn
	
func getTakeLessDamageValue()-> int:
	return skillTree.skill_avaiable.lessDamageTaken.value
	
#Jump Height
func updateJumpHeight()->void:
	pass
	#speed.y = skillTree.skill_avaiable.jump_height.value

#Run Speed
func updateRunSpeed() -> void:
	pass
	#speed.x = skillTree.skill_avaiable.run_speed.value

#gravity	
func updateGravity() -> void: 
	gravity = skillTree.skill_avaiable.gravity.value

func normalGravity()->void:
	gravity = original_gravity

func get_damage():
	if(canLifeSteal()):
		doLifeSteal()
	#return damage

func doHealth()->int:
	return skillTree.skill_avaiable.health.value	

	# animationplayer.play("damage")

#HealthAbility
func updateHealth()->void:
	_set_health(skillTree.skill_avaiable.health.value)
	



#Utils
func get_percentage(val,percentage) -> int:
	return (percentage*val)/100



func get_state():
	
	var save_dict = {
		#coleccionable = coleccionables
	}
	return save_dict

func load_state(data):
	for attribute in data:
		print(data[attribute])

func get_camera() -> Camera2D:
	return _camera_anchor.get_node('Camera2D') as Camera2D
	

func get_animation_player() -> AnimationPlayer:
	return animation_player

func pause() -> void:
	set_physics_process(false)
	set_process_unhandled_input(false)

	get_animation_player().stop(false)
	
func unpause() -> void:
	set_physics_process(true)
	set_process_unhandled_input(true)

	get_animation_player().play()
	
func _start_ghost(time) -> void:
	_timer_ghost.set_wait_time(time)
	_timer_ghost.start()
	
func _stop_ghost() -> void:
	_timer_ghost.stop()
	
func _on_timer_ghost_timeout():
	var ghost = preload("res://Scenes/Effects/GhostEffect.tscn").instance()
	get_parent().add_child(ghost)
	ghost.position = self.position
	#animation_player.current_animation_position
	
	ghost.texture = $pivot/Images.texture
	ghost.hframes =  $pivot/Images.hframes
	ghost.frame = $pivot/Images.frame
	ghost.scale = $pivot.scale
