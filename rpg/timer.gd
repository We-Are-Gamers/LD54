extends Node2D

@export var ticks_per_attack: int = 3 * 4 # Three seconds, timer is 1/4 second
@export var attack_animation_ticks: int = 3

var ticks_remaining: int = ticks_per_attack


signal player_should_attack
signal enemy_should_attack
signal turn_over

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout():
	ticks_remaining -= 1
	if ticks_remaining >= 0:
		$Progress.value = 1.0 - float(ticks_remaining)/ticks_per_attack
	if ticks_remaining == 0:
		emit_signal("player_should_attack")
	elif ticks_remaining == -attack_animation_ticks:
		emit_signal("enemy_should_attack")
	elif ticks_remaining == -(2*attack_animation_ticks):
		emit_signal("turn_over")
		ticks_remaining = ticks_per_attack
		
		
func start_tick():
	$Timer.start()
	
	
func stop_tick():
	$Progress.value = 0.0
	ticks_remaining = ticks_per_attack
	$Timer.stop()
