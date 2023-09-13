extends WaterRoad

var generate = true


# Called when the node enters the scene tree for the first time.
func _ready():
	#es index 1 porque index 0 ahora pertenece a Global_parameters
	get_tree().get_root().get_child(1).water_direction = get_tree().get_root().get_child(1).water_direction * -1
	direction = get_tree().get_root().get_child(1).water_direction
	randomize()
	timer.set_wait_time(rand_range(0, 5))
	timer.start()
	
	
func _process(delta):
	
	if(generate):
		generate = false
		var element = water_elements[randi()%water_elements.size()].instance()
		self.add_child(element)
		#print(path2d.get_curve().get_point_count())
		if(direction != 1):
			element.get_child(0).flip_h = true
			direction = direction 
			element.global_position.x = self.global_position.x + 88
		else:
			direction = direction
			element.global_position.x = self.global_position.x - 88
			
		element.direction = direction
		
		timer.set_wait_time(rand_range(2,3))
		timer.start()
	
	


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()



func _on_Timer_timeout():
	generate = true

