extends TextureButton

var timer = Timer.new()
var cooldown = Timer.new()
onready var skillTree = get_parent().get_parent().get_node("SkillTree")

func _ready():
	
	#timer.set_timer_process_mode(Timer.TIMER_PROCESS_FIXED)
	get_node("Label").add_color_override("font_color", Color(1,0,0,1))
	timer.set_wait_time(5)
	timer.set_one_shot(true)
	timer.connect("timeout", self, "finish")
	cooldown.set_wait_time(2)
	cooldown.set_one_shot(true)
	cooldown.connect("timeout", self, "finish_cooldown")
	
	
	add_child(cooldown)
	add_child(timer)
	set_process(false)

func _physics_process(delta):
	#Se puede imprmir en algun lado con un label el tiempo de cooldown y de inmunidad
	get_node("Label").text = str(stepify(timer.get_time_left(),0.01))
	pass

func finish_cooldown():
	set_process(false)
	show()
	
func finish():
	skillTree.skill_avaiable.gravity.pressed = false
	skillTree.player.normalGravity()
	hide()
	cooldown.start()
	print("Termino el tiempo de gravedad")
	

func _on_take_no_damage_pressed():
	set_process(true)
	skillTree.skill_avaiable.gravity.pressed = true
	timer.start()
	
