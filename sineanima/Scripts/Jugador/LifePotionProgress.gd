extends TextureProgress

var timer = 0

var curacion = 15


func _ready():
	set_process_input(true)
	
	
func _input(event):
	
	if ((event is InputEventMouseButton) or (event is InputEventScreenTouch)) and event.is_pressed() and  get_parent().get_global_rect().has_point(Vector2(event.position.x, event.position.y)) and ( self.value >= 100):
		self.value = 0
		get_tree().get_root().get_node("Game/Jugador").barra_vida.establecer_vida(get_tree().get_root().get_node("Game/Jugador").vida + curacion)
		get_tree().get_root().get_node("Game/Jugador").vida = get_tree().get_root().get_node("Game/Jugador").vida + curacion 
	
"""

func _process(delta):
	timer += 1
	self.set_value(timer - 1)
		"""
