extends Area2D


export (int) var MAX_SPEED = 25
export (int) var ACCELERATION = 400
export (float) var FRICTION = 0.1
export (int) var HEAL = 3

const Bullet = preload("res://Scenes/Enemy_bullet.tscn")

onready var timer = $Timer

var ship
var mover = false
var motion = Vector2.ZERO
var shoot_ok = false


func _ready():
	pass # Replace with function body.


func _physics_process(delta):
	position.y += MAX_SPEED * delta
	
	if mover:
		if ship:
			if round(ship.get_global_position().x) > round(get_global_position().x):
				position.x += MAX_SPEED * delta
			elif round(ship.get_global_position().x) < round(get_global_position().x):
				position.x -= MAX_SPEED * delta
			
	shoot()
	
	
func _on_Area2D_area_entered(area):
	if area.get_groups().has("Player"):
		ship = area
		mover = true
	#	var ship_pos = area.get_global_position()
	#	if self.get_global_position().x < ship_pos.x:
	#		self.position.x += ACCELERATION
	
func shoot():
	if shoot_ok:
		shoot_ok = false
		var main = get_tree().current_scene
		var bullet = Bullet.instance()
		main.add_child(bullet)
		bullet.global_position = get_global_position()
		timer.start()
		
func _on_Timer_timeout():
	shoot_ok = true
	

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Enemy_1_area_entered(area):
	if area.get_groups().has("Player_bullet"):
		area.get_parent().queue_free()
		HEAL -= 1
		if HEAL == 0:
			queue_free()
