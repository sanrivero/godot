extends Node

#Tamaño del mapa de la matriz(1 unidad = 1 zona)

const WIDTH = 4   ##columas x 
const HEIGHT = 4 ## filas  y

#Tamaño del array
const WIDTH_ARRAY = 3

#Identificadores de tipo de zona
const ENTRADA = 5
const LR = 1
const LRB = 2
const LRT = 3
const SALIDA = 6
const CERRADO = 4

#Indicadores varios

const z_index_monsters = 1


#Distancia entre cada zona
const MOVIMIENTO_Y = 608
const MOVIMIENTO_X = 290




#Zona donde empieza el jugador
var comienzo = Vector2()


var piedra

var monsters = ["res://Actors/Enemy/Skeleton.tscn"]
#var monsters = ["res://Monster/skeleton/scenes/skeleton.tscn"]
#"res://Monster/bat/scenes/bat.tscn"]
				#"res://Monster/eye/scenes/eye.tscn",
				

func in_what_chunk(valueX,valueY) -> Vector2:
	var _position =  Vector2()
	#print("value" + str(round(valueX)) + "_" + str(round(valueY)))
	
	for x in WIDTH:
		if(MOVIMIENTO_X * (x +1) >= valueX):
			_position.x = x
			break
	for y in HEIGHT:
		if(MOVIMIENTO_Y *  (y +1) >= valueY):
			_position.y = y
			break
	
	
	return _position
	
func get_adjacent(position):
	var adjacents = []
	
	#TOP
	if(position.x - 1 < HEIGHT and position.x-1 >=0):
		adjacents.append(Vector2(position.x-1 , position.y ))
	#Bottom
	if(position.x + 1 < HEIGHT ):
		adjacents.append(Vector2(position.x+1 , position.y ))
	#Left
	if(position.y - 1 < WIDTH  and position.y-1 >=0):
		adjacents.append(Vector2(position.x , position.y-1 ))
	#Right
	if(position.y + 1 < WIDTH  ):
		adjacents.append(Vector2(position.x , position.y+1 ))
	
	return adjacents
	
	

func _ready():	
	piedra = load("res://Scenes/Piedra.tscn")	
	
func crear_matrix(matriz):
	matriz = []
	for x in range(WIDTH):
		matriz.append([])
		matriz[x]=[]
		for y in range(HEIGHT):
			matriz[x].append([])
			matriz[x][y]= {
				"zone" : 0,
				"scene" : null,
				"in_game": false
			}
	return matriz
			
func insertarEntradaySalida(matriz):
	randomize()
	var posicion_entrada = randi()%(self.WIDTH)+1
	randomize()
	var posicion_salida = randi()%(self.WIDTH)+1
	posicion_salida-=1
	posicion_entrada-=1
	
	matriz[0][posicion_entrada].zone = self.ENTRADA
	matriz[self.WIDTH-1][posicion_salida].zone = self.SALIDA
	
	return matriz
	

func columna_vacia_en_fila(fila,matriz):
	randomize()
	var y  = randi()%(self.HEIGHT)+1
	y-=1
	randomize()
	
	while(matriz[fila][y].zone!=0 ):
		randomize()
		y  = randi()%(self.HEIGHT)+1
		y-=1
	return y
	
func insertarBajadas(matriz):
	var y
	for x in range(WIDTH-1):
		y= columna_vacia_en_fila(x,matriz)
		if( x != 3):
			matriz[x][y].zone = 2
		if(x+1 < self.WIDTH):
			matriz[x+1][y].zone = 3
	return matriz

func incluir_1_entre(matriz):
	var escribir
	
	
	for y in range(HEIGHT):
		escribir = false
		for x in range (WIDTH):
			if(!escribir && matriz[y][x] ==0):
				escribir= true
			else:
				if(matriz[y][x] == 0):
					matriz[y][x].zone = 1
				else:
					 break
	return matriz
	
func inc1(matriz):
	for x in range(WIDTH):
		var ini = 0
		var fin= 0
		for y in range (HEIGHT-1):
			if(matriz[x][y].zone == 2) or (matriz[x][y].zone == 3) or (matriz[x][y].zone == 5) or (matriz[x][y].zone == 6):
				ini = y
				break
		
		for j in range(HEIGHT):
			if( j > ini ):
				if(matriz[x][j].zone == 2) or (matriz[x][j].zone == 3) or (matriz[x][j].zone == 5) or (matriz[x][j].zone == 6):
					fin = j
					break
		var i = fin -1
		var t = ini +1
		
		for r in range(HEIGHT):
			if(r>=t) && (r<=i):
				matriz[x][r].zone= 1
			
	return matriz

