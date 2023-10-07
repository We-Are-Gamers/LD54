extends Node2D

func _ready():
	pass

func set_ad_size(ad_size):
	$Area2D/Sprite2D.scale = ad_size
