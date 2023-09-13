extends Node2D

#Valor de la vida

var valor_max
var valor_actual

export (int) var vida = 100

#func _ready():
#	vida.set_scale(Vector2(0.05,0.05))


func init(_valor_max, _valor_actual):
	self.valor_max = _valor_max * 1.0
	self.valor_actual = clamp(_valor_actual * 1.0,0 , valor_max)
	#actualizar vida
	actualizar()

func establecer_vida(valor):
	valor_actual = clamp(valor,0 , valor_max)
	actualizar()
	


func actualizar():
	$vida.set_text(str(valor_actual))
	if valor_actual > 75:
		$AnimatedSprite.play("corazon_1")
	elif valor_actual > 50 and valor_actual <= 75:
		$AnimatedSprite.play("corazon_2")
	elif valor_actual > 25 and valor_actual <= 50:
		$AnimatedSprite.play("corazon_3")
	else:
		$AnimatedSprite.play("corazon_4")
