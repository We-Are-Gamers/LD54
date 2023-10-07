extends Control

func show_preview(ad_size):
	%ad_preview_box.set_ad_size(ad_size)
	$Preview.visible = true
	
func hide_preview():
	$Preview.visible = false
	
func _on_button_preview_ad(ad_size):
	show_preview(ad_size)

func _on_button_mouse_exited():
	hide_preview()
