extends Node2D

class_name Banking

@export var balance: int = 1000

signal balance_updated(balance)

# Called when the node enters the scene tree for the first time.
func _ready():
	update_balance()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update_balance():
	$BoxContainer/RichTextLabel.text = str(balance)
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
