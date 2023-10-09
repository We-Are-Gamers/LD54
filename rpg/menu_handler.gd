extends Control

signal button_action(type)

# Called when the node enters the scene tree for the first time.
func _ready():
	$ButtonContainer/RockContainer/RockButton.pressed.connect(_on_rock_pressed)
	$ButtonContainer/PaperContainer/PaperButton.pressed.connect(_on_paper_pressed)
	$ButtonContainer/ScissorsContainer/ScissorsButton.pressed.connect(_on_scissors_pressed)
	$ButtonContainer/HealContainer/HealButton.pressed.connect(_on_heal_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_rock_pressed():
	reset_buttons()
	$ButtonContainer/RockContainer/RockButton.button_pressed = true
	emit_signal("button_action", ActionType.ROCK)
	

func _on_paper_pressed():
	reset_buttons()
	$ButtonContainer/PaperContainer/PaperButton.button_pressed = true
	emit_signal("button_action", ActionType.PAPER)


func _on_scissors_pressed():
	reset_buttons()
	$ButtonContainer/ScissorsContainer/ScissorsButton.button_pressed = true
	emit_signal("button_action", ActionType.SCISSORS)


func _on_heal_pressed():
	reset_buttons()
	$ButtonContainer/HealContainer/HealButton.button_pressed = true
	emit_signal("button_action", ActionType.HEAL)


func reset_buttons():
	$ButtonContainer/RockContainer/RockButton.button_pressed = false
	$ButtonContainer/PaperContainer/PaperButton.button_pressed = false
	$ButtonContainer/ScissorsContainer/ScissorsButton.button_pressed = false
	$ButtonContainer/HealContainer/HealButton.button_pressed = false
