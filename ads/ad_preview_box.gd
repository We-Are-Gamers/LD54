extends Node2D

@export
var check_collisions = false

var overlapped_bodies = 0

func _ready():
	pass

func get_overlapped_bodies():
	return overlapped_bodies

func set_ad_size(ad_size):
	$Area2D/Sprite2D.scale = ad_size
	
func _process(delta):
	pass

func _on_body_entered(body):
	if check_collisions:
		overlapped_bodies += 1
		$Area2D/Sprite2D.modulate = Color(1, .5, .5)
	
func _on_body_exited(body):
	if check_collisions:
		overlapped_bodies -= 1
		if overlapped_bodies == 0:
			$Area2D/Sprite2D.modulate = Color(.5, 1, .5)
