extends KinematicBody2D


func _physics_process(delta):
	move_and_slide(Vector2(20,13))