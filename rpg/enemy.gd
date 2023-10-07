extends Node2D

@export var max_health: int
@export var current_health: int
@export var heal_amount: int
@export var rock_power: int
@export var paper_power: int
@export var scissor_power: int
@export var ticks_per_attack: int = 5 * 4 # Five seconds, timer is 1/4 second

signal update_health(current_health)
signal countdown(remaining, type)
signal enemy_attack(damage, type)

var ticks_remaining: int = ticks_per_attack

# Called when the node enters the scene tree for the first time.
func _ready():
	current_health = max_health
	emit_signal("update_health", current_health)
	_update_intent("rock")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _update_intent(attack_type):
	emit_signal("countdown", float(ticks_remaining)/ticks_per_attack, "rock")

func _on_timer_timeout():
	var attack = "rock"
	ticks_remaining -= 1
	_update_intent(attack)
	if ticks_remaining == 0:
		emit_signal("enemy_attack", 1, attack)
		ticks_remaining = ticks_per_attack

func _on_player_attack(damage, type):
	current_health -= damage
	emit_signal("update_health", current_health)
