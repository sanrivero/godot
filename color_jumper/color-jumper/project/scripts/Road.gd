extends PathRoad

var enemies_list = []
# Called when the node enters the scene tree for the first time.
func _ready():
	var path_follow
	var distance = 0
	
	
	for path in path2d:

		path_follow = path.get_child(0)

		var dup

		randomize()
		startPoint = round(rand_range(0, 1))
		timer.set_wait_time(rand_range(0, 5))
		timer.start()
		
		var enemy_amount = round(rand_range(1, GlobalParams.enemies_on_road))

		var element
		
		var enemy_velocity = rand_range(30,100)
		
		for i in enemy_amount-1:
			dup = path_follow.duplicate()
			path.add_child(dup)
		
		for path_f in path.get_children():
			element = enemies[randi()%enemies.size()].instance()
		
			element.velocity = enemy_velocity
			path_f.add_child(element)
			element.initial_pos = path_f.get_parent().get_curve().get_point_position(0)
			element.direction = 1
			element.start_point = startPoint
			if(startPoint == 1):
				element.get_child(0).flip_h = true
				element.direction = -1
			path_f.set_unit_offset(startPoint + distance * element.direction)
			enemies_list.append(element)
	move_next_enemy()
		
func move_next_enemy():
	if(!enemies_list.empty()):
		enemies_list.pop_front().start = true


func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
	
