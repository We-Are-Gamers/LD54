class_name AdDescription extends VBoxContainer

var ad_size = Vector2.ZERO : get = _get_ad_size

@export var unlock_level: int

@export var income_amount: int

@export var button_text: String

@export var income_per_tick: bool

@export var ad_texture: Texture2D

@export var ad_animation: SpriteFrames

@onready var bank = get_node("/root/Bank")
	
func _get_ad_size():
	return ad_texture.get_size()

signal preview_ad(ad: AdDescription)
signal pressed()

func _ready():
	$Button.text = "{x}x{y} (level {lvl})".format({"lvl": unlock_level + 1, "x": ad_size.x, "y": ad_size.y})
	var tick_desc = "/s" if income_per_tick else ""
	var income_text = "+${0}{1}".format([income_amount, tick_desc])
	$Label.text = income_text
	
	bank.unlock_ads.connect(_on_ad_unlock)
	$Button.disabled = true
	_on_ad_unlock(0)

func _on_mouse_entered():
	if !$Button.disabled:
		preview_ad.emit(self)

func _on_button_button_down():
	pressed.emit()

func _on_ad_unlock(level: int):
	if level >= unlock_level:
		$Button.disabled = false
