extends Area2D


func _on_Poder_Doble_Salto_body_entered( body ):
	var grupo = body.get_groups()
	if grupo.has("jugador"):
		queue_free()
