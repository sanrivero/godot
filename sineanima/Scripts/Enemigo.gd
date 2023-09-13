extends KinematicBody2D



const ARRIBA = Vector2(0, -1)
#Variables de vida
export (int) var vida_max = 50
export (int) var vida = 50

#Variables de movimiento
export (Vector2) var direccion = Vector2(40,0)

#Elegir si voltear o no al enemigo
export (bool) var mirar_derecha = false




onready var barra_vida = get_node("Barra_Vida")



func _ready():
	barra_vida.init(vida_max, vida)
	$Sprite.flip_h = mirar_derecha
	

func _process(delta):
	$Sprite.play("Normal")
	

#Movimiento del enemigo
func _physics_process(delta):
	if direccion.x > 0:
		$Sprite.flip_h = true
	elif direccion.x < 0:
		$Sprite.flip_h = false
	move_and_slide(direccion,Vector2(0,0))

#Recibir Daño




func _on_Area_Enemigo_area_entered( area ):
	var grupo = area.get_groups()
	
	
	if grupo.has("ataque"):
		vida -= area.get_dano()
		barra_vida.establecer_vida(vida)
		
		if vida <= 0:
			queue_free()
	
		


func _on_Area_Enemigo_body_entered( body ):
	var grupo = body.get_groups()
	
	if grupo.has("estructura"):
		direccion.y *= -1
		direccion.x *= -1
		
		
