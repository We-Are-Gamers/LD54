extends Node2D

var AdWindow = preload("res://ads/ad_window.tscn")

var dragging = false
var preview_drag_to = Vector2(0, 0)
var dragged_ad_size = Vector2(0, 0)

func place_ad():
	$ad_preview_box.visible = false
	if $ad_preview_box.get_overlapped_bodies() > 0:
		$CanvasLayer/AdMenu.toggle_menu(true, 0.1)
	else:
		var ad_window = AdWindow.instantiate()
		add_child(ad_window)
		ad_window.position = $ad_preview_box.position
		ad_window.set_ad_scale(dragged_ad_size)

func _on_spawn_ad_preview(ad_size, ad_position):
	dragging = true
	dragged_ad_size = ad_size
	$ad_preview_box.set_ad_size(ad_size)
	$ad_preview_box.position = ad_position
	$ad_preview_box.visible = true

func _process(delta):
	pass
	
func _input(event):
	if !dragging:
		return
	if(event is InputEventMouseMotion):
		$ad_preview_box.position = event.position
		return
	if (event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.pressed):
		place_ad()
		dragging = false
