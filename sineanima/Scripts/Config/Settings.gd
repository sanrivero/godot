# Stores, saves and loads game Settings in an ini-style file
extends Node


const SAVE_PATH = "res://config.cfg"

var _config_file = ConfigFile.new()
var _settings = {
	"audio": {
		"mute": false,
		"volume": 0
	},
	"debug": {
		"vector_color": Color(1.0, 0.0, 1.0),
		"area_color": Color(1.0, 0.0, 0.2, 0.5)
	}
}


func _ready():
	load_settings()
	save_settings()
	


func enabler(check):
	_settings["audio"].mute = check 
	save_settings()
	
func set_volumen(volumen):
	_settings["audio"].volume = volumen
	save_settings()

func save_settings():
	for section in _settings.keys():
		for key in _settings[section]:
			#print(_settings[section][key])
			_config_file.set_value(section,key,_settings[section][key])
	
	
	
func load_settings():
	var error = _config_file.load(SAVE_PATH)
	if (error != OK):
		print(error)
		print("Error al cargar archivo, Error ")
		return []
	for section in _settings.keys():
		for key in _settings[section]:
			_settings[section][key] = _config_file.get_value(section,key,_settings[section][key])
	
func set_settingsIngame():
	pass
	
func get_setting(category, key):
	return _settings[category][key]


func set_setting(category, key, value):
	_settings[category][key] = value
