extends Control

signal level_up_button(type)

# Called when the node enters the scene tree for the first time.
func _ready():
	$Control/VBoxContainer/ButtonContainer/RockContainer/RockButton.pressed.connect(_on_rock_pressed)
	$Control/VBoxContainer/ButtonContainer/PaperContainer/PaperButton.pressed.connect(_on_paper_pressed)
	$Control/VBoxContainer/ButtonContainer/ScissorsContainer/ScissorsButton.pressed.connect(_on_scissors_pressed)
	$Control/VBoxContainer/ButtonContainer/HealContainer/HealButton.pressed.connect(_on_heal_pressed)

func set_power_levels(power_levels):
	$Control/VBoxContainer/ButtonContainer/RockContainer/Label.text = "(Level {lv})".format({"lv": power_levels[ActionType.ROCK]})
	$Control/VBoxContainer/ButtonContainer/PaperContainer/Label.text = "(Level {lv})".format({"lv": power_levels[ActionType.PAPER]})
	$Control/VBoxContainer/ButtonContainer/ScissorsContainer/Label.text = "(Level {lv})".format({"lv": power_levels[ActionType.SCISSORS]})
	$Control/VBoxContainer/ButtonContainer/HealContainer/Label.text = "(Level {lv})".format({"lv": power_levels[ActionType.HEAL]})

func reenable():
	visible = true


func _on_rock_pressed():
	level_up_button.emit(ActionType.ROCK)
	unalive()
	

func _on_paper_pressed():
	level_up_button.emit(ActionType.PAPER)
	unalive()


func _on_scissors_pressed():
	level_up_button.emit(ActionType.SCISSORS)
	unalive()


func _on_heal_pressed():
	level_up_button.emit(ActionType.HEAL)
	unalive()

func unalive():
	visible = false
