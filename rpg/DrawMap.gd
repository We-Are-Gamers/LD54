extends VBoxContainer


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _draw():
	draw_line(Vector2(400,400), Vector2(100,100), Color.BLUE_VIOLET, 5.0)
