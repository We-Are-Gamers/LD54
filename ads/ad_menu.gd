extends Control

@export var slow_menu_duration = 0.5
@export var fast_menu_duration = 0.1

var open = true
var recent_ad_size

var xpos = {}

signal spawn_ad_preview(ad_size, ad_position)

func _ready():
	xpos[true] = $MenuPanel.position.x
	xpos[false] = $MenuPanel.position.x + 250
	$MenuPanel.position.x = xpos[false]
	open = false
	pass
	
func open_menu(open_fast = false):
	if !open:
		toggle_menu(open_fast)
		
func close_menu(open_fast = false):
	if open:
		toggle_menu(open_fast)

func toggle_menu(open_fast = false):
	open = !open
	var tween = create_tween()
	var duration = fast_menu_duration if open_fast else slow_menu_duration
	tween.tween_property($MenuPanel, "position:x", xpos[open], duration)
	tween.play()

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
	close_menu(true)
	hide_preview()

func _on_menu_button_pressed():
	toggle_menu()
