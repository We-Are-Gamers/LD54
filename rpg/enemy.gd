extends Node2D

@export var max_health: int
@export var current_health: int
@export var heal_amount: int
@export var rock_power: int
@export var paper_power: int
@export var scissor_power: int

signal update_health(current_health)
signal enemy_attack(damage, type)

# Called when the node enters the scene tree for the first time.
func _ready():
	current_health = max_health
	emit_signal("update_health", current_health)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	emit_signal("enemy_attack", 1, "rock")


func _on_player_attack(damage, type):
	current_health -= damage
	emit_signal("update_health", current_health)
