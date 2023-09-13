extends Node2D

var coleccionables 

func _ready():
	coleccionables = load_coleccionables()
	get_node("Hud/coleccion").set_text(str(coleccionables))
	print("La información se guardo en: " + OS.get_user_data_dir())
	
	
func load_coleccionables():
	return Save.get_coleccionables()
