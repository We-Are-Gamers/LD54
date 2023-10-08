extends Control

signal level_up_button(type)

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/HBoxContainer/RockButton.pressed.connect(_on_rock_pressed)
	$VBoxContainer/HBoxContainer/PaperButton.pressed.connect(_on_paper_pressed)
	$VBoxContainer/HBoxContainer/ScissorsButton.pressed.connect(_on_scissors_pressed)
	$VBoxContainer/HBoxContainer/HealButton.pressed.connect(_on_heal_pressed)


func _on_rock_pressed():
	level_up_button.emit("rock")
	

func _on_paper_pressed():
	level_up_button.emit("paper")


func _on_scissors_pressed():
	level_up_button.emit("scissors")


func _on_heal_pressed():
	level_up_button.emit("heal")


func disable_buttons():
	
