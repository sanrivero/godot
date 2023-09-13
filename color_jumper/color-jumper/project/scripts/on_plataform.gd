extends PlayerState

var area 

func enter(msg := {}) -> void:
	area = msg.get("area")

func physics_update(delta: float) -> void:
	
	if Input.is_action_pressed("ui_up"):
		state_machine.transition_to("Run", {move = Movements.UP})
	elif Input.is_action_pressed("ui_down"):
		state_machine.transition_to("Run", {move = Movements.DOWN})
		
	player.global_position.x = player.global_position.x + area.get_parent().speed * area.get_parent().direction * delta
	
	
func _moveTo(vector):
	player.tween.interpolate_property(player, "global_position", player.global_position , vector, 0.3,  Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	player.tween.start()
