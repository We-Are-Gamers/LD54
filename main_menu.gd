extends ColorRect

var AdWindow = preload("res://ads/ad_window.tscn")
var AdTexture = preload("res://resources/ads/game_instructions.png")

@onready var bank: Banking = get_node("/root/Bank")
@onready var anim_player = $AnimationPlayer

@export var next_scene_path: String

var menu_ad: AdDescription = AdDescription.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	bank.visible = false
	
	menu_ad.ad_size = Vector2(300, 150)
	menu_ad.ad_texture = ImageTexture.create_from_image(AdTexture.get_image())
	var ad_window = AdWindow.instantiate()
	ad_window.bank = bank
	ad_window.position = %Play.get_global_position() + %Play.texture_normal.get_size() / 2
	ad_window.set_ad(menu_ad)
	$"../AdHolder".add_child.call_deferred(ad_window)
	
	anim_player.play_backwards("menu_fade")
	%Play.pressed.connect(_on_play_button_pressed)


func scene_transition(next_scene):
	anim_player.play("menu_fade")
	await anim_player.animation_finished
	
	bank.visible = true
	get_tree().change_scene_to_file(next_scene)


func _on_play_button_pressed():
	scene_transition(next_scene_path)


func _on_credits_pressed():
	$"../Credits".visible = true
