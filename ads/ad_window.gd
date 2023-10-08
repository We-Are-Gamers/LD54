class_name AdWindow extends RigidBody2D

@onready var bank: Banking = get_node("/root/Bank")

var dragged = false
var stiffness = 690
var mouseForce = Vector2(0,0)
var dragStart = Vector2(0,0)
var dragTo = Vector2(0,0)
var current_ad: AdDescription


func _physics_process(delta):
	if dragged:
		drag_window()
		apply_force(mouseForce, dragStart)


func drag_window():
	var distance = dragTo - to_global(dragStart)
	mouseForce = distance.normalized() * stiffness * distance.length()


func overlaps(point):
	var rect =  $AdCollider.shape.get_rect()
	var r = Rect2(rect.position * $AdCollider.scale, rect.size * $AdCollider.scale)
	return r.has_point(to_local(point))


func _input(event):
	if event is InputEventMouseMotion:
		dragTo = event.position
	if (event is InputEventMouseButton 
			&& event.button_index == MOUSE_BUTTON_LEFT
			&& !event.pressed):
		dragged = false


func set_ad(ad: AdDescription):
	current_ad = ad
	if !ad.income_per_tick:
		bank.deposit(ad.income_amount)
	else:
		bank.add_income_per_tick(ad.income_amount)
	$AdCollider.set_ad(ad)
	$AdCollider/TextureButton.texture_normal = ad.ad_texture


func _on_texture_button_button_down():
	var pos = get_viewport().get_mouse_position()
	dragStart = to_local(get_viewport().get_mouse_position())
	dragged = true
	dragTo = pos
