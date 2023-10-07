extends Control

@export var max_level: int = 10
@onready var current_level: int = 0

func _ready():
	for i in range(max_level):
		var battle_button = Button.new()
		battle_button.text = "battle {level}".format({"level": i})
		battle_button.pressed.connect(_on_button_pressed)
		%VBoxContainer.add_child(battle_button)

func open_map():
	current_level += 1

func _on_button_pressed():
	visible = false
