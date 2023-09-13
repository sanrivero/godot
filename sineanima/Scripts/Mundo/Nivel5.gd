extends Node2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_Area2D_area_entered(area):
	get_parent().get_parent().get_parent().get_node("Hud").show_seleccion()
	#SceneSwitcher.change_scene("res://Scenes/Game.tscn", {"area":AREA_DOS})
	pass
