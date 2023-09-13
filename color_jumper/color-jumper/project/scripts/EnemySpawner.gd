extends Node2D

onready var enemy_spawn = $SpawnPos
onready var animationPlayer = $AnimationPlayer

var enemy = preload("res://scenes/Enemies/UpEnemy.tscn")

var spawn = true

func _ready():
	pass # Replace with function body.

func spawn_enemy():
	animationPlayer.play("alert")
	spawn = false


func _on_AnimationPlayer_animation_finished(anim_name):
	if(anim_name == "alert"):
		enemy_spawn.add_child(enemy.instance())
