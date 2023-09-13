extends "res://Scripts/Monster.gd"


var movimiento = Vector2()
const ACELERACION = 5
const VELOCIDAD_MAX = 300
var tmp = 1000
var direccion = 1
onready var timer_dir = get_node("Timer")



func _ready():
	timer_dir.set_wait_time(2)
	timer_dir.start()
	

func _physics_process(delta):
	movimiento.x = min((movimiento.x * direccion) + ACELERACION,VELOCIDAD_MAX)
	movimiento.x = lerp((movimiento.x * direccion), 0, 0.05)
	move_and_slide(movimiento)
	pass

func _on_Timer_timeout():
	direccion *= -1
	timer_dir.start()
	pass
