extends KinematicBody2D


var actions = {'left': "ui_left",
             'right': "ui_right",
             'up': "ui_up",
			 'attack': "ui_accept",
			'subir' : "ui_subir",
			'bajar' : "ui_bajar"}
			
const moves = {'right': Vector2(25,5),
             'left': Vector2(-25,5),
             'up': Vector2(0, -1),
             'down': Vector2(0, 1)}
			
#Variables de movimiento
var GRAVEDAD = 20
const ACELERACION = 20
const VELOCIDAD_MAX = 200
const ALT_SALTO = -400
#Variable que almaneza direccion (para el movimiento)
var movimiento = Vector2()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):

func _physics_process(delta):
	movimiento.y += GRAVEDAD
	movimiento.x += 10
	movimiento.x = min(movimiento.x + ACELERACION,VELOCIDAD_MAX)
	
	if is_on_floor():
			if Input.is_action_just_pressed(actions.up):
				#contador_salto += 1  #Doble salto 1 
				
				movimiento.y = ALT_SALTO
	
	movimiento = move_and_slide(movimiento, moves.up)