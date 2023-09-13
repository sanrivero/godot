extends Area2D

func _ready():
	pass

func _on_Area2D_body_entered( body ):
	var grupo = body.get_groups()
	if grupo.has("Jugador"):
		body.incrementar_oro()
		queue_free()
