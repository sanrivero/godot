extends Node2D
class_name PathRoad

var _triangleEnemy = preload("res://scenes/TriangleEnemy.tscn")
var _rectangleEnemy = preload("res://scenes/RectangleEnemy.tscn")
var _wood = preload("res://scenes/Wood.tscn")
#onready var path_follow = $Path2D/PathFollow2D
onready var path2d = $Paths.get_children()
onready var paths = $Paths

onready var timer = $Timer

var startPoint


var enemies: Array = [_triangleEnemy,_rectangleEnemy]
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
