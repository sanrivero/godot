extends ParallaxLayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	set_process(true)

func _process(delta):
	var curPos= get_position()
	if(curPos.x <= -256):
		curPos.x = -10
	else: 
		curPos.x = curPos.x - 100 * delta
	
	set_position(curPos)
