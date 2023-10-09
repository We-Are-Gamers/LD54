extends Node2D

var rock_enemy = preload("res://rpg/Enemies/rock_enemy.tscn")
var paper_enemy = preload("res://rpg/Enemies/paper_enemy.tscn")
var scissors_enemy = preload("res://rpg/Enemies/scissors_enemy.tscn")
var enemies = [rock_enemy, paper_enemy, scissors_enemy]
var current_enemy: Enemy
@onready var player = get_node("Player") as Player
@onready var bank: Banking = get_node("/root/Bank")

signal game_over(win: bool)

# Called when the node enters the scene tree for the first time.
func _ready():
	%Map.visible = true
	$Timer.visible = false
	$Timer.stop_tick()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func spawn_enemy(enemy_type):
	current_enemy = enemies[enemy_type].instantiate()
	current_enemy.enemy_attack.connect(player._on_enemy_attack)
	$Timer.player_should_attack.connect(player._on_timer_timeout)
	$Timer.enemy_should_attack.connect(_maybe_enemy_attacks)
	$Timer.turn_over.connect(_maybe_game_over)
	player.player_attack.connect(current_enemy._on_player_attack)
	current_enemy.position = $EnemySpawnLocation.position
	current_enemy.level = %Map.current_level
	add_child(current_enemy)


func _on_map_begin_battle(battle_type):
	bank.start_income_tick()
	$Timer.start_tick()
	$Timer.visible = true
	%Map.visible = false
	$CanvasLayer/LevelUp.unalive()
	spawn_enemy(battle_type)


func _maybe_enemy_attacks():
	if current_enemy.current_health > 0:
		current_enemy._on_timer_timeout()


func _maybe_game_over():
	if $Player.current_health <= 0:
		emit_signal("game_over", false)
	if current_enemy.current_health <= 0:
		remove_child(current_enemy)
		current_enemy.queue_free()
		%Map.visible = true
		bank.stop_income_tick()
		%Map.increment_level()
		$Timer.visible = false
		$Timer.stop_tick()
		$CanvasLayer/LevelUp.set_power_levels(player.type_power)
		$CanvasLayer/LevelUp.reenable()


func _on_level_up_complete():
	%Map.unblock_buttons()
