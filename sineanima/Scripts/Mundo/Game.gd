extends Node

export (PackedScene) var tree

func _ready():
	var current_location = SceneSwitcher.get_param("area")
	var mundo = load(current_location) # load scene from file
	var node = mundo.instance() #Create a new instance of the house

	get_node("Level").add_child(node) #Add the actual node to the scene tree
	

