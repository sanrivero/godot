extends Sprite

var fire_1 = preload("res://Assets/fire1.png")
var fire_2 = preload("res://Assets/fire2.png")
var fire_3 = preload("res://Assets/fire3.png")

onready var animationPlayer = $AnimationPlayer


func _ready():
	animationPlayer.play("fire_1")

func change_fire_sprite(value):
	if value == 1:
		set_texture(fire_1)
	elif value == 2:
		set_texture(fire_2)
	else:
		set_texture(fire_3)
