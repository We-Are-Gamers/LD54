extends Node2D

signal button_action(type)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_rock_pressed():
	emit_signal("button_action", "rock")


func _on_paper_pressed():
	emit_signal("button_action", "paper")


func _on_scissors_pressed():
	emit_signal("button_action", "scissors")


func _on_heal_pressed():
	emit_signal("button_action", "heal")
