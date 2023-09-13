# Idle.gd
extends PlayerState

var isRunTweenFinished:bool = true

# Upon entering the state, we set the Player node's velocity to zero.
	
func enter(_msg := {}) -> void:
	if(!state_machine.is_connected("transitioned",self,"exit_platform")):
		state_machine.connect("transitioned",self,"exit_platform")
	# We must declare all the properties we access through `owner` in the `Player.gd` script.
	player.velocity = Vector2.ZERO


func update(delta: float) -> void:
	
	if(!isRunTweenFinished):
		return
	
	if Input.is_action_pressed("ui_up"):
		state_machine.transition_to("Run", {move = Movements.UP})
	elif Input.is_action_pressed("ui_left"):
		state_machine.transition_to("Run", {move = Movements.LEFT})
	elif Input.is_action_pressed("ui_right"):
		state_machine.transition_to("Run", {move = Movements.RIGHT})
	elif Input.is_action_pressed("ui_down"):
		state_machine.transition_to("Run", {move = Movements.DOWN})


func _on_Tween_tween_completed(object, key):
	player.get_node("Area2D/CollisionShape2D").disabled = false
	isRunTweenFinished = true

func _on_Tween_tween_started(object, key):
	isRunTweenFinished = false
	
func exit_platform(pre_name, act_name):
	
	if(pre_name == "OnPlatform" and act_name == "Run"):
		player.on_log = true
