extends KinematicBody2D

var mi_posicion = Vector2()
var pos_jugador = Vector2(10,0)
var movimiento = Vector2()



func _ready():
	#print(get_global_position())
	pass

func _physics_process(delta):
	
	if (mi_posicion.x) < (pos_jugador.x):
			movimiento.x = pos_jugador.x - mi_posicion.x
	else:
		movimiento.x = -(mi_posicion.x - pos_jugador.x)
	if (mi_posicion.y) < (pos_jugador.y):
		movimiento.y = pos_jugador.y - mi_posicion.y
	else:
		movimiento.y = -(mi_posicion.y - pos_jugador.y)
	
	move_and_slide(movimiento)
	pass
	
func iniciar(jugador):
	pos_jugador = jugador
	mi_posicion = get_global_position() 


func _on_Area2D_area_entered( area ):
	var grupo = area.get_groups()
	if grupo.has("Jugador"):
		queue_free()



func _on_Area2D_body_entered( body ):
	var grupo = body.get_groups()
	if !grupo.has("centinela"):
		queue_free()
