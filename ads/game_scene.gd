extends Node2D

var AdWindow = preload("res://ads/ad_window.tscn")

@onready var bank: Banking = get_node("/root/Bank")

var dragging = false
var preview_drag_to = Vector2(0, 0)
var dragged_ad: AdDescription

func place_ad():
	%ad_preview_box.visible = false
	if %ad_preview_box.get_overlapped_bodies() > 0:
		$CanvasLayer/AdMenu.close_menu(true)
	else:
		var ad_window = AdWindow.instantiate()
		$CanvasLayer/AdWindowContainer.add_child(ad_window)
		ad_window.position = %ad_preview_box.position
		ad_window.set_ad(dragged_ad)

func _on_spawn_ad_preview(ad: AdDescription, ad_position):
	dragging = true
	dragged_ad = ad
	%ad_preview_box.set_ad(ad)
	%ad_preview_box.position = ad_position
	%ad_preview_box.visible = true


func _input(event):
	if !dragging:
		return
	if(event is InputEventMouseMotion):
		%ad_preview_box.position = event.position
		return
	if (event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT && !event.pressed):
		place_ad()
		dragging = false

func _on_game_over(win):
	bank.win = win
	get_tree().change_scene_to_file("res://game_over.tscn")
