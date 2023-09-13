extends Area2D


func _on_Area2D_body_entered( body ):
	var grupo = body.get_groups()
	if grupo.has("jugador"):
		queue_free()
