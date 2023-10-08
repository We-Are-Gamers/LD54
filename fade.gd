extends ColorRect

@onready var bank: Banking = get_node("/root/Bank")
@onready var anim_player = $AnimationPlayer

@export var restart_scene: String
@export var menu_scene: String

# Called when the node enters the scene tree for the first time.
func _ready():
	bank.visible = false
	anim_player.play_backwards("modulate")

func scene_transition(next_scene):
	anim_player.play("modulate")
	await anim_player.animation_finished
	
	get_tree().change_scene_to_file(next_scene)

func _on_restart_button_pressed():
	bank.visible = true
	bank.reset()
	scene_transition(restart_scene)

func _on_menu_button_pressed():
	scene_transition(menu_scene)
