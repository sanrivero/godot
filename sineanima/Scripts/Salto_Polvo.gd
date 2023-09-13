extends Area2D

func _process(delta):
	$AnimatedSprite.play("Salto_Polvo")

func _on_AnimatedSprite_animation_finished():
	queue_free()

