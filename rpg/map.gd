extends Control

var BattleButton = preload("res://rpg/battle_button.tscn")
var RockIcon = preload("res://resources/map_assets/coal.png")
var PaperIcon = preload("res://resources/map_assets/paper.png")
var ScissorsIcon = preload("res://resources/map_assets/scissors.png")

@export var max_level: int = 10

var current_level: int = 0

var rock_texture = build_image_texture(RockIcon)
var paper_texture = build_image_texture(PaperIcon)
var scissors_texture = build_image_texture(ScissorsIcon)

func _ready():
	for i in range(max_level, 0, -1):
		var h_box = HBoxContainer.new()
		%VBoxContainer.add_child(h_box)
		
		for j in range(3):
			var battle_button = BattleButton.instantiate()
			battle_button.texture_normal = paper_texture
			battle_button.pressed.connect(_on_button_pressed)
			if i < current_level + 1:
				battle_button.disabled = true
				# fade the icon or something
			elif i > current_level + 1:
				battle_button.disabled = true
			h_box.add_child(battle_button)
			
			if j < 2:
				var separation = randi() % 150 + 25
				var space_node = Control.new()
				space_node.custom_minimum_size = Vector2(separation, 0)
				h_box.add_child(space_node)
		
		h_box.alignment = BoxContainer.ALIGNMENT_CENTER
	
	$ScrollContainer.set_deferred("scroll_vertical", %VBoxContainer.size.y)

func open_map():
	current_level += 1

func _on_button_pressed():
	visible = false
	
func build_image_texture(icon):
	var image = icon.get_image()
	image.shrink_x2()
	image.shrink_x2()
	var texture = ImageTexture.create_from_image(image)
	return texture
