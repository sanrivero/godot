# Stores, saves and loads game Settings in an ini-style file
extends Node

const SAVE_PATH = "user://save.json"

const coleccion_full = ["godot","hongo"]
var saved_coleccion = [] 
var saved_skill_tree = {}

func _ready():
	load_game()
	pass


func save_game():
	# Open the existing save file or create a new one in write mode
	var save_file = File.new()
	save_file.open(SAVE_PATH, File.WRITE)


	# All the nodes to save are in a group called "persistent" (set in the editor, in the node tab of the inspector)
	var save_dict = {}
	var nodes_to_save = get_tree().get_nodes_in_group("persistent")
	# Call the "save" method on every node (get_state)
	# It is called that way because the method doesn't save the node itself: it only returns a dictionary with
	# the values that we want to save
	for node in nodes_to_save:
		# The key to access each data dictionary is the node's path, so we can retrieve the node in load_game below
		# For this to work, the node path must not change! You can move the nodes up/down the hierarchy,
		# But if you give them a new parent, you'll have to update the save
		# E.g. if /root/Game/Player becomes /root/Game/Characters/YSort/Player
		
		save_dict[node.get_path()] = node.get_state()
	
	print("La información se guardo en: " + OS.get_user_data_dir())
	# {}.to_json() converts the entire dictionary to a JSON string. We store it in the save_file
	save_file.store_line(to_json(save_dict))
	# The change is automatically saved, so we close the file
	save_file.close()

# In a large game with many persistent changes, you'll want to optimize the save function
# This approach works well for many types of games, but not e.g. in an open world RPG
# For an RPG, you might have to update small portions of the save dictionary as the game progresses
# E.g. if you let the player quick save, or if you want an autosave feature



func load_game():
	# When we load a file, we must check that it exists before we try to open it or it'll crash the game
	var save_file = File.new()
	if not save_file.file_exists(SAVE_PATH):
		print("The save file does not exist.")
		return
	save_file.open(SAVE_PATH, File.READ)

	# parse file data - convert the JSON back to a dictionary
	var data = {}
	"""while not save_file.eof_reached():
		#http://docs.godotengine.org/en/3.0/tutorials/misc/saving_games.html
		var current_line = parse_json(save_file.get_line())
		print(current_line)"""
		
	
	data = parse_json(save_file.get_as_text())
	if (data != null) :
	# The dict keys on the first level are paths to the nodes
		for node_path in data.keys():
			# We get the node's path from the for loop, so we can use it to retrieve
			# Both the node to load (e.g. Player, Player2) and the node's data with data[node_path]
			var node_data = data[node_path]
			for attribute in node_data:
				if (attribute == "coleccionable"):
					saved_coleccion = node_data[attribute]
				elif(attribute =="skill_tree"):
					saved_skill_tree = node_data[attribute]
			# We find the right node to load node_data into and call its load method
		
	
func get_coleccionables():  #para mostrar en Base
	return saved_coleccion 

func get_coleccionables_restantes():   #para generar en los mapas
	var n = []
	for i in range (coleccion_full.size()):
		if not(saved_coleccion.has(coleccion_full[i])):
			n.append(coleccion_full[i])
	return n
