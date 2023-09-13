extends Node2D

var speed = 200

var direction:Vector2 = Vector2(0,1)


func _ready():
	pass


func _process(delta):
	self.global_position.y = self.global_position.y + speed * direction.y * delta
	self.global_position.x = self.global_position.x + speed * direction.x * delta


func _on_VisibilityNotifier2D_screen_exited():
	pass
