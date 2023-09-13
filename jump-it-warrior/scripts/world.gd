extends Node


const PATHLAYOUT = "res://scenes/zone"
##onready var jugador = get_parent().get_parent().get_node("player")



func _ready():

	

	pass

func create_plataform():
	var platform = 0
	var mapa = 0
	var counter_spawn = 0
	
	randomize()
	var x  = randi()%(3)+1

	randomize()
	
	
	platform = load(PATHLAYOUT + str(x) +".tscn")
	
	mapa = platform.instance()
	mapa.set_position(get_node("CanvasLayer/spawn_"+ str(x)).get_node("Position2D").get_position())
	counter_spawn = get_node("spawn_" + str(x)).get_child_count() #Obtengo la cantidad de spawns
	
	if( counter_spawn < 3 ): 
		get_node("spawn_" +str(x)).add_child(mapa) 
		
	
	
	pass 
	


func _on_Timer_timeout():
	
	var peru 
	peru = Vector2 ( get_node("player").get_position().x + 100 , get_node("CanvasLayer/spawn_2/Position2D").get_position().y )
	print ( peru ) 
	
	get_node("CanvasLayer/spawn_1/Position2D").set_position( Vector2 ( get_node("player").get_position().x + 100 , get_node("CanvasLayer/spawn_1/Position2D").get_position().y))
	get_node("CanvasLayer/spawn_2/Position2D").set_position( Vector2 ( get_node("player").get_position().x + 100 , get_node("CanvasLayer/spawn_2/Position2D").get_position().y))  
	get_node("CanvasLayer/spawn_3/Position2D").set_position( Vector2 ( get_node("player").get_position().x + 100 , get_node("CanvasLayer/spawn_3/Position2D").get_position().y))   
	
	self.create_plataform()
	pass # replace with function body
