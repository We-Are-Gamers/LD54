extends Node2D

@export var max_health: int
@export var current_health: int
@export var heal_amount: int
@export var rock_power: int
@export var paper_power: int
@export var scissor_power: int

# Called when the node enters the scene tree for the first time.
func _ready():
	current_health = max_health


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_action_menu_button_action(type):
	if(type == "rock"):
		attack(rock_power)
	elif(type == "paper"):
		attack(paper_power)
	elif(type == "scissors"):
		attack(scissor_power)
	elif(type == "heal"):
		heal(heal_amount)
		
	print(current_health)
		
		
func attack(damage):
	current_health -= damage
	
	
func heal(healing):
	current_health += healing
