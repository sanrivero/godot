extends Node2D


onready var leftSpawner = $spawners/LeftSpawner/BossSpawner
onready var rightSpawner = $spawners/RightSpawner/BossSpawner

onready var leftAnim = $spawners/LeftSpawner/LeftAnim
onready var rightAnim = $spawners/RightSpawner/RightAnim

onready var visibilityNot = $VisibilityNotifier2D

onready var timer = $Timer

var boss = preload("res://scenes/Enemies/BossSnake.tscn")

func _ready():
	timer.wait_time = 1
	timer.start()


func spawn_enemy():
	var spawn = round(rand_range(0, 1))
	var pos = round(rand_range(0, 1))
	if(spawn == 1):
		if(pos == 0):
			leftAnim.play("alert")
		else:
			rightAnim.play("alert")


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_LeftAnim_animation_finished(anim_name):
	if(anim_name == "alert"):
		var boss_inst = boss.instance()
		boss_inst.get_child(0).rotation_degrees = -90
		boss_inst.direction = Vector2(1,0)
		leftSpawner.add_child(boss_inst)


func _on_RightAnim_animation_finished(anim_name):
	if(anim_name == "alert"):
		var boss_inst = boss.instance()
		boss_inst.get_child(0).rotation_degrees = 90
		boss_inst.direction = Vector2(-1,0)
		rightSpawner.add_child(boss_inst)


func _on_Timer_timeout():
	spawn_enemy()
	timer.wait_time = rand_range(4, 7)
	timer.start()
