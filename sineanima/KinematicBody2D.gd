extends "res://Scripts/Monster.gd"


var movimiento = Vector2()



func _physics_process(delta):
	movimiento.x += 10
	
	move_and_slide(movimiento)
	
	pass
