class_name BattleButton extends TextureButton


var RockIcon = preload("res://resources/map_assets/coal.png")
var PaperIcon = preload("res://resources/map_assets/paper.png")
var ScissorsIcon = preload("res://resources/map_assets/scissors.png")
var RockIconSelected = preload("res://resources/map_assets/coal_selected.png")
var PaperIconSelected = preload("res://resources/map_assets/paper_selected.png")
var ScissorsIconSelected = preload("res://resources/map_assets/scissors_selected.png")
var disabled_material = preload("res://rpg/battle_button_disabled.tres")
var enabled_material = preload("res://rpg/battle_button_enabled.tres")
var hover_material = preload("res://rpg/battle_button_hover.tres")

enum BattleType {ROCK, PAPER, SCISSORS}

var rock_texture = build_image_texture(RockIcon)
var paper_texture = build_image_texture(PaperIcon)
var scissors_texture = build_image_texture(ScissorsIcon)
var scissors_texture_selected = build_image_texture(ScissorsIconSelected)
var rock_texture_selected = build_image_texture(RockIconSelected)
var paper_texture_selected = build_image_texture(PaperIconSelected)

var my_material = enabled_material
var selected = false

var blocked = false

@export var battle_type: BattleType
signal begin_battle(from: BattleButton)

func _ready():
	choose_texture()


func choose_texture():
	if battle_type == BattleType.ROCK:
		texture_normal = rock_texture if !selected else rock_texture_selected
	elif battle_type == BattleType.PAPER:
		texture_normal = paper_texture if !selected else paper_texture_selected
	elif battle_type == BattleType.SCISSORS:
		texture_normal = scissors_texture if !selected else scissors_texture_selected

func do_disable():
	disabled = true
	material = disabled_material
	my_material = disabled_material
	
func do_selected():
	selected = true
	material = my_material
	choose_texture();
	
func do_enable():
	disabled = false
	material = enabled_material
	my_material = enabled_material
	
func do_block():
	blocked = true

func do_unblock():
	blocked = false

func build_image_texture(icon):
	var image = icon.get_image()
	var texture = ImageTexture.create_from_image(image)
	return texture


func _on_pressed():
	if not blocked:
		emit_signal("begin_battle", self)

func _on_mouse_entered():
	if not disabled and not blocked:
		material = hover_material

func _on_mouse_exited():
	if not blocked:
		material = my_material
