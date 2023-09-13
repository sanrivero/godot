extends "res://Scripts/Monster.gd"


onready var areaDetector: Area2D = $ActorDetector

onready var sprite: Sprite = $Sprite

var player: Player


var GRAVEDAD = 20

const ARRIBA = Vector2(0, -1)

export (bool) var mover = true

var movimiento = Vector2()

var velocidad = 20



var ataque

func _ready():
	set_physics_process(false)
	areaDetector.connect("body_entered",self,"_on_ActorDetector_body_entered")
	

func _physics_process(delta):
	
	
	var direction : = (player.global_position - global_position).normalized()
	var distance_to_player : = global_position.distance_to(player.global_position)
	#sprite.flip_h = direction.x < 0
	
	if (direction.x < 0 ):
		sprite.scale.x = -1
	else:
		sprite.scale.x = 1
	
	
	if distance_to_player >= 30 :
		$AnimationPlayer.play("walk")
		
		
	
	if  distance_to_player <= 29:
		atacar()
		
	
		
	direction.y = 0
	direction = move_and_slide(direction*400*delta)
		

func atacar():
	
	if ($AnimationPlayer.current_animation != "take_damage"):
		$AnimationPlayer.play("attack")


func _on_ActorDetector_body_entered(body):
	if not body is Player: 
		
		return
	player = body
	set_physics_process(true)
	areaDetector.disconnect("body_entered",self,"_on_ActorDetector_body_entered")



func _on_DamageDetector_area_entered(area):
	var grupo = area.get_groups()
	if grupo.has("attack"):
		self.vida -= area.get_damage()
		barra_vida.establecer_vida(vida)
		
		if(self.vida <= 0):
			$AnimationPlayer.play("die")
		else: 
			$AnimationPlayer.play("take_damage")
			
		
		


func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "die"):
		queue_free()
