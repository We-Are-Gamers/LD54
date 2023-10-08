extends Node2D

class_name Banking

@export var balance: int = 1000

signal balance_updated(balance)
signal unlock_ads(level: int)

var income_per_tick = 0
var win: bool = false

# Called when the node enters the scene tree for the first time.
func _ready():
	update_balance()
	add_income_per_tick(0)


func  start_income_tick():
	$IncomeTimer.start()
	
func  stop_income_tick():
	$IncomeTimer.stop()


func add_income_per_tick(amount):
	income_per_tick += amount
	$BankInfo/IncomeLabel.text = "${0}/s".format([income_per_tick])

func update_balance():
	$BankInfo/BalanceLabel.text = "${0}".format([balance])
	balance_updated.emit(balance)

func get_balance() -> int:
	return balance

func withdraw(amount) -> bool:
	if balance >= amount:
		balance -= amount
		update_balance()
		return true
	return false
	
func deposit(amount):
	balance += amount
	update_balance()

func reset():
	income_per_tick = 0
	add_income_per_tick(0)
	
	balance = 1000
	update_balance()
	
func level_up(level: int):
	unlock_ads.emit(level)

func _on_income_timer_timeout():
	if income_per_tick == 0:
		return
	deposit(income_per_tick)
