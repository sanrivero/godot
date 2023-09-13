extends Control



onready var gold = get_parent().get_parent().get_node("Hud/Oro")
onready var player = get_parent().get_parent().get_node("Player")
"""
Health (quantity) D
Take no damage(seconds) D
Less damage taken(quantity) D

Jump height D
Run speed D
Gravity  D
Double Jump D
Dash (direction,speed)

Light area (area)
Invisibility (seconds)

Lifesteal (quantity) D
More damage(quantity)
Critic damage(modifier)
Reflect damage(quantity)
1 life 100 damage"""

var skill_avaiable = {
	"health": {
		"isOn" : false,
		"value" : 0,
		"increase" : [10,20,30],
		"increase_original" : [10,20,30]
	},
	"lifesteal": {
		"isOn" : false,
		"value" : 0,
		"increase" : [5,10,15],
		"increase_original" : [5,10,15]
	},
	"take_no_damage" : {
		"isOn" : false,
		"pressed" : false,
		"value" : 0,
		"increase" : [5,10,15],
		"increase_original" : [5,10,15]
	},
	"lessDamageTaken" : {
		"isOn" : false,
		"value" : 0,
		"increase" : [5,10,15,20],
		"increase_original" : [5,10,15,20]
	},
	"run_speed" : {
		"isOn" : false,
		"value" : 0,
		"increase" : [5,10,15],
		"increase_original" : [5,10,15]
	},
	"gravity" : {
		"isOn" : false,
		"pressed" : false,
		"value" : 0,
		"increase" : [1100,1000,900],
		"increase_original" : [1100,1000,900]
	},
	"double_jump" : {
		"isOn" : false,
		"value" : 0
	},
	"dash" : {
		"isOn" : false,
		"value" : 0
	}
}


func _ready():
	hide()
	if(!Save.saved_skill_tree.empty()):
		skill_avaiable = Save.saved_skill_tree
	#Setear Health Power button
	print("La información se guardo en: " + OS.get_user_data_dir())
	get_node("TabContainer/Defense/Health/HealthProgress").value  = ( -skill_avaiable.health.increase.size() + skill_avaiable.health.increase_original.size())
	
	
func _unhandled_input(event):
	if(Input.is_action_just_pressed("skill_tree")):
		if(is_visible_in_tree()):
			hide()
		else:
			show()
		
		
		
func _on_Health_pressed():
	skill_avaiable.health.isOn = true
	if(skill_avaiable.health.increase):
		skill_avaiable.health.value = skill_avaiable.health.increase[0]
		skill_avaiable.health.increase.remove(0)
		get_node("TabContainer/Defense/Health/HealthProgress").value  = ( -skill_avaiable.health.increase.size() + skill_avaiable.health.increase_original.size())
		player.updateHealth()

func get_state():	
	
	var save_dict = {
		skill_tree = skill_avaiable
	}
	
	return save_dict

func load_state(data):
	for attribute in data:
		print(data[attribute])


func _on_Exit_pressed():
	
	Save.save_game()
	hide()


func _on_DoubleJump_pressed():
	skill_avaiable.double_jump.isOn = true
	get_node("TabContainer/Movement/DoubleJump/DoubleJumpProgress").value  = 1
		


func _on_Lifesteal_pressed():
	skill_avaiable.lifesteal.isOn = true
	if(skill_avaiable.lifesteal.increase):
		skill_avaiable.lifesteal.value = skill_avaiable.lifesteal.increase[0]
		skill_avaiable.lifesteal.increase.remove(0)
		get_node("TabContainer/Attack/Lifesteal/LifestealProgress").value  = ( -skill_avaiable.lifesteal.increase.size() + skill_avaiable.lifesteal.increase_original.size())
	


func _on_TakeNoDamage_pressed():
	skill_avaiable.take_no_damage.isOn = true
	if(skill_avaiable.take_no_damage.increase):
		skill_avaiable.take_no_damage.value = skill_avaiable.take_no_damage.increase[0]
		skill_avaiable.take_no_damage.increase.remove(0)
		get_node("TabContainer/Defense/TakeNoDamage/TakeNoDamageProgress").value  = ( -skill_avaiable.take_no_damage.increase.size() + skill_avaiable.take_no_damage.increase_original.size())
		#Segundos


func _on_LessDamage_pressed():
	skill_avaiable.lessDamageTaken.isOn = true
	if(skill_avaiable.lessDamageTaken.increase):
		skill_avaiable.lessDamageTaken.value = skill_avaiable.lessDamageTaken.increase[0]
		skill_avaiable.lessDamageTaken.increase.remove(0)
		get_node("TabContainer/Defense/LessDamage/LessDamageProgress").value  = ( -skill_avaiable.lessDamageTaken.increase.size() + skill_avaiable.lessDamageTaken.increase_original.size())
		

func _on_RunSpeed_pressed():
	skill_avaiable.run_speed.isOn = true
	if(skill_avaiable.run_speed.increase):
		skill_avaiable.run_speed.value = skill_avaiable.run_speed.increase[0]
		skill_avaiable.run_speed.increase.remove(0)
		get_node("TabContainer/Movement/RunSpeed/RunSpeedProgress").value  = ( -skill_avaiable.run_speed.increase.size() + skill_avaiable.run_speed.increase_original.size())
		player.updateRunSpeed()


func _on_Gravity_pressed():
	skill_avaiable.gravity.isOn = true
	if(skill_avaiable.gravity.increase):
		skill_avaiable.gravity.value = skill_avaiable.gravity.increase[0]
		skill_avaiable.gravity.increase.remove(0)
		get_node("TabContainer/Movement/RunSpeed/RunSpeedProgress").value  = ( -skill_avaiable.gravity.increase.size() + skill_avaiable.gravity.increase_original.size())
		


func _on_Dash_pressed():
	skill_avaiable.dash.isOn = true
	get_node("TabContainer/Movement/Dash/DashProgress").value  = 1
