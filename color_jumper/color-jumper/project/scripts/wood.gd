extends Node2D

onready var _tween = $Tween

var direction
var movement_completed = true
var speed = 30


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_parent().get_node("Timer"), "timeout")
	pass # Replace with function body.

func _process(delta):
	self.global_position.x = self.global_position.x + speed * direction * delta
	
func _move(vector):
	_tween.interpolate_property(self, "global_position", self.global_position , vector, 1,  Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	_tween.start()

func _on_Area2D_area_entered(area):
	if(area.is_in_group("Player")):
		area.get_parent().on_log = true
		area.get_parent().fsm.transition_to("OnPlatform",{area = $Area2D})

