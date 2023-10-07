extends Node2D

var dragging = false
var preview_drag_to = Vector2(0, 0)

func place_ad():
	$ad_preview_box.visible = false
	if $ad_preview_box.get_overlapped_bodies() > 0:
		print("you absolute fool")
	else:
		print("you win this round")
	$CanvasLayer/AdMenu.visible = true

func _on_spawn_ad_preview(ad_size, ad_position):
	dragging = true
	$ad_preview_box.set_ad_size(ad_size)
	$ad_preview_box.position = ad_position
	$ad_preview_box.visible = true
	$CanvasLayer/AdMenu.visible = false

func _process(delta):
	pass
	
func _input(event):
	if(dragging && event is InputEventMouseMotion):
		$ad_preview_box.position = event.position
		return
	if (event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.pressed):
		place_ad()
		dragging = false
