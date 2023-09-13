extends Camera2D

onready var _player = $"../Player"
var stop = 1


func _ready():
	self.global_position = Vector2(self.get_viewport().get_size().x / 2, self.get_viewport().get_size().y / 2)


func _process(delta):
	if(_player.global_position.y < self.global_position.y):
		self.global_position.y = _player.global_position.y
		
	self.global_position.y -= 10 * delta * stop;
