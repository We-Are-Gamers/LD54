extends RigidBody2D

@onready var bank = get_node("/root/Bank")

var dragged = false
var stiffness = 690
var mouseForce = Vector2(0,0)
var dragStart = Vector2(0,0)
var dragTo = Vector2(0,0)
var ad: AdDescription



# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


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
		if (overlaps(event.position)):
			get_viewport().set_input_as_handled()
	if (event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT):
		if (event.pressed && overlaps(event.position)):
			dragged = true
			dragStart = to_local(event.position)
			dragTo = event.position
			get_viewport().set_input_as_handled()
		else:
			dragged = false


func set_ad(ad: AdDescription):
	bank.deposit(ad.income_amount)
	$AdCollider.scale = ad.ad_size
	
