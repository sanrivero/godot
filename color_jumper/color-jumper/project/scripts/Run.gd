extends PlayerState

func enter(msg := {}) -> void:
	move = msg.get("move")

func physics_update(delta: float) -> void:
	match(move):
		Movements.UP:
			player.animation_player.play("move_updown")
			if(player.on_water_top):
				player.morir()
			player._incrementScore()
			_moveTo(Vector2(player.global_position.x, player.global_position.y - player.movement_position))
		Movements.DOWN:
			player.animation_player.play("move_updown")
			if(player.on_water_bot):
				player.morir()
			player._decrementScore()
			_moveTo(Vector2(player.global_position.x, player.global_position.y + player.movement_position))
		Movements.RIGHT:
			player.animation_player.play("move_leftright")
			_moveTo(Vector2(player.global_position.x + player.movement_position, player.global_position.y))
		Movements.LEFT:
			player.animation_player.play("move_leftright")
			_moveTo(Vector2(player.global_position.x - player.movement_position, player.global_position.y))
	
	
	state_machine.transition_to("Idle")
	
	
func _moveTo(vector):
	var pos_x = int(round(vector.x))
	var mod = pos_x % 16
	vector.x = pos_x - mod + 8
	
	var pos_y = int(round(vector.y))
	var mod_y = int(abs(pos_y)) % 16
	vector.y = pos_y - mod_y + 8
	
	player.tween.interpolate_property(player, "global_position", player.global_position , vector, 0.25,  Tween.TRANS_EXPO, Tween.EASE_IN_OUT)
	player.tween.start()

