extends Control

var PackedBattleButton = preload("res://rpg/battle_button.tscn")

@export var max_level: int = 3

var current_level: int = 0

signal begin_battle(battle_type: BattleButton.BattleType)


func _update_active_buttons():
	for row_num in range(max_level):
		var rooms = %VBoxContainer.get_children()[row_num].get_children().filter(func(e): return e.is_class("TextureButton"))
		for room in range(rooms.size()):
			var battle_button = rooms[room]
			# The top row is row_num 0, but should be level_num n-1
			var row_level = max_level - row_num -1
			if row_level < current_level:
				battle_button.disabled = true
				# fade the icon or something
			elif row_level > current_level:
				battle_button.disabled = true
			elif row_level == current_level:
				battle_button.disabled = false


func _ready():
	for i in range(max_level, 0, -1):
		var h_box = HBoxContainer.new()
		%VBoxContainer.add_child(h_box)
		
		for j in range(3):
			var battle_button = PackedBattleButton.instantiate()
			battle_button.battle_type = randi() % 3
			battle_button.begin_battle.connect(_on_button_pressed)
			h_box.add_child(battle_button)
			if j < 2:
				var separation = randi() % 150 + 25
				var space_node = Control.new()
				space_node.custom_minimum_size = Vector2(separation, 0)
				h_box.add_child(space_node)
		
		h_box.alignment = BoxContainer.ALIGNMENT_CENTER
	_update_active_buttons()
	$ScrollContainer.set_deferred("scroll_vertical", %VBoxContainer.size.y)

func increment_level():
	current_level += 1
	_update_active_buttons()

func _on_button_pressed(battle_type: BattleButton.BattleType):
	emit_signal("begin_battle", battle_type)
