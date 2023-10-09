extends Control

signal button_action(type)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_rock_pressed():
	reset_buttons()
	$Rock.button_pressed = true
	emit_signal("button_action", ActionType.ROCK)
	

func _on_paper_pressed():
	reset_buttons()
	$Paper.button_pressed = true
	emit_signal("button_action", ActionType.PAPER)


func _on_scissors_pressed():
	reset_buttons()
	$Scissors.button_pressed = true
	emit_signal("button_action", ActionType.SCISSORS)


func _on_heal_pressed():
	reset_buttons()
	$Heal.button_pressed = true
	emit_signal("button_action", ActionType.HEAL)


func reset_buttons():
	$Rock.button_pressed = false
	$Paper.button_pressed = false
	$Scissors.button_pressed = false
	$Heal.button_pressed = false
