extends Control

var PackedBattleButton = preload("res://rpg/battle_button.tscn")

@export var max_level: int = 10
@export var max_room_width: int = 3

@onready var bank = get_node("/root/Bank")

var current_level: int = 0
var map = []
var path_taken = []

signal begin_battle(battle_type: BattleButton.BattleType)
signal game_over(win: bool)


func _get_valid_next_paths(level):
	if(level == 0):
		return map[0].map(func(node): return node.button)
	var last_button = path_taken[-1]
	var last_node = map[level - 1]\
			.filter(func(node): return node.button == last_button)[0]
	return last_node.connections
	
	

func _update_active_buttons():
	var allowed_paths  = _get_valid_next_paths(current_level)
	for level in range(max_level):
		for node in map[level]:
			var battle_button = node.button
			if allowed_paths.any(func(c): return c == battle_button):
				battle_button.do_enable()
			else:
				battle_button.do_disable()


func _ready():
	for i in range(max_level):
		map.push_back([])
	for i in range(max_level, 0, -1):
		var h_box = HBoxContainer.new()
		%VBoxContainer.add_child(h_box)
		for j in range(randi() % max_room_width + 1):
			var battle_button = PackedBattleButton.instantiate()
			battle_button.battle_type = randi() % 3
			battle_button.begin_battle.connect(_on_button_pressed)
			map[i-1].push_back({"button": battle_button, "connections": []})
			h_box.add_child(battle_button)
			if j < 2:
				var separation = randi() % 150 + 25
				var space_node = Control.new()
				space_node.custom_minimum_size = Vector2(separation, 0)
				h_box.add_child(space_node)
		
		h_box.alignment = BoxContainer.ALIGNMENT_CENTER
	create_paths(map)
	_update_active_buttons()
	$ScrollContainer.set_deferred("scroll_vertical", 10000000)
	%VBoxContainer.call_deferred("queue_redraw")


func _random_element(array: Array, pop = true):
	var choice = randi() % array.size()
	return array.pop_at(choice) if pop else array[choice]


func connect_node(from_node, to_node):
	from_node.connections.push_back(to_node.button)


func create_node_paths(node, previous_connected, unconnencted: Array, last):
	var connected = null
	if previous_connected == null:
		connected = unconnencted.pop_front()
		connect_node(node, connected)
	elif unconnencted.is_empty() || randi()%100 > 50:
		connected = previous_connected
		connect_node(node, connected)

	if connected == null:
		connected = unconnencted.pop_front()
		connect_node(node, connected)

	if unconnencted.is_empty():
		return connected

	var chance_of_connecting = 100;
	var chance_decrease = 1 if last else .5


	for i in range(unconnencted.size()):
		chance_of_connecting *= chance_decrease

		var roll = randi() % 100

		if roll > chance_of_connecting:
			return connected

		connected = unconnencted.pop_front()
		connect_node(node, connected)

	return connected


func create_row_paths(current_row, next_row):
	var unconnected = next_row.duplicate()
	var last_connected = null
	for node_index in range(current_row.size()):
		var node = current_row[node_index]
		last_connected = create_node_paths(node, last_connected, unconnected, node_index + 1 == current_row.size())



func create_paths(map):
	for i in range(max_level - 1):
		create_row_paths(map[i], map[i+1])
	%VBoxContainer.paths = map


func increment_level():
	current_level += 1
	if current_level == max_level:
		emit_signal("game_over", true)
	bank.level_up(current_level)
	_update_active_buttons()


func _on_button_pressed(from_button: BattleButton):
	path_taken.push_back(from_button)
	from_button.do_selected()
	%VBoxContainer.path_taken = path_taken
	%VBoxContainer.call_deferred("queue_redraw")
	emit_signal("begin_battle", from_button.battle_type)
