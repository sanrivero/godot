extends Area2D

export (int) var MAX_SPEED = 10
export (int) var ACCELERATION = 400
export (float) var FRICTION = 0.1
export (int) var HEAL = 10

onready var playerFollower = $Player_follower
onready var animationPlayer = $AnimationPlayer

var ship
var shoot_ok = false
var aim_direction = Vector2.DOWN

const LASER = preload("res://Scenes/Laser.tscn")


func _physics_process(delta):
	if shoot_ok:
		if ship:
			playerFollower.global_position = playerFollower.global_position.linear_interpolate(ship.get_global_position(), delta*10)
			#aim_direction = global_position.direction_to(playerFollower.get_global_position())


func shoot():       
	for angle in [0]: #Puedo agregar mas para mas Lasers. MAS O MENOS
		var main = get_tree().current_scene
		var radians = deg2rad(angle)
		var laser = LASER.instance()
		laser.direction = playerFollower.global_position + Vector2(angle,0)
		main.add_child(laser)
		laser.global_position = get_global_position()
		
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()



func _on_Enemy_Laser_area_entered(area):
	if area.get_groups().has("Player_bullet"):
		area.get_parent().queue_free()
		HEAL -= 1
		if HEAL == 0:
			queue_free()


func _on_Timer_timeout():
	if shoot_ok:
		animationPlayer.play("shoot")
		shoot()


func _on_Player_detector_area_entered(area):
	if area.get_groups().has("Player"):
		ship = area
		shoot_ok = true
