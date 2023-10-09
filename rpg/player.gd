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
@export var selected_type: ActionType.ActionTypeEnum = ActionType.NONE

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
	type_power = {ActionType.ROCK: rock_power,
			ActionType.PAPER: paper_power,
			ActionType.SCISSORS: scissor_power,
			ActionType.HEAL: heal_amount}
	type_button[ActionType.ROCK] = $ActionMenu/Rock
	type_button[ActionType.PAPER] = $ActionMenu/Paper
	type_button[ActionType.SCISSORS] = $ActionMenu/Scissors
	type_button[ActionType.HEAL] = $ActionMenu/Heal
	for type in ActionType.All():
		update_button(type, type_power[type])


func _lookup_sound_effect(type: ActionType.ActionTypeEnum) -> AudioStreamPlayer:
	if type == ActionType.ROCK:
		return $Audio/RockSound
	elif type == ActionType.PAPER:
		return $Audio/PaperSound
	elif type == ActionType.SCISSORS:
		return $Audio/ScissorsSound
	return null

func _play_sound_effect(type: ActionType.ActionTypeEnum):
	var effect = _lookup_sound_effect(type)
	effect.play()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_action_menu_button_action(type: ActionType.ActionTypeEnum):
	selected_type = type
		

func _on_timer_timeout():
	if (selected_type == null or selected_type == ActionType.NONE):
		return
	elif(selected_type == ActionType.HEAL):
		heal(type_power[selected_type])
	else:
		attack(type_power[selected_type], selected_type)
		
	$ActionMenu.reset_buttons()
	selected_type = ActionType.NONE
	
		
func attack(damage, type: ActionType.ActionTypeEnum):
	if !bank.withdraw(get_cost(type_power[type])):
		return
		
	_play_sound_effect(type)
	emit_signal("player_attack", damage, type)
	
	
func heal(healing):
	if current_health >= max_health:
		return
	if !bank.withdraw(healing * 100):
		return
		
	current_health += healing
	if current_health >= max_health:
		current_health = max_health
	$VBoxContainer/HealthBar.update_health(current_health)


func _on_enemy_attack(damage, type: ActionType.ActionTypeEnum):
	current_health -= damage
	if current_health <= 0:
		current_health = 0
		emit_signal("game_over", false)
	$VBoxContainer/HealthBar.update_health(current_health)
	

func update_button(type: ActionType.ActionTypeEnum, power):
	var real_cost = get_cost(power)
	var type_name = ActionType.ActionTypeEnum.keys()[type].to_upper()
	type_button[type].text = "{0}\nLevel {1}\n${2}".format([type_name, power, real_cost])
		
func get_cost(power) -> int:
	return (power * cost_multiplier) / 2

func _on_balance_updated(balance):
	for type in ActionType.All():
		var btn = type_button[type] as Button
		btn.disabled = false
		if get_cost(type_power[type]) > balance:
			btn.disabled = true

func _on_level_up(type: ActionType.ActionTypeEnum):
	type_power[type] = type_power[type] + power_growth
	update_button(type, type_power[type])
	
	type_power[ActionType.ActionTypeEnum.HEAL] = type_power[ActionType.ActionTypeEnum.HEAL] + power_growth
	update_button(ActionType.ActionTypeEnum.HEAL, type_power[ActionType.ActionTypeEnum.HEAL])
	
