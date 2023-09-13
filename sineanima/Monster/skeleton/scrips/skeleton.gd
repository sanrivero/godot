extends "res://Scripts/Monster.gd"

var GRAVEDAD = 20

const ARRIBA = Vector2(0, -1)

export (bool) var mover = true

var movimiento = Vector2()

var velocidad = 20

var atacando = false

var en_area = false

var ataque


func _physics_process(delta):
	movimiento.y += GRAVEDAD
	#if atacando == false and mover == true:
	
	
	
	if ($AnimationPlayer.current_animation != "attack") and ($AnimationPlayer.current_animation != "take_damage") and ($AnimationPlayer.current_animation != "die") and vida >= 0:
		if is_on_floor():
			movimiento.y = 0
			$AnimationPlayer.play("walk")
		if is_on_wall():
			$Sprite.scale.x *= -1
			
		
		
		if en_area == true:
			velocidad = 80
		else:
			velocidad = 20
		movimiento.x = velocidad * $Sprite.scale.x
		
	if ($AnimationPlayer.current_animation != "attack") and ($AnimationPlayer.current_animation != "take_damage") and ($AnimationPlayer.current_animation != "die") and vida >= 0:
		move_and_slide(movimiento,ARRIBA)
		
	
		

func atacar():
	atacando = true
	if ($AnimationPlayer.current_animation != "take_damage"):
		$AnimationPlayer.play("attack")
	atacando = false




func _on_AnimationPlayer_animation_finished(anim_name):
	if (anim_name == "die"):
		queue_free()








func _on_ActorDetector_area_entered(area):
	var posicion_enemigo = area.get_global_position()
	var grupo = area.get_groups()
	if grupo.has("Jugador"):
		en_area = true


func _on_ActorDetector_area_exited(area):
	var grupo = area.get_groups()
	if grupo.has("Jugador"):
		en_area = false







func _on_DamageDetector_area_entered(area):
	var grupo = area.get_groups()
	if grupo.has("attack"):
		if ($Sprite/DamageDetector.get_global_position().x < area.get_global_position().x )and( $Sprite.scale.x == -1):
			$Sprite.scale.x = 1
		if ($Sprite/DamageDetector.get_global_position().x > area.get_global_position().x )and( $Sprite.scale.x == 1):
			$Sprite.scale.x = -1
		vida -= area.get_damage()
		
		$AnimationPlayer.play("take_damage")
		
		barra_vida.establecer_vida(vida)
		if vida <= 0:
			$Sprite/AttackArea.disconnect("area_entered",self,"_on_AttackArea_area_entered")
			$AnimationPlayer.play("die")
			set_physics_process(false)
		#self.vampirismo()
		


func _on_AttackArea_area_entered(area):
	var grupo = area.get_groups()
	if grupo.has("Jugador"):
		atacar()
