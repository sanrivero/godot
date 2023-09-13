extends AudioStreamPlayer

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	self.set_volume_db(Settings._settings["audio"].volume)
	if(Settings._settings["audio"].mute == false):
		self.stop()
	else:
		self.play()
