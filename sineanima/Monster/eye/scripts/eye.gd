extends "res://Scripts/Monster.gd"




var movimiento = Vector2()

var en_area = false

var jugador = 0


var mi_posicion
var velocidad = 2




func _physics_process(delta):
	if en_area == true:
		$AnimationPlayer.play("move")
		mi_posicion = get_global_position()
		if int(mi_posicion.x) < int(jugador.get_global_position().x):
			movimiento.x += velocidad
			$Sprite.scale.x = -1

			
		else:
			movimiento.x -= velocidad
			$Sprite.scale.x = 1
		if int(mi_posicion.y) < int(jugador.get_global_position().y):
			movimiento.y += velocidad
		else:
			movimiento.y -= velocidad
	else:
		movimiento.x = 0
		movimiento.y = 0
		
	movimiento.x = clamp(movimiento.x, -30, 30)
	movimiento.y = clamp(movimiento.y, -30, 30)
	move_and_slide(movimiento)
	

func _on_Area2D_area_entered( area ):
	var grupo = area.get_groups()
	if grupo.has("Jugador"):
		jugador = area


func _on_Area2D_area_exited( area ):
	var grupo = area.get_groups()
	if grupo.has("Jugador"):
		en_area = false


func _on_Area_dano_area_entered( area ):
	var grupo = area.get_groups()
	
	if grupo.has("attack"):
		vida -= area.get_damage()
		barra_vida.establecer_vida(vida)
		#self.vampirismo()
		if vida <= 0:
			queue_free()
			


func _on_area_activacion_area_entered(area):
	var grupo = area.get_groups()
	if grupo.has("Jugador"):
		$AnimationPlayer.play("transform")
		en_area = true
