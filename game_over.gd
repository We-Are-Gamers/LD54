extends Control

@onready var bank: Banking = get_node("/root/Bank")

func _ready():
	$VBoxContainer/BoxContainer/WinContainer.visible = false
	$VBoxContainer/BoxContainer/LoseContainer.visible = false
	
	if bank.win:
		display_game_win()
	else:
		display_game_lose()
		
func display_game_win():
	$VBoxContainer/BoxContainer/WinContainer.visible = true
	
func display_game_lose():
	$VBoxContainer/BoxContainer/LoseContainer.visible = true
