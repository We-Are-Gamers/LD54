extends CollisionShape2D


# Called when the node enters the scene tree for the first time.
func set_ad(ad: AdDescription):
	$Sprite2D.texture = ad.ad_texture
	shape = RectangleShape2D.new()
	(shape as RectangleShape2D).size = ad.ad_size
	
