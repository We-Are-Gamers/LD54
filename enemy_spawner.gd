extends Node2D

var rock_enemy = preload("res://rpg/Enemies/rock_enemy.tscn")
var paper_enemy = preload("res://rpg/Enemies/paper_enemy.tscn")
var scissors_enemy = preload("res://rpg/Enemies/scissors_enemy.tscn")
var enemies = [rock_enemy, paper_enemy, scissors_enemy]

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func rand_enemy():
	var enemy = enemies[randi() % 3].instantiate()
	
	add_child(enemy)
	
