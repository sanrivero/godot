extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Alpha_Tween.interpolate_property(self, "modulate", Color(1,1,1,1), Color(1,1,1,0), .6,Tween.TRANS_SINE,Tween.EASE_OUT)
	$Alpha_Tween.start()

func _on_Alpha_Tween_tween_completed(object, key):
	self.queue_free()
