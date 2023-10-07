extends Node2D

var rock_enemy = preload("res://rpg/Enemies/rock_enemy.tscn")
var paper_enemy = preload("res://rpg/Enemies/paper_enemy.tscn")
var scissors_enemy = preload("res://rpg/Enemies/scissors_enemy.tscn")
var enemies = [rock_enemy, paper_enemy, scissors_enemy]
var current_enemy: Enemy
@onready var player = get_node("Player") as Player

# Called when the node enters the scene tree for the first time.
func _ready():
	rand_enemy()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func rand_enemy():
	current_enemy = enemies[randi() % 3].instantiate()
	current_enemy.enemy_attack.connect(player._on_enemy_attack)
	current_enemy.update_health.connect(_on_enemy_health_update)
	player.player_attack.connect(current_enemy._on_player_attack)
	current_enemy.position = $EnemySpawnLocation.position
	add_child(current_enemy)
	

func _on_enemy_health_update(health):
	if health <= 0:
		remove_child(current_enemy)
		current_enemy.queue_free()
		rand_enemy()
