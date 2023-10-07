extends Control

var open = true
var recent_ad_size

var start_position = Vector2.ZERO
var end_position = Vector2.ZERO

signal spawn_ad_preview(ad_size, ad_position)

func toggle_menu(toggle, duration = 0.5):
	var tween = create_tween()
	if toggle:
		tween.tween_property($MenuPanel, "position:x", $MenuPanel.position.x - 250, duration)
	else:
		tween.tween_property($MenuPanel, "position:x", $MenuPanel.position.x + 250, duration)
	tween.play()
	open = toggle

func show_preview(ad_size):
	%ad_preview_box.set_ad_size(ad_size)
	$Preview.visible = true
	
func hide_preview():
	$Preview.visible = false
	
func _physics_process(delta):
	pass
	
func _on_button_preview_ad(ad_size):
	show_preview(ad_size)
	recent_ad_size = ad_size

func _on_button_mouse_exited():
	hide_preview()

func _on_button_pressed():
	spawn_ad_preview.emit(recent_ad_size, get_viewport().get_mouse_position())
	toggle_menu(false, .1)
	hide_preview()

func _on_menu_button_pressed():
	toggle_menu(!open)
