extends Node2D
class_name Zone

#Esta es una zona copiada de Mundo, es decir,tiene como heredada zone grass de Mundo

var type
var size


func get_camera_anchors() -> Array:
	var anchors = []
	for anchor in get_node('CameraAnchors').get_children():
		anchors.push_back(anchor.global_position)
	return anchors

func get_closest_camera_anchor(player: Player) -> Vector2:
	var player_pos := player.global_position

	var min_dist := INF
	var min_dist_anchor := Vector2()

	for anchor in self.get_camera_anchors():
		var dist := player_pos.distance_to(anchor)
		if dist < min_dist:
			min_dist = dist
			min_dist_anchor = anchor

	return min_dist_anchor
	

# TODO: don't rely on inherited node strucutres for getting Area2D.
func get_room_dimensions() -> Vector2:
	#var half_extents = get_node('RoomBoundaries').get_node('CollisionShape2D').shape.extents
	
	return size


func pause() -> void:
	pass
	
func resume() -> void:
	pass
