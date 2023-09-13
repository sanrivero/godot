extends PathFollow2D

var start = true
var direction
var speed

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _ready():
	randomize()
	yield(get_parent().get_parent().get_parent(), "ready")
	

func _process(delta):
	set_offset(get_offset() + self.get_child(0).act_velocity * self.get_child(0).direction * delta)
	

func _on_Timer_timeout():
	self.start = true
