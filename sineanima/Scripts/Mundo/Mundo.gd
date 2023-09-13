extends "res://Scripts/Mundo/WorldParent.gd"


const PATHLAYOUT = "res://Scenes/Mundo/Zone_"
onready var _player = get_parent().get_parent().get_node("Player")


onready var _camera: Camera2D = _player.get_camera()
onready var _rooms: Array = $Zones.get_children()
onready var _zones = $Zones

signal room_changed(old_room, new_room)

var new_zones = true


var matriz 
var packed_scene = PackedScene.new()

func _ready():
	
	matriz = crear_matrix(matriz)
	
	matriz = insertarEntradaySalida(matriz)	
	matriz = insertarBajadas(matriz)	
	matriz = inc1(matriz)
	matriz = incluir_1_4(matriz)
	
#	imprimir_matriz(matriz)
	
	crear_nivel(matriz,PATHLAYOUT,_zones)
	
	
	_initpj(_player)
	_player.init_camera($Zones.get_child(0))
	set_process(true)
	
	#get_parent().get_parent().get_node("Hud").show_seleccion()
	
	#print_tree_pretty ( )
	##print(get_node("spawns"))
	#for x in get_parent().get_child(0).get_children():
	#	print(x.get_name())
		
	#print((get_tree().get_nodes_in_group("spawns")))
	#print(get_parent().get_tree().get_nodes_in_group("spawns"))
	#print(get_parent().get_child(0).get_node("spawns"))
	#print(get_tree().get_root().get_nodes_in_group("Mundo"))
	#print(get_tree().get_root().find_node("spawns",true,false))
	#var ar = []
	#getallnodes(get_parent())
	
	
	#get_parent().get_parent().get_node("Hud/matrix").set_text(str(matriz))
	pass
	

func _process(delta):
	var position_player = in_what_chunk(_player.get_global_position().y,_player.get_global_position().x)
	#var position_player = in_what_chunk(comienzo.x,comienzo.y)
	#print(position_player)
	#print(get_adjacent(position_player))
	var adjacents = get_adjacent(position_player)
	#print(adjacents)
	#generated_matrix = clear_matrix(matriz)
	if(new_zones):
		_rooms = $Zones.get_children()
	#Marcar en generated_matrix la zona 5
	
	for room in _rooms:
		# Transition to room once we enter a new one.
		if room != _player.curr_room and _player_in_room(_player, room):
			
			_player.prev_room = _player.curr_room
			_player.curr_room = room

			# Pause processing on the old room, transition to the new one, and
			# then begin processing on the new room once the transition is
			# complete.
			_player.prev_room.pause()
			_camera.transition(_player.prev_room, _player.curr_room)
			yield(_camera, 'transition_completed')
			_player.curr_room.resume()

			emit_signal('room_changed', _player.prev_room, _player.curr_room)

	for i in adjacents.size():
		if(matriz[adjacents[i].x][adjacents[i].y].in_game != true ):
			matriz[adjacents[i].x][adjacents[i].y].in_game = true
			#print(adjacents)
			crear_zona(matriz[adjacents[i].x][adjacents[i].y].zone, MOVIMIENTO_X * adjacents[i].x, MOVIMIENTO_Y  * adjacents[i].y , PATHLAYOUT,_zones)
			new_zones = true
			#get_all_nodes(self)
		else:
			pass
			#print("Esta ocupado manito")
	
	new_zones = true
	
func update_rooms() -> void:
	_rooms = $Zones.get_children()
	
func _player_in_room(player: Player, room: Zone) -> bool:
	#var bounds := Rect2(room.get_global_position(), room.get_room_dimensions())
	
	var bounds := Rect2(room.get_global_position(), room.size)
	
	return bounds.has_point(player.get_global_position())
	
func iterate_nodes():
	pass

func clear_matrix():
	pass
	
func get_all_nodes(node):
	for N in node.get_children():
		if N.get_node("spawns"):
			print("["+N.get_name()+"]")
			#if(N.get_name() == "spawns"):
				#print("["+N.get_name()+"]")
			#get_all_nodes(N)
		
