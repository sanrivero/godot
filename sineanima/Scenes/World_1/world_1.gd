extends Node2D


const PATHLAYOUT = "res://Scenes/World_1/Zone_1"
onready var _player = get_parent().get_parent().get_node("Player")


onready var _camera: Camera2D = _player.get_camera()
onready var _rooms: Array 
onready var _zones = $Zones

signal room_changed(old_room, new_room)

var new_zones = true

var ant_adjacents = null
const WIDTH_ARRAY = 40

var array = [] 
const quantity_of_zones = 2


var monsters = ["res://Actors/Enemy/Fighter.tscn","res://Actors/Enemy/Spearman.tscn"]
var enviroment = ["res://Scenes/Enviroment/Sakura.tscn",
	"res://Scenes/Enviroment/Green_Tree.tscn",
	"res://Scenes/Enviroment/Rock_1.tscn"]
	
const z_index_monsters = 1

func _ready():
	
	array = _create_array(array)
	
	#Create spawn character zone
	create_spawn(array)
	
	
	_initpj()
	_player.init_camera($Zones.get_child(0))
	_rooms = $Zones.get_children()
	
	set_process(true)
	

func _process(delta):
	
	for room in _rooms:
		# Trans para cambiar a nueva sala cada vez que entramos
		
		if room != _player.curr_room and _player_in_room(_player, room):
			
			_player.prev_room = _player.curr_room
			_player.curr_room = room

			# Se pausa el procesamiento de la sala que estabamos, se va a la nueva, y
			# se comienza a procesar la nueva sala cuando la transición esta
			# completa.
			_player.prev_room.pause()
			_camera.transition(_player.prev_room, _player.curr_room)
			yield(_camera, 'transition_completed')
			_player.curr_room.resume()

			emit_signal('room_changed', _player.prev_room, _player.curr_room)


func update_rooms() -> void:
	_rooms = $Zones.get_children()
	
func _player_in_room(player: Player, room: Zone) -> bool:
	#var bounds := Rect2(room.get_global_position(), room.get_room_dimensions())
	
	var bounds := Rect2(room.get_global_position(), room.size)
	
	return bounds.has_point(player.get_global_position())

func _create_array(_array:Array) -> Array : 
	
	
	
	for x in WIDTH_ARRAY:
		randomize()
		var zone = randi()%(self.quantity_of_zones)+1
		_array.append ( {
			"zone" : zone,
			"scene" : PATHLAYOUT +"/" + str(zone) + ".tscn",
			"in_game": true,
			"size": Vector2(0,0)
		})
	
	
	return _array
	
func create_spawn(array:Array) -> Array:
	
	var long_counter = 0
	var zone 
	var contador_spawn 
	for x in WIDTH_ARRAY:
		zone = load(array[x].scene).instance()
		array[x].size = zone.size
		
		if(x == 0):
			zone.set_position(Vector2(0,0))
			long_counter+=zone.size.x
		else:
			zone.set_position(Vector2(long_counter,0))
			long_counter+=zone.size.x

		if(zone.has_node("spawn_monster")):
	
			contador_spawn = zone.get_node("spawn_monster").get_child_count() #Obtengo la cantidad de spawns
			for n in range ( contador_spawn ):         #recorro cada spawn para agregar un bicho
				var scene_instance
				randomize()
				var monster = load(monsters[((randi()%monsters.size()+1)-1)])
				scene_instance = monster.instance()    #capaz hay que hacer set_name
				#scene_instance.init(25,100,100)
	
				var position = zone.get_node("spawn_monster").get_child(n)
				scene_instance.position = position.get_position()
				scene_instance.set_z_index(z_index_monsters)
				zone.get_node("spawns").get_node("monsters").add_child(scene_instance) 
				#mapa.add_child(scene_instance)        #agrego al bicho al nodo monsters
		if(zone.has_node("spawn_enviroment")):
	
			contador_spawn = zone.get_node("spawn_enviroment").get_child_count() #Obtengo la cantidad de spawns
			for n in range ( contador_spawn ):         #recorro cada spawn para agregar un bicho
				var scene_instance
				randomize()
				var prop = load(enviroment[((randi()%enviroment.size()+1)-1)])
				scene_instance = prop.instance()    #capaz hay que hacer set_name
				#print(scene_instance.texture.get_size().x / 2)
				#scene_instance.init(25,100,100)
	
				var positionProp = zone.get_node("spawn_enviroment").get_child(n)
				positionProp.position.y = positionProp.position.y - ( scene_instance.get_node("CollisionShape2D").shape.extents.y  )
				scene_instance.position = positionProp.get_position()
				scene_instance.set_z_index(1)
				zone.get_node("spawns").get_node("enviroment").add_child(scene_instance) 
				#mapa.add_child(scene_instance)        #agrego al bicho al nodo monsters
		
		$Zones.add_child(zone)
	
	return array




func _initpj():
	_player.set_position(Vector2(50,50))
	
func get_all_nodes(node):
	for N in node.get_children():
		if N.get_node("spawns"):
			print("["+N.get_name()+"]")
			#if(N.get_name() == "spawns"):
				#print("["+N.get_name()+"]")
			#get_all_nodes(N)
		


func _on_World_1_room_changed(old_room, new_room):
	pass
