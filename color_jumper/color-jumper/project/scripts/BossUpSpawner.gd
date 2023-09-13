extends Node2D

onready var enemy_spawn = $SpawnPos
onready var animationPlayer = $AnimationPlayer

onready var timer = $Timer

var enemy = preload("res://scenes/Enemies/BossSnake.tscn")

var spawn = true

func _ready():
	timer.wait_time = rand_range(7, 10)
	timer.start()

func spawn_enemy():
	var spawn = round(rand_range(0, 1))
	if(spawn == 1):
		animationPlayer.play("alert")
		spawn = false


func _on_AnimationPlayer_animation_finished(anim_name):
	if(anim_name == "alert"):
		enemy_spawn.add_child(enemy.instance())


func _on_Timer_timeout():
	spawn_enemy()
	timer.wait_time = rand_range(7, 10)
	timer.start()
