extends Node

#Valor de la vida

var valor_max 
var valor_actual

onready var vida = get_node("Vida")

#func _ready():
#	vida.set_scale(Vector2(0.05,0.05))


func init(valor_max, valor_actual):
	self.valor_max = valor_max * 1.0
	self.valor_actual = clamp(valor_actual * 1.0,0 , valor_max)
	#actualizar vida
	actualizar()

func establecer_vida(valor):
	valor_actual = clamp(valor,0 , valor_max)
	actualizar()


func actualizar():
	var porcentaje = valor_actual / valor_max
	#actualizar el tamaño de la barra de vida
	$Vida.set_scale(Vector2(porcentaje,1))
