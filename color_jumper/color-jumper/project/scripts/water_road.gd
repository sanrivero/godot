extends Node2D
class_name WaterRoad

var _wood = preload("res://scenes/Wood.tscn")

onready var timer = $Timer

var startPoint
var direction = 1

var water_elements: Array = [_wood]

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
