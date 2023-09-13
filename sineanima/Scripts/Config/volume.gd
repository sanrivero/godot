extends Popup

onready var audioBackground = preload("res://Scripts/Config/AudioStreamPlayer.gd")

func _ready():
	$HSlider.value = Settings._settings["audio"].volume
	$CheckButton.pressed = Settings._settings["audio"].mute

func _on_HSlider_value_changed(value):
	Settings.set_volumen(value)
	


func _on_CheckButton_toggled(button_pressed):	
	Settings.enabler(button_pressed)
	


func _on_CloseButton_pressed():
	self.hide()
	pass

