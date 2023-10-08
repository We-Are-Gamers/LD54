extends Node2D

class_name Enemy

@export var max_health: int
@export var current_health: int
@export var attack_power: int = 1
@export var level: int = 0
@export var type: String
@export var strongVsType: String
@export var weakVsType: String
@export var ticks_per_attack: int = 5 * 4 # Five seconds, timer is 1/4 second
@export var enemy_icon: Texture

signal update_health(current_health)
signal countdown(remaining, type)
signal enemy_attack(damage, type)

var ticks_remaining: int = ticks_per_attack

# Called when the node enters the scene tree for the first time.
func _ready():
	update_stats(level)
	current_health = max_health
	%EnemyIcon.texture = enemy_icon
	emit_signal("update_health", current_health)
	_update_intent(type)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _update_intent(attack_type):
	emit_signal("countdown", float(ticks_remaining)/ticks_per_attack, attack_type)

func _on_timer_timeout():
	ticks_remaining -= 1
	_update_intent(type)
	if ticks_remaining == 0:
		emit_signal("enemy_attack", attack_power, type)
		ticks_remaining = ticks_per_attack

func _on_player_attack(damage, type):
	current_health -= damage * get_type_multiplier(type)
	emit_signal("update_health", current_health)

func get_type_multiplier(type):
	if type == strongVsType:
		return .5
	elif type == weakVsType:
		return 2
	return 1

func update_stats(level):
	var actual_level = level + 1
	attack_power = attack_power * actual_level
	max_health *= actual_level
	$VBoxContainer/HealthBar.update_max_health(max_health)
