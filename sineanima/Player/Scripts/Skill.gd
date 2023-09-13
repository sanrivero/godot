extends Node

"""
Health (quantity) -> Actor
Lifesteal (quantity) -> Skill
Take no damage(seconds) -> Actor
Less damage taken(quantity) -> Actor

Jump height -> Actor
Run speed -> Actor
Gravity-> Actor
Double Jump(quantity) -> Skill
Dash (direction,speed) -> SKill

Light area (area) -> Actor 
Invisibility (seconds) -> Actor


More damage(quantity) -> Actor
Critic damage(modifier) -> Actor
Reflect damage(quantity) -> Actor
1 life 100 damage -> Actor""" 

var skillTree  

var skill_avaiable = {"double_jump" : true,
			"dash" : false,
			"leech": false}

var leechAmount = 10
var double_jumped : = false setget _set_double_jumped
var dashed = false


func _init(_skillTree):
	skillTree = _skillTree
	
func _updateSkillTree(_skillTree):
	skillTree = _skillTree
	print(skillTree.skill_avaiable.health)

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
	skill_avaiable.double_jump = !skill_avaiable.double_jump
	print(skill_avaiable.double_jump)

func canDoubleJump() -> bool:
	return skillTree.skill_avaiable.double_jump.isOn
	
#Lifesteal/Leech
func canLeech() -> bool:
	return skill_avaiable.leech

func doLeech(life:int)->int:
	life+= leechAmount
	return life


func doHealth()->int:
	return skillTree.skill_avaiable.health.value
