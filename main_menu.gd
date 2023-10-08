extends ColorRect

@onready var bank: Banking = get_node("/root/Bank")
@onready var anim_player = $AnimationPlayer

@export var next_scene_path: String

# Called when the node enters the scene tree for the first time.
func _ready():
	bank.visible = false
	anim_player.play_backwards("menu_fade")
	$"../Play".pressed.connect(_on_play_button_pressed)


func scene_transition(next_scene):
	anim_player.play("menu_fade")
	await anim_player.animation_finished
	
	bank.visible = true
	get_tree().change_scene_to_file(next_scene_path)


func _on_play_button_pressed():
	scene_transition(next_scene_path)
