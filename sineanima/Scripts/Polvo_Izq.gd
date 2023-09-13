#Polvo.gd
extends Area2D

export (int) var dano = 25

onready var duracion = get_node("Timer")



func _ready():
	duracion.set_wait_time(0.2)
	duracion.start()




func get_dano():
	return dano


func _on_Timer_timeout():
	
	queue_free()
