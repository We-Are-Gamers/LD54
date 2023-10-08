class_name AdDescription extends VBoxContainer

var ad_size = Vector2.ZERO : get = _get_ad_size

@export var income_amount: int

@export var button_text: String

@export var income_per_tick: bool

@export var ad_texture: Texture2D

@export var ad_animation: SpriteFrames
	
func _get_ad_size():
	return ad_texture.get_size()

signal preview_ad(ad: AdDescription)
signal pressed()

func _ready():
	$Button.text = "{x}x{y}".format({"x": ad_size.x, "y": ad_size.y})
	var tick_desc = "/s" if income_per_tick else ""
	var income_text = "+${0}{1}".format([income_amount, tick_desc])
	$Label.text = income_text

func _on_mouse_entered():
	preview_ad.emit(self)


func _on_button_button_down():
	pressed.emit()
