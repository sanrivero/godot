extends KinematicBody2D
class_name Actor

const movements = { "to_right": "(1, 0)",
			"to_left": "(-1, 0)",
			"jump" : ("(0, -1)")
	
}

var actions = {'left': "ui_left",
			 'right': "ui_right",
			 'up': "ui_up",
			 'attack': "ui_accept",
			'subir' : "ui_subir",
			'bajar' : "ui_bajar"}



onready var skillTree = get_parent().get_node("Hud/SkillTree")

var health : int = 100 setget _set_health
var damage = 25
var shield = 0 

const FLOOR_NORMAL: = Vector2.UP
var speed: = Vector2(80.0, 350.0)
var gravity: = 1200.0
var _velocity: = Vector2.ZERO

var double_jumped = false

#func _init(_health, _damage, _speed, _gravity):
#	pass

func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	
func  _set_health(value:int) -> void:
	health +=  value
	emit_signal("health_changed", health)
	
	
func take_damage( value:int)-> void:
	
	if(!isImmune()):
		if(isTakeLessDamage()):
			_set_health(- ( value - get_percentage(value,getTakeLessDamageValue())))
		else:
			_set_health(-value)
	
	
func doDash() -> void:
	pass

#DoubleJump
func doDoubleJump(_movement:int, speed:int)-> int: 
	_movement = -speed
	double_jumped = true
	return _movement
	
func _set_double_jumped(v:bool):
	double_jumped=v
	pass
	
func negate_double_jump():
	pass
	#skill_avaiable.double_jump = !skill_avaiable.double_jump
	#print(skill_avaiable.double_jump)
	
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
	return skillTree.skill_avaiable.takeLessDamage.isOn
	
func getTakeLessDamageValue()-> int:
	return skillTree.skill_avaiable.takeLessDamage.value
	
#Jump Height
func updateJumpHeight()->void:
	speed.y = skillTree.skill_avaiable.jump_height.value

#Run Speed
func updateRunSpeed() -> void:
	speed.x = skillTree.skill_avaiable.run_speed.value
	
func updateGravity() -> void: 
	gravity = skillTree.skill_avaiable.gravity.value

func get_damage():
	if(canLifeSteal()):
		doLifeSteal()
	return damage

func doHealth()->int:
	return skillTree.skill_avaiable.health.value	

	# animationplayer.play("damage")



#Utils
func get_percentage(val,percentage) -> int:
	return (percentage*val)/100
