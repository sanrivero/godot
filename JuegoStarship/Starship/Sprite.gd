extends Node2D


onready var pos = $Position2D
onready var spri = $Sprite

func _process(delta):
	
	
	pos.global_position = pos.global_position.linear_interpolate(get_global_mouse_position(), delta*2)
	spri.look_at(pos.get_global_position())
