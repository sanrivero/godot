extends Control

func _ready():
	Save.load_game()
	
func _on_TextureButton_pressed():
	
	get_tree().change_scene("res://Scenes/base.tscn")
	
func _on_SettingsButton_pressed():
	
	$SettingsPopUpMenu.show()
