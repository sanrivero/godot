extends Sprite

onready var animationPlayer = $AnimationPlayer

var direction = Vector2(0, 1)
var speed = 200

func _ready():
	animationPlayer.play("Laser")

func _physics_process(delta):
	look_at(direction)

func _on_AnimationPlayer_animation_finished(anim_name):
	queue_free()
