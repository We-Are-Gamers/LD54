extends CollisionShape2D


# Called when the node enters the scene tree for the first time.
func set_ad(ad: AdDescription):
	if ad.ad_animation != null:
		update_animation(ad)
	else:
		update_texture(ad)
		
	shape = RectangleShape2D.new()
	(shape as RectangleShape2D).size = ad.ad_size
	
func update_texture(ad: AdDescription):
	$Sprite2D.texture = ad.ad_texture
	$Sprite2D.visible = true
	$AnimatedSprite2D.visible = false
	
func update_animation(ad: AdDescription):
	$AnimatedSprite2D.sprite_frames = ad.ad_animation
	$AnimatedSprite2D.play()
	$Sprite2D.visible = false
	$AnimatedSprite2D.visible = true
