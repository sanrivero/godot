extends Sprite

const BULLET_SCENE = preload("res://Scenes/Enemy_bullet.tscn")

var aim_direction = Vector2.DOWN

func _input(event):
	if event is InputEventKey and event.pressed:
		if event.scancode == KEY_SPACE:
			shoot()
			
func _process(delta):
	aim_direction = global_position.direction_to(get_global_mouse_position())


func shoot():       
	for angle in [-45, -22.5, 0, 22.5, 45]:
		var main = get_tree().current_scene
		var radians = deg2rad(angle)
		var bullet = BULLET_SCENE.instance()
		bullet.direction = aim_direction.rotated(radians)
		main.add_child(bullet)
		bullet.global_position = get_global_position()
		
