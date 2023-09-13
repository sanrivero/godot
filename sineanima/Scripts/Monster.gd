extends KinematicBody2D

const effects = {'camera_shake': 'camera_shake',
			 'twinkle_light': 'twinkle_light'}


var dano
var vida
var vida_max
var barra_vida

onready var hud = get_tree().get_root().get_node("Game/Hud")



func init(dano,vida,vida_max):
	setDano(dano)
	setVida(vida)
	setVidaMax(vida_max)
	#$Area_Ataque.set_dano(getDano())
	barra_vida = get_node("Barra_Vida")
	barra_vida.init(vida_max, vida)
	
	
func vampirismo():
	if not(hud.vampirismo == null):
		hud.vampirismo.value += 50
	pass
	
func setDano (valor):
	dano = valor
	
func setVida (valor):
	vida = valor
	
func setVidaMax (valor):
	vida_max = valor

func getDano():
	return dano
	
func getVida():
	return vida
	
func getVidaMax():
	return vida_max
