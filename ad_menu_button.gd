extends Button

@export
var ad_size = Vector2(1, 1)

signal preview_ad(ad_size)

func _ready():
	text = "{x}x{y}".format({"x": ad_size.x, "y": ad_size.y})

func _on_mouse_entered():
	preview_ad.emit(ad_size)
