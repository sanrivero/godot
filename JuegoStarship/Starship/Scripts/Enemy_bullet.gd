extends Sprite


var direction = Vector2(0, 1)

onready var animationPlayer = $AnimationPlayer

var speed = 200 # pixels / s

func _ready():
	animationPlayer.play("Idle")
	set_as_toplevel(true)

func _physics_process(delta):
	global_position += direction * speed * delta

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()

