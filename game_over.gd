extends Control

var AdWindow = preload("res://ads/ad_window.tscn")
var AdWin = preload("res://resources/ads/win_ad.png")
var AdLose = preload("res://resources/ads/lose_ad.png")

@onready var bank: Banking = get_node("/root/Bank")

var menu_ad: AdDescription = AdDescription.new()

func _ready():
	bank.stop_income_tick()
	bank.reset()
	
	if bank.win:
		display_game_win()
	else:
		display_game_lose()
	
	var num_ads = 3
	for i in range(num_ads):
		var ad_window = AdWindow.instantiate()
		ad_window.bank = bank
		var offset = 350 * (num_ads / 2) - 350 * i 
		ad_window.position = get_viewport().get_visible_rect().size / 2 - Vector2(offset, 250)
		ad_window.set_ad(menu_ad)
		
		$AdHolder.add_child.call_deferred(ad_window)
		
func display_game_win():
	menu_ad.ad_texture = ImageTexture.create_from_image(AdWin.get_image())
	menu_ad.ad_size = AdWin.get_size()
	
func display_game_lose():
	menu_ad.ad_texture = ImageTexture.create_from_image(AdLose.get_image())
	menu_ad.ad_size = AdLose.get_size()