func incluir_1_4(matriz):
	for x in range(WIDTH):
		for y in range ( HEIGHT):
			if(matriz[x][y].zone == 0):
				matriz[x][y].zone = obtener_1_4()
	return matriz

func obtener_1_4():
	var nums = [1,4] #list to choose from
	randomize()
	return nums[randi() % nums.size()]
	


func create_zone(matrix,x,y, path,_zones):
	if matrix[y][x] == ENTRADA:
# warning-ignore:integer_division
		print("Empieza en " + str(y +""+ x))
		comienzo = Vector2(MOVIMIENTO_X * x +(MOVIMIENTO_X/2),MOVIMIENTO_Y * y +(MOVIMIENTO_Y/2))
	crear_zona(matrix[y][x], MOVIMIENTO_X * x, MOVIMIENTO_Y * y  ,path,_zones)


func crear_nivel(matrix, path,_zones):
	var mov_x = 0
	var mov_y = 0
	
	for x in range(WIDTH):
		for y in range(HEIGHT):
			if matrix[x][y].zone == ENTRADA:
# warning-ignore:integer_division
				print("Empieza en " + str(x) + "    "+str(y))
				comienzo = Vector2(mov_y+(MOVIMIENTO_Y/2),mov_x+(MOVIMIENTO_X/5))
				matrix[x][y].in_game = true
				crear_zona(matrix[x][y].zone,mov_x,mov_y, path,_zones)
			#crear_zona(matrix[y][x],mov_x,mov_y, path)
			mov_y += MOVIMIENTO_Y
		mov_y = 0
		mov_x += MOVIMIENTO_X
	

func crear_zona(pos,x,y,path,_zones):
	#print(path + str(pos) +"/1.tscn")
	#print("Position y : " + str(y ))
	#print("Position x : " + str(x ))
	var nivel1 = 0
	var mapa = 0
	var contador_spawn = 0
	nivel1 =  load(path + str(pos) +"/1.tscn")
	
	#nivel1.type = 5
	mapa = nivel1.instance()
	mapa.set_position(Vector2(y,x))
	mapa.z_index = WIDTH - x
	mapa.type = pos
	
	"""
	if(mapa.has_node("spawn_monster")):

		contador_spawn = mapa.get_node("spawn_monster").get_child_count() #Obtengo la cantidad de spawns
		for n in range ( contador_spawn ):         #recorro cada spawn para agregar un bicho
			var scene_instance
			randomize()
			var monster = load(monsters[((randi()%monsters.size()+1)-1)])
			scene_instance = monster.instance()    #capaz hay que hacer set_name
			#scene_instance.init(25,100,100)

			var position = mapa.get_node("spawn_monster").get_child(n)
			scene_instance.position = position.get_position()
			scene_instance.set_z_index(z_index_monsters)
			mapa.get_node("spawns").get_node("monsters").add_child(scene_instance) 
			#mapa.add_child(scene_instance)        #agrego al bicho al nodo monsters
			
	if(mapa.has_node("spawn_monedas")):
		contador_spawn = mapa.get_node("spawn_monedas").get_child_count()
		for n in range (contador_spawn):
			randomize()
			if ( randi()%2+1 == 2):
				#var piedra = preload("res://Scenes/Piedra.tscn")
				var piedra_instance = piedra.instance()
				var position_piedra = mapa.get_node("spawn_monedas").get_child(n)
				piedra_instance.position = position_piedra.get_position()
				mapa.get_node("spawns").get_node("monedas").add_child(piedra_instance)
				#mapa.add_child(piedra_instance)

	if(mapa.has_node("spawn_coleccionables")):
		contador_spawn = mapa.get_node("spawn_coleccionables").get_child_count()
		var coleccion_toworld = Save.get_coleccionables_restantes()
		var quantity_of_coleccionables = coleccion_toworld.size()
		if not(coleccion_toworld.empty()): #me fijo si no hay mas coleccionables
			var rand = randi()%quantity_of_coleccionables+1
			for n in range(contador_spawn):
				if not(coleccion_toworld.empty()):
					rand -= 1
					var coleccionable = load("res://Scenes/Coleccionables/" + coleccion_toworld[rand] + ".tscn")
					coleccion_toworld.remove(rand)
					var coleccionable_instance = coleccionable.instance()
					var position_coleccionable = mapa.get_node("spawn_coleccionables").get_child(n)
					coleccionable_instance.position = position_coleccionable.get_position()
					mapa.get_node("spawns").get_node("coleccionables").add_child(coleccionable_instance)
				else:
					break
	"""
	_zones.add_child(mapa)


func _initpj(jugador):
	jugador.set_position(comienzo)

func imprimir_matriz(matrix):
	
	for x in range(WIDTH):
		print(matrix[x][0].zone)
		

		
