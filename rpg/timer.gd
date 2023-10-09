extends Node2D

@export var ticks_per_attack: int = 5 * 4 # Five seconds, timer is 1/4 second

var ticks_remaining: int = ticks_per_attack

signal timeout

# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.timeout.connect(_on_timer_timeout)


func _on_timer_timeout():
	ticks_remaining -= 1
	$Progress.value = 1.0 - float(ticks_remaining)/ticks_per_attack
	if ticks_remaining == 0:
		emit_signal("timeout")
		ticks_remaining = ticks_per_attack
		
		
func start_tick():
	$Timer.start()
	
	
func stop_tick():
	$Progress.value = 0.0
	ticks_remaining = ticks_per_attack
	$Timer.stop()
