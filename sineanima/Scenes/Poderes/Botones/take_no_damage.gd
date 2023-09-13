extends TextureButton



func _on_take_no_damage_pressed():
	
	get_parent().get_parent().get_parent().add_power("take_no_damage")
	
	
	
