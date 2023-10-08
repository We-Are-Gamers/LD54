extends Node2D

class_name Player

@onready var bank = get_node("/root/Bank")
@export var max_health: int
@export var current_health: int
@export var heal_amount: int
@export var rock_power: int
@export var paper_power: int
@export var scissor_power: int
@export var power_growth: int = 1
@export var cost_multiplier: int = 100


var types = {"rock": "rock", "paper": "paper", "scissors": "scissors", "heal": "heal"}

var type_power = {}

var type_button = {}

signal update_health(current_health)
signal player_attack(damage, type)
signal game_over(win: bool)

# Called when the node enters the scene tree for the first time.
func _ready():
	current_health = max_health
	bank.balance_updated.connect(_on_balance_updated)
	$VBoxContainer/HealthBar.update_health(current_health)
	type_power = {types.rock: rock_power,
			types.paper: paper_power,
			types.scissors: scissor_power,
			types.heal: heal_amount}
	type_button[types.rock] = $ActionMenu/Rock
	type_button[types.paper] = $ActionMenu/Paper
	type_button[types.scissors] = $ActionMenu/Scissors
	type_button[types.heal] = $ActionMenu/Heal
	for type in types:
		update_button(type, type_power[type])


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_action_menu_button_action(type):
	if(type == types.heal):
		heal(type_power[type])
	else:
		attack(type_power[type], type)
		
		
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
	if current_health <= 0:
		emit_signal("game_over", false)
	$VBoxContainer/HealthBar.update_health(current_health)
	

func update_button(type: String, power):
	var real_cost = get_cost(power)
	type_button[type].text = "{0}\n${1}".format([type.to_upper(), real_cost])
		
func get_cost(power) -> int:
	return power * cost_multiplier

func _on_balance_updated(balance):
	for type in types:
		var btn = type_button[type] as Button
		btn.disabled = false
		if get_cost(type_power[type]) > balance:
			btn.disabled = true

func _on_level_up(type: String):
	type_power[type] = type_power[type] + power_growth
	update_button(type, type_power[type])
