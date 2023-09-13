extends CanvasLayer



var popupseleccion = null

var vampirismo = null

onready var control_1 = get_node("Control_1")
onready var control_2 = get_node("Control_2")
onready var control_3 = get_node("Control_3")

var buttons_powers = ["res://Scenes/Poderes/Botones/dash.tscn",
				"res://Scenes/Poderes/Botones/vampirismo.tscn",
				"res://Scenes/Poderes/Botones/take_no_damage.tscn"]

#Nunca borrar el node pls
var powers = {
	"power_1": {
		"on": false,
		"node": "Control_1",
		"node_button":"",
		"type" : "",
		"rute": ""                 
	},
	"power_2": {
		"on": false,
		"node": "Control_2",
		"node_button":"",
		"type" : "",
		"rute": ""
	},
	"power_3": {
		"on": false,
		"node": "Control_3",
		"node_button":"",
		"type" : "",
		"rute": ""
	}
		}


func _ready():
	show_seleccion()
	$Seleccion.hide()
	#var power_to_add = load ( "res://Scenes/Poderes/dash.tscn" )
	#var power_to_add_instance = power_to_add.instance()
	
	pass
	
func get_popupseleccion():
	return popupseleccion
	

func _on_CloseButton_pressed():
	for i in range ($Seleccion/button.get_child_count()):		
		$Seleccion/button.get_child(i).queue_free()
	$Seleccion.hide()
	
func delete_power(power):
	#Tengo que buscar el poder para sacarlo
	for section in powers.keys():
		if(powers[section]["type"] == power):
			powers[section]["type"] = ""
			powers[section]["on"] = false
			powers[section]["node_button"] = ""
			
			match powers[section]["node"]:
				"Control_1":
					$Control_1.get_child(0).queue_free()
				"Control_2":
					$Control_2.get_child(0).queue_free()
				"Control_3":
					$Control_3.get_child(0).queue_free()
			return
	
	pass

func add_power(power):
	
	
	#Tiene que sacar un poder si ya tiene los 3 slots llenos
	if (powers["power_1"]["on"]== true and powers["power_2"]["on"] == true and powers["power_3"]["on"] == true):
		var c = 0
		for section in powers.keys():
			var pos = $Deseleccion/position.get_child(c)
			var power_to = load(powers[section]["node_button"])
			var power_instance = power_to.instance()
			power_instance.rect_global_position = pos.rect_global_position
			$Deseleccion/button.add_child(power_instance)
			c+=1
		$Deseleccion.popup()
	else:
	
		for section in powers.keys():
			for key in powers[section]:
				if( key == "on") and ( powers[section][key] == false): 
					powers[section]["type"] = power
					powers[section]["rute"] = "res://Scenes/Poderes/" + str(power) + ".tscn"
					powers[section]["node_button"] = "res://Scenes/Poderes/Botones/" + str(power) + ".tscn"
					powers[section]["on"] = true
					
					match powers[section]["node"]:
						"Control_1":
							var power_to_add = load ( powers[section]["rute"] )
							var power_to_add_instance = power_to_add.instance()
							#power_to_add_instance.rect_global_position  = control_1.rect_global_position  ( ESTA MIERDA NO ANDA WTF)
							control_1.add_child(power_to_add_instance)
							if( power == "vampirismo"):
								vampirismo = control_1.get_node("vampirismo")
								
								
							
						"Control_2":
							var power_to_add = load ( powers[section]["rute"] )
							var power_to_add_instance = power_to_add.instance()
							control_2.add_child(power_to_add_instance)
							if( power == "vampirismo"):
								vampirismo = control_2.get_node("vampirismo")
						"Control_3":
							var power_to_add = load ( powers[section]["rute"] )
							var power_to_add_instance = power_to_add.instance()
							control_3.add_child(power_to_add_instance)
							if( power == "vampirismo"):
								vampirismo = control_3.get_node("vampirismo")
					_on_CloseButton_pressed()
					return
	
				

func show_seleccion():
	
	randomize()
	var load_1 = ((randi()%buttons_powers.size()+1)-1)
	
	
	randomize()
	var load_2 = ((randi()%buttons_powers.size()+1)-1)
	while( load_1 == load_2 ) :
		randomize()
		load_2 = ((randi()%buttons_powers.size()+1)-1)
	
	
	
	
	var pw = []
	
	# TODO descomentar esto cuando haya 5 poderes
	#Sino tira error porque cuando ya hay 2 no puede haber otros 2
	"""
	var pw_added = []
	pw_added.append(powers["power_1"]["node_button"])
	pw_added.append(powers["power_2"]["node_button"])
	pw_added.append(powers["power_3"]["node_button"])
	
	while( -1 != pw_added.find(buttons_powers[load_1])):
		while( load_1 == load_2 ) :
			randomize()
			load_1 = ((randi()%buttons_powers.size()+1))
	while( -1 != pw_added.find(buttons_powers[load_2])):
		while( load_1 == load_2 ) :
			randomize()
			load_2 = ((randi()%buttons_powers.size()+1))"""
			
	pw.append(load_1)
	pw.append(load_2)	
	
	for position in range ($Seleccion/position.get_child_count()):
		var pos = $Seleccion/position.get_child(position)		
		var power = load(buttons_powers[pw[position]])
		var power_instance = power.instance()
		power_instance.rect_global_position = pos.rect_global_position
		$Seleccion/button.add_child(power_instance)
	$Seleccion.popup()


func _on_closebutton_deseleccion_pressed():
	$Deseleccion.hide()
