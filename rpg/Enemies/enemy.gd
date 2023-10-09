extends Node2D

class_name Enemy

@export var max_health: int
@export var current_health: int
@export var attack_power: int = 1
@export var level: int = 0
@export var type: ActionType.ActionTypeEnum
@export var strongVsType: ActionType.ActionTypeEnum
@export var weakVsType: ActionType.ActionTypeEnum
@export var ticks_per_attack: int = 5 * 4 # Five seconds, timer is 1/4 second
@export var enemy_icon: Texture

signal update_health(current_health)
signal enemy_attack(damage, type: ActionType.ActionTypeEnum)

var ticks_remaining: int = ticks_per_attack

# Called when the node enters the scene tree for the first time.
func _ready():
	update_stats(level)
	current_health = max_health
	%EnemyIcon.texture = enemy_icon
	emit_signal("update_health", current_health)
	$VBoxContainer/Type.text = "%s (%d damage)" % [
		ActionType.ActionTypeEnum.keys()[type].to_upper(),
		_damage()
	]

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _damage() -> int:
	return attack_power + (level / 3)

func _on_timer_timeout():
	emit_signal("enemy_attack", _damage(), type)

func _on_player_attack(damage, type: ActionType.ActionTypeEnum):
	current_health -= damage * get_type_multiplier(type)
	$VBoxContainer/HealthBar.update_health(current_health)
	$SpecialEffects.do_action(type)
	emit_signal("update_health", current_health)

func get_type_multiplier(type: ActionType.ActionTypeEnum):
	if type == strongVsType:
		return .5
	elif type == weakVsType:
		return 2
	return 1

func update_stats(level):
	max_health *= level/2 + 1
	$VBoxContainer/HealthBar.update_max_health(max_health)
