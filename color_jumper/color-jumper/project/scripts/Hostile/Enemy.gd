extends Node2D
class_name Enemy

var velocity: float
var act_velocity: float = 0
var start = false
var start_point
var interes_point
var center = false

var initial_pos: Vector2

var direction: int

func _ready():
	if(get_parent().position.x == 0):
		center = true
	
func _process(delta):
	if (start):
		move()
		
		if(start_point == 0):
			interes_point = 1
		else:
			interes_point = get_parent().get_parent().get_curve().get_point_count() - 2
		#print(get_parent().get_parent().get_curve().get_point_position(interes_point))
		
		if(center):
			if(abs(get_parent().position.x) >= abs(get_parent().get_parent().get_curve().get_point_position(interes_point).x) ):
				#print("aaaaaaaaaaaaaaaaaaaaaaaaaaa")
				#print(get_parent())
				get_parent().get_parent().get_parent().get_parent().move_next_enemy()
				start = false
		else:
			if(abs(get_parent().position.x) <= abs(get_parent().get_parent().get_curve().get_point_position(interes_point).x) ):
				#print("aaaaaaaaaaaaaaaaaaaaaaaaaaa")
				#print(get_parent())
				get_parent().get_parent().get_parent().get_parent().move_next_enemy()
				start = false
			
	
func move():
	act_velocity = velocity
	
func _destroy():
	queue_free()


