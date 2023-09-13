extends KinematicBody2D





var direccion = 0


#Variables de vida
var vida_max = 100
var vida = 100

#Cargar Barra de vida
onready var barra_vida = get_parent().get_node("Hud/corazon")
#Tiempo entre ataques
onready var timer = get_node("Tiempo_Entre_Ataques")

onready var timer_tiempo_entre_dash = get_node("Tiempo_Entre_Dash")
onready var Oro_node = get_parent().get_node("Hud/Oro")

#Variables de inmunidad
var inmunidad = false
var duracion_inmunidad_dano = 1
onready var timer_inmunidad = get_node("Tiempo_Inmunidad")

var en_escalera = false


const moves = {'right': Vector2(25,5),
			 'left': Vector2(-25,5),
			 'up': Vector2(0, -1),
			 'down': Vector2(0, 1)}
			
var sprites = {'atacar': "Atacar",
			 'idle': "idle",
			 'correr': "Correr",
			 'saltar': "Salto",
			 'pared': "Pared",
			 'caer': "Caer",
			 'en_aire': "En_Aire" }

var actions = {'left': "ui_left",
			 'right': "ui_right",
			 'up': "ui_up",
			 'attack': "ui_accept",
			'subir' : "ui_subir",
			'bajar' : "ui_bajar"}


#Variables de movimiento
var GRAVEDAD = 15
const ACELERACION = 20
const VELOCIDAD_MAX = 80
const ALT_SALTO = -250
#Variable que almaneza direccion (para el movimiento)
var movimiento = Vector2()


#Variables para doble salto
var contador_salto = 0
var saltos_max = 1
var doble_salto_activado = true

var posicion_y
const ALT_MINIMA_SALTO_PARED = -35

var atacando = false


#Tiempo entre pulsaciones para realizar el dash
onready var timer_dash = get_node("Tiempo_Dash")
onready var timer_duracion_dash = get_node("Duracion_Dash")
#Contadores de pulsasiones para el dash
var contador_pulsacion_derecha = 0
var contador_pulsacion_izquierda = 0
var en_dash = false
var dash_activado = false

var oro = 0

var bounce_derecha = false
var bounce_izquierda = false


var area_enemigo
var en_enemigo = false

var col 

#Cargar la barra de vida al inicio
func _ready():
	barra_vida.init(vida_max, vida)
	Save.load_game()
	col = Save.get_coleccionables()
	Save.get_coleccionables_restantes()



#Todo lo relacionado a movilidad
func _physics_process(delta):
	
	
	movimiento.y += GRAVEDAD
	
	var friccion = false
	


	#Movimiento del personaje
	if atacando == false:
		
	
	
		if timer_duracion_dash.is_stopped():
			if Input.is_action_pressed(actions.right):
				movimiento.x = min(movimiento.x + ACELERACION,VELOCIDAD_MAX)
				
				$Sprite.scale.x = 1
				$AnimationPlayer.play("run")
				direccion = 1
				
				
			elif Input.is_action_pressed(actions.left) and en_dash == false:
				movimiento.x = max(movimiento.x - ACELERACION, - VELOCIDAD_MAX)
				
				$Sprite.scale.x = -1
				$AnimationPlayer.play("run")
				direccion = -1
			else:
				$AnimationPlayer.play("idle")
				friccion = true
		
		
			
		#Salto del personaje
		if is_on_floor():
			if Input.is_action_just_pressed(actions.up):
				posicion_y = get_position().y
				contador_salto += 1  #Doble salto 1 
				
				movimiento.y = ALT_SALTO
				
			if friccion == true:
				movimiento.x = lerp(movimiento.x, 0, 0.2)
	
			#Doble salto 2
			if is_on_floor() and contador_salto > 0:
				contador_salto = 0
			
		else:
			#Doble salto 3
			if doble_salto_activado == true:
				if Input.is_action_just_pressed(actions.up) and contador_salto < saltos_max:
					movimiento.y = ALT_SALTO
					contador_salto += 1
	
			if movimiento.y < 0 and movimiento.y < -310:
				#jump
				$AnimationPlayer.play("die")
			
			if friccion == true:
				movimiento.x = lerp(movimiento.x, 0, 0.05)
	
		#Salto en la pared
