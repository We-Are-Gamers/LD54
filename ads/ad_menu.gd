extends Control

var recent_ad_size

signal spawn_ad_preview(ad_size, ad_position)

func show_preview(ad_size):
	%ad_preview_box.set_ad_size(ad_size)
	$Preview.visible = true
	
func hide_preview():
	$Preview.visible = false
	
func _on_button_preview_ad(ad_size):
	show_preview(ad_size)
	recent_ad_size = ad_size

func _on_button_mouse_exited():
	hide_preview()

func _on_button_pressed():
	spawn_ad_preview.emit(recent_ad_size, get_viewport().get_mouse_position())
