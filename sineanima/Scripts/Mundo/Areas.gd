extends Node2D

const MAIN_GAME = "res://Scenes/Game.tscn"
const AREA_DOS = "res://Scenes/Mundo.tscn"
const AREA_UNO = "res://Scenes/World_1/World_1.tscn"


func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_area_uno_body_entered(body):
	SceneSwitcher.change_scene(MAIN_GAME, {"area":AREA_DOS})



func _on_Area2D_body_entered(body):
	if body and body.is_in_group("Players"):
		SceneSwitcher.change_scene(MAIN_GAME, {"area":AREA_UNO})