#		if is_on_wall() and !is_on_floor():
#			movimiento.y /= 1.5
#			if movimiento.x > 0:
#				$Sprite.play(sprites.pared)
#				if Input.is_action_just_pressed(actions.up):
#					movimiento.y = ALT_SALTO
#					movimiento.x -= 350
#			elif movimiento.x < 0:
#				$Sprite.play(sprites.pared)
#				if Input.is_action_just_pressed(actions.up):
#					movimiento.y = ALT_SALTO
#					movimiento.x += 350
#		else:
#			GRAVEDAD = 20
		#-------------------------------------------
		GRAVEDAD = 20
		if(bounce_derecha):
			movimiento.x += 300
			movimiento.y -= 70 
			bounce_derecha = false
		elif(bounce_izquierda):
			movimiento.x -= 300
			movimiento.y -= 70 
			bounce_izquierda = false
			
		
		if en_escalera == true:
			if Input.is_action_pressed(actions.subir):
				movimiento.y -= 1
				movimiento.y = clamp(movimiento.y, -200, -200)
			if Input.is_action_pressed(actions.bajar):
				movimiento.y += 1
				movimiento.y = clamp(movimiento.y, 200, 200)
			if !Input.is_action_pressed(actions.subir) and !Input.is_action_pressed(actions.bajar):
				movimiento.y = 0
				

		
		
		#Verificar si se esta haciendo un dash
		if direccion == 1:
			if !timer_duracion_dash.is_stopped():
				movimiento.x = min(movimiento.x + 200,500)
				movimiento.y = 0
		elif direccion == -1:
			if !timer_duracion_dash.is_stopped():
				movimiento.y = 0
				movimiento.x = max(movimiento.x - 200,-500)
			
		
		#print(analog_velocity)
		
		#Mover al personaje
	
	movimiento = move_and_slide(movimiento, moves.up)


#Ataque
	if Input.is_action_just_pressed(actions.attack):
		atacando = true
		if is_on_floor():
			movimiento.x /= 7
		
		if timer.is_stopped():
		
			#ataque
			
			$AnimationPlayer.play("sword_attack_1")
			
			reiniciar_timer()
			
			
			
	if en_enemigo == true:
		if inmunidad == false:
			vida -= area_enemigo.get_dano()
			barra_vida.establecer_vida(vida)
			
			if (area_enemigo.get_global_position().x < self.position.x ):
				bounce_derecha = true
			else:
				bounce_izquierda= true
			
			
			iniciar_inmunidad(duracion_inmunidad_dano)
			
			#Morir
			#TODO:
			if vida <= 0:
				$AnimationPlayer.play("die")
				queue_free()
# warning-ignore:return_value_discarded
				get_tree().change_scene("res://Scenes/menu.tscn")
				
	


#Tiempo de espera entre ataques
func reiniciar_timer():
	var l = $AnimationPlayer.get_animation("sword_attack_1").length
	timer.set_wait_time(l)
	timer.start()



#Timer de inmunidad cuando se recibe daño
func iniciar_timer_inmunidad(tiempo):
	timer_inmunidad.set_wait_time(tiempo)

func _on_Tiempo_Inmunidad_timeout():
	timer_inmunidad.stop()
	inmunidad = false

func iniciar_inmunidad(tiempo):
	iniciar_timer_inmunidad(tiempo)
	inmunidad = true
	timer_inmunidad.start()



#Detectar collisiones
func _on_Detector_colision_area_entered( area ):
	var grupo = area.get_groups()
	#collision con entidad hostil
	if grupo.has("hostil"):
		
		area_enemigo = area
		en_enemigo = true
				
	#Collision con un poder
	elif grupo.has("activar_doble_salto"):
		doble_salto_activado = true
	elif grupo.has("activar_dash"):
		dash_activado = true

	if grupo.has("escalera"):
		en_escalera = true
		
	if grupo.has("salida"):
		pass
		#print(get_tree().get_nodes_in_group("persistent"))
	
	if grupo.has("coleccionable"):
		col.append(area.name)
		Save.save_game()
		area.get_parent().get_parent().queue_free()

	

func _on_Detector_colision_area_exited( area ):
	var grupo = area.get_groups()
	if grupo.has("escalera"):
		en_escalera = false
	if grupo.has("hostil"):
		en_enemigo = false

	


#Timer de pulsaciones para Dash
func _on_Tiempo_Dash_timeout():
	timer_dash.stop()
	contador_pulsacion_derecha = 0
	contador_pulsacion_izquierda = 0

#Timer de la duracion del dash
func _on_Duracion_Dash_timeout():
	movimiento.x /= 2
	timer_tiempo_entre_dash.set_wait_time(0.2)
	timer_tiempo_entre_dash.start()
	timer_duracion_dash.stop()
	pass 


func _on_Tiempo_Entre_Dash_timeout():
	timer_tiempo_entre_dash.stop()
	pass

func incrementar_oro():
	oro += 1
	Oro_node.set_text(str(oro))


func _on_Saltar_pressed():
	Input.action_press(actions.up)


func _on_Atacar_pressed():
	Input.action_press(actions.attack)
	
func get_state():	
	
	var save_dict = {
		coleccionable= col
	}
	return save_dict

func load_state(data):
	for attribute in data:
		print(data[attribute])


func _on_Tiempo_Entre_Ataques_timeout():
	atacando = false
	timer.stop()
