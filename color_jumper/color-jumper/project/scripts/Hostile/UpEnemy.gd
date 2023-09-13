extends Node2D

var speed = 80


func _ready():
	pass # Replace with function body.


func _process(delta):
	self.global_position.y = self.global_position.y + speed * delta

