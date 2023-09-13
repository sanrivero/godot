extends Area2D


export (int) var MAX_SPEED = 10
export (int) var ACCELERATION = 400
export (float) var FRICTION = 0.1
export (int) var HEAL = 6

onready var position2d = $Position2D
onready var shoot_position = $Cannon/Shoot_position

onready var cannon = $Cannon
var ship
var shoot_ok = false

const BULLET_SCENE = preload("res://Scenes/Enemy_bullet.tscn")
var aim_direction = Vector2.DOWN


func _physics_process(delta):
	position.y += MAX_SPEED * delta
	if shoot_ok:
		if ship:
			position2d.global_position = position2d.global_position.linear_interpolate(ship.get_global_position(), delta*2)
			cannon.look_at(position2d.get_global_position())
			aim_direction = global_position.direction_to(position2d.get_global_position())

func shoot():       
	for angle in [-20, -10, 0, 10, 20]:
		var main = get_tree().current_scene
		var radians = deg2rad(angle)
		var bullet = BULLET_SCENE.instance()
		bullet.direction = aim_direction.rotated(radians)
		main.add_child(bullet)
		bullet.global_position = shoot_position.get_global_position()


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Enemy_2_area_entered(area):
	if area.get_groups().has("Player_bullet"):
		area.get_parent().queue_free()
		HEAL -= 1
		if HEAL == 0:
			queue_free()


func _on_Timer_timeout():
	if shoot_ok:
		shoot()


func _on_Player_detector_area_entered(area):
	if area.get_groups().has("Player"):
		ship = area
		shoot_ok = true
