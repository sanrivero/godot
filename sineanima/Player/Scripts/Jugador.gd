extends Actor





onready var barra_vida = get_parent().get_node("Hud/corazon")
onready var oro_node = get_parent().get_node("Hud/Oro")



onready var camera = get_node("Camera2D")



var knockback_derecha = false
var knockback_izquierda = false
signal health_changed(value)
var bounce = false

var dash_timeout = 0.3
#https://gist.github.com/jesseflorig/4b9fd832c3db8ee25a52994ec2f77cb4
var coleccionables


func _ready():
	barra_vida.init(health, health)
	Save.load_game()
	coleccionables = Save.get_coleccionables()
	Save.get_coleccionables_restantes()
	


#func _on_EnemyDetector_body_entered(body: PhysicsBody2D) -> void:
	#die()


func _physics_process(delta: float) -> void:
	_velocity.y += gravity * delta
	var is_doublejump_pressed : = Input.is_action_just_pressed("ui_up") 
	
	if(Input.is_action_just_pressed("ui_down")):
		set_collision_mask_bit(1,false)
		
	
	
	if(is_on_floor()):
		double_jumped = false
		
	var direction: = get_direction()
	set_animations(str(direction))
		
	#TODO SACAR EL MOVE_SLIDE Y OTRAS WEAS AFUERA DEL IF
	if($AnimationPlayer.current_animation != "sword_attack_1"):
	
		
		
		
		
		
		
		if(canDoubleJump() and is_doublejump_pressed and double_jumped == false and !is_on_floor()) :
			_velocity.y = doDoubleJump(_velocity.y, speed.y)
			
		
		
		attack()
		
	
		
	_velocity = calculate_move_velocity(_velocity, direction, speed)
		#var snap: Vector2 = Vector2.DOWN * 60.0 if direction.y == 0.0 else Vector2.ZERO
		
	if knockback_derecha :
		_velocity.x += 350
		_velocity.y -= 150
		knockback_derecha = false
	elif knockback_izquierda:
		_velocity.x -= 350
		_velocity.y -= 150
		knockback_izquierda = false
		
	_velocity = move_and_slide_with_snap(
		_velocity, Vector2(0,0), FLOOR_NORMAL, true
	)
		#_velocity = move_and_slide(_velocity, Vector2.UP)

func attack() -> void:
	if Input.is_action_just_pressed(actions.attack):
		print("ataco")
		if !(is_on_floor()):
			print("ataque en aire")
		
		$AnimationPlayer.play("sword_attack_1")
		

func get_direction() -> Vector2:
	return Vector2(
		Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		-Input.get_action_strength("ui_up") if is_on_floor() and Input.is_action_just_pressed("ui_up") else 0.0
	)


func calculate_move_velocity(
		linear_velocity: Vector2,
		direction: Vector2,
		speed: Vector2
	) -> Vector2:
	var velocity: = linear_velocity
	velocity.x = speed.x * direction.x
	if direction.y != 0.0:
		velocity.y = speed.y * direction.y

	return velocity


func set_animations(direction):
	if(str(direction) == movements.to_right ):
		$Sprite.scale.x = 1
		$AnimationPlayer.play("run")
	elif(str(direction) == movements.to_left):
		$Sprite.scale.x = -1
		$AnimationPlayer.play("run")
	elif(str(direction) == movements.jump):
		$AnimationPlayer.play("jump")
	else:
		if($AnimationPlayer.current_animation != "jump" and  $AnimationPlayer.current_animation != "sword_attack_1" ):
			$AnimationPlayer.play("idle")


func die() -> void:
	#PlayerData.deaths += 1
	$AnimationPlayer.play("die")
	queue_free()
	get_tree().change_scene("res://Scenes/menu.tscn")
	


func _on_Detector_colision_area_entered(area):
	
	var grupo = area.get_groups()
	#collision con entidad hostil
	if grupo.has("hostil"):
		if ((self.get_global_position().x - area.get_global_position().x) > 0):
			knockback_derecha = true
		else:
			knockback_izquierda= true
		take_damage(area.get_damage())
		camera.shake(0.2,15,5)
		

		
	elif grupo.has("activar_doble_salto"):
		print("doble salto")
		#doble_salto_activado = true
	elif grupo.has("activar_dash"):
		print("dash")
		#dash_activado = true

	if grupo.has("escalera"):
		print("en escalera")
		#en_escalera = true
		
	if grupo.has("salida"):
		pass
		#print(get_tree().get_nodes_in_group("persistent"))
	
	if grupo.has("coleccionable"):
		coleccionables.append(area.name)
		Save.save_game()
		area.get_parent().get_parent().queue_free()

	
func get_state():	
	
	var save_dict = {
		coleccionable = coleccionables
	}
	return save_dict

func load_state(data):
	for attribute in data:
		print(data[attribute])


func _on_Jugador_health_changed(value):
	
	if(value <= 0):
		die()
	barra_vida.establecer_vida(value)
	
func  _set_health(value:int) -> void:
	health +=  value
	emit_signal("health_changed", health)
	print(health)
	

	
func take_damage( value:int)-> void:
	_set_health(value)
	
	
func doDoubleJump(_movement:int, speed:int)-> int: 
	_movement = -speed
	double_jumped = true
	return _movement
	
func _set_double_jumped(v:bool):
	double_jumped=v
	pass
	




#HealthAbility
func updateHealth()->void:
	
	self.health += skillTree.skill_avaiable.health.value



func _on_FeetArea_body_exited(body):
	set_collision_mask_bit(1,true)
