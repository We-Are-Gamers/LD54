extends Control

signal level_up_button(type)

# Called when the node enters the scene tree for the first time.
func _ready():
	$VBoxContainer/HBoxContainer/RockButton.pressed.connect(_on_rock_pressed)
	$VBoxContainer/HBoxContainer/PaperButton.pressed.connect(_on_paper_pressed)
	$VBoxContainer/HBoxContainer/ScissorsButton.pressed.connect(_on_scissors_pressed)
	$VBoxContainer/HBoxContainer/HealButton.pressed.connect(_on_heal_pressed)


func reenable():
	visible = true


func _on_rock_pressed():
	level_up_button.emit("rock")
	unalive()
	

func _on_paper_pressed():
	level_up_button.emit("paper")
	unalive()


func _on_scissors_pressed():
	level_up_button.emit("scissors")
	unalive()


func _on_heal_pressed():
	level_up_button.emit("heal")
	unalive()

func unalive():
	visible = false
