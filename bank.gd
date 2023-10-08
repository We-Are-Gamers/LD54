extends Node2D

class_name Banking

@export var balance: int = 1000

signal balance_updated(balance)

var income_per_tick = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	update_balance()
	add_income_per_tick(0)
	stars_income_tick()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func  stars_income_tick():
	$IncomeTimer.start()
	
func  stop_income_tick():
	$IncomeTimer.start()


func add_income_per_tick(amount):
	income_per_tick += amount
	$BankInfo/IncomeLabel.text = "{0} per second".format([income_per_tick])

func update_balance():
	$BankInfo/BalanceLabel.text = str(balance)
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


func _on_income_timer_timeout():
	if income_per_tick == 0:
		return
	deposit(income_per_tick)
