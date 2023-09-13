extends Path2D

onready var follow = get_node("PathFollow2D")

func _ready():
	$PathFollow2D/sierra/Sprite.play("idle")
	pass

func _process(delta):
	follow.set_offset(follow.get_offset() + 0.8)
