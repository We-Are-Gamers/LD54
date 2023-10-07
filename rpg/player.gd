extends Node2D

class_name Player

@onready var bank = get_node("/root/Bank")
@export var max_health: int
@export var current_health: int
@export var heal_amount: int
@export var rock_power: int
@export var paper_power: int
@export var scissor_power: int

signal update_health(current_health)
signal player_attack(damage, type)

# Called when the node enters the scene tree for the first time.
func _ready():
	current_health = max_health
	$VBoxContainer/HealthBar.update_health(current_health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_action_menu_button_action(type):
	if(type == "rock"):
		attack(rock_power, type)
	elif(type == "paper"):
		attack(paper_power, type)
	elif(type == "scissors"):
		attack(scissor_power, type)
	elif(type == "heal"):
		heal(heal_amount)
		
		
func attack(damage, type):
	if !bank.withdraw(damage * 100):
		return
		
	emit_signal("player_attack", damage, type)
	
	
func heal(healing):
	if !bank.withdraw(healing * 100):
		return
		
	current_health += healing
	$VBoxContainer/HealthBar.update_health(current_health)


func _on_enemy_attack(damage, type):
	current_health -= damage
	$VBoxContainer/HealthBar.update_health(current_health)
