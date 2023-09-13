#Polvo.gd
extends Area2D

var dano = 25

onready var duracion = get_node("Timer")



func _ready():
	duracion.set_wait_time(0.2)
	duracion.start()


func set_dano(valor):
	dano = valor

func get_dano():
	return dano


func _on_Timer_timeout():
	
	queue_free()
