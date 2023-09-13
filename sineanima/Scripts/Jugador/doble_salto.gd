extends TextureButton

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process_input(true)
	
	
func _input(event):
	
	if ((event is InputEventMouseButton) or (event is InputEventScreenTouch)) and event.is_pressed() and  get_parent().get_global_rect().has_point(Vector2(event.position.x, event.position.y)):
		
		print(get_tree().get_root().get_node("Game/Jugador").skill.negate_double_jump())
		
		"""if (get_tree().get_root().get_node("Game/Jugador").doble_salto_activado):
			get_tree().get_root().get_node("Game/Jugador").doble_salto_activado = false
			
		else:
			get_tree().get_root().get_node("Game/Jugador").doble_salto_activado = true
			
		"""
	
