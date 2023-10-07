extends RigidBody2D

var dragged = false
var stiffness = 690
var mouseForce = Vector2(0,0)
var dragStart = Vector2(0,0)
var dragTo = Vector2(0,0)


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

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _input(event):
	if(event is InputEventMouseMotion):
		dragTo = event.position
		return
	if (event is InputEventMouseButton && event.button_index == MOUSE_BUTTON_LEFT):
		dragged = false


func _on_input_event(viewport, event, shape_idx):
	if dragged || !(event is InputEventMouseButton) || event.button_index != MOUSE_BUTTON_LEFT:
		return
	if event.pressed:
		dragStart = to_local(event.position)
		dragged = true

func set_ad_scale(ad_size):
	$AdCollider.scale = ad_size
