extends TextureButton

class_name BattleButton

var RockIcon = preload("res://resources/map_assets/coal.png")
var PaperIcon = preload("res://resources/map_assets/paper.png")
var ScissorsIcon = preload("res://resources/map_assets/scissors.png")
enum BattleType {ROCK, PAPER, SCISSORS}

var rock_texture = build_image_texture(RockIcon)
var paper_texture = build_image_texture(PaperIcon)
var scissors_texture = build_image_texture(ScissorsIcon)


@export var battle_type: BattleType
signal begin_battle(type: BattleType)

func _ready():
	if battle_type == BattleType.ROCK:
		texture_normal = rock_texture
	elif battle_type == BattleType.PAPER:
		texture_normal = paper_texture
	elif battle_type == BattleType.SCISSORS:
		texture_normal = scissors_texture
	
func _process(delta):
	if disabled:
		modulate = Color(0.1, 0.1, 0.1)
	else:
		modulate = Color(1.0, 1.0, 1.0)
	

func build_image_texture(icon):
	var image = icon.get_image()
	image.shrink_x2()
	image.shrink_x2()
	var texture = ImageTexture.create_from_image(image)
	return texture


func _on_pressed():
	emit_signal("begin_battle", battle_type)
