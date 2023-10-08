class_name AdDescription extends Button

var ad_size = Vector2.ZERO : get = _get_ad_size

@export var income_amount: int

@export var income_per_tick: bool

@export var ad_texture: Texture2D
	
func _get_ad_size():
	return ad_texture.get_size()

signal preview_ad(ad: AdDescription)

func _ready():
	var size_text = "{x}x{y}".format({"x": ad_size.x, "y": ad_size.y})
	var tick_desc = "per tick" if income_per_tick else "when placed"
	var income_text = "makes ${0} {1}".format([income_amount, tick_desc])
	text = "{0} {1}".format([size_text, income_text])

func _on_mouse_entered():
	preview_ad.emit(self)
