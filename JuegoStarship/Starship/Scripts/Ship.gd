extends KinematicBody2D


export (int) var MAX_SPEED = 150
export (int) var ACCELERATION = 400
export (float) var FRICTION = 0.1

export (int) var up_force = 40

onready var animationPlayer = $AnimationPlayer
onready var fire_sprite = $Fire
onready var timer = $Timer
#onready var tweenNode = $Tween

const Bullet = preload("res://Scenes/Bullet.tscn")

var motion = Vector2.ZERO

var shoot = false


func _physics_process(delta):
	

	var x_input = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	var y_input = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")



	if Input.is_action_just_pressed("ui_accept") and shoot:
		shoot = false
		var main = get_tree().current_scene
		var bullet = Bullet.instance()
		main.add_child(bullet)
		bullet.global_position = get_global_position()


	if y_input != 0:
		motion.y += y_input * ACCELERATION * delta
		motion.y = clamp(motion.y, -MAX_SPEED, MAX_SPEED)
		motion.y = lerp(motion.y, MAX_SPEED*y_input, 0.05)
	else:
		motion.y = lerp(motion.y,0 ,FRICTION)
		animationPlayer.play("front")


	if x_input != 0:
		motion.x += x_input * ACCELERATION * delta
		motion.x = clamp(motion.x, -MAX_SPEED, MAX_SPEED)
		motion.x = lerp(motion.x, MAX_SPEED*x_input, 0.05)
		
		if x_input == -1:
			 animationPlayer.play("left")
		else:
			animationPlayer.play("right")
		
	else:
		motion.x = lerp(motion.x,0 ,FRICTION)
		animationPlayer.play("front")
		
		shoot()
		
		
		
	position.x = clamp(position.x,10,278)
	position.y = clamp(position.y,250,490)
	#print(get_global_position())
	
	motion = move_and_slide(motion)
	

func _on_Detector_1_area_entered(area):
	fire_sprite.change_fire_sprite(1)


func _on_Detector_2_area_entered(area):
	fire_sprite.change_fire_sprite(2)


func _on_Detector_3_area_entered(area):
	fire_sprite.change_fire_sprite(3)


func shoot():
	if shoot:
		shoot = false
		var main = get_tree().current_scene
		var bullet = Bullet.instance()
		main.add_child(bullet)
		bullet.global_position = get_global_position()
		timer.start()

func _on_Timer_timeout():
	shoot = true
	

func _on_Center_area_entered(area):
	if area.get_groups().has("Hostil"):
		if !area.get_groups().has("Laser"):
			area.get_parent().queue_free()
		queue_free()
