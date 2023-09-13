# Character that moves and jumps.
class_name Player
extends KinematicBody2D

onready var movement_position = $Sprite.texture.get_size().y

var max_score = 0
var actual_score = 0
var on_water_top = false
var on_water_bot = false
var on_log = false
var on_ground = false

var updated_pos : Vector2

var velocity

onready var fsm := $StateMachine
onready var label := $Label
onready var tween = $Tween
onready var ray_cast_top = $RayCastTop
onready var ray_cast_bot = $RayCastBot

onready var animation_player = $AnimationPlayer

func _ready():
	self.global_position =  Vector2((self.get_viewport().get_size().x / 2) + 8, self.get_viewport().get_size().y / 2)
	print(global_position)


func _process(_delta: float) -> void:

	label.text = fsm.state.name
	if(ray_cast_top.is_colliding()):
		if(ray_cast_top.get_collider().is_in_group("Water")):
			on_water_top = true
		else:
			on_water_top = false
	else:
		on_water_top = false
	if(ray_cast_bot.is_colliding()):
		if(ray_cast_bot.get_collider().is_in_group("Water")):
			on_water_bot = true
		else:
			on_water_bot = false
	else:
		on_water_bot = false

func _incrementScore():
	if(max_score == actual_score):
		max_score += 1
		actual_score += 1
	else:
		actual_score += 1
		
func _decrementScore():
	actual_score -= 1

func morir():
	get_tree().change_scene("res://GameOver.tscn")

func _on_Area2D_area_entered(area):
	if(area.is_in_group("Hostile")):
		morir()
