extends Control

signal button_action(type)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_rock_pressed():
	emit_signal("button_action", ActionType.ROCK)
	

func _on_paper_pressed():
	emit_signal("button_action", ActionType.PAPER)


func _on_scissors_pressed():
	emit_signal("button_action", ActionType.SCISSORS)


func _on_heal_pressed():
	emit_signal("button_action", ActionType.HEAL)
