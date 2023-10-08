class_name BattleButton extends TextureButton



var RockIcon = preload("res://resources/map_assets/coal.png")
var PaperIcon = preload("res://resources/map_assets/paper.png")
var ScissorsIcon = preload("res://resources/map_assets/scissors.png")
var disabled_material = preload("res://rpg/battle_button_disabled.tres")
var enabled_material = preload("res://rpg/battle_button_enabled.tres")
var hover_material = preload("res://rpg/battle_button_hover.tres")

enum BattleType {ROCK, PAPER, SCISSORS}

var rock_texture = build_image_texture(RockIcon)
var paper_texture = build_image_texture(PaperIcon)
var scissors_texture = build_image_texture(ScissorsIcon)
var my_material = enabled_material


@export var battle_type: BattleType
signal begin_battle(type: BattleType)

func _ready():
	if battle_type == BattleType.ROCK:
		texture_normal = rock_texture
	elif battle_type == BattleType.PAPER:
		texture_normal = paper_texture
	elif battle_type == BattleType.SCISSORS:
		texture_normal = scissors_texture

func do_disable():
	disabled = true
	material = disabled_material
	my_material = disabled_material
	
func do_enable():
	disabled = false
	material = enabled_material
	my_material = enabled_material

func build_image_texture(icon):
	var image = icon.get_image()
	image.shrink_x2()
	image.shrink_x2()
	var texture = ImageTexture.create_from_image(image)
	return texture


func _on_pressed():
	emit_signal("begin_battle", battle_type)

func _on_mouse_entered():
	if not disabled:
		material = hover_material

func _on_mouse_exited():
	material = my_material
