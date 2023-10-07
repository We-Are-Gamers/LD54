extends Node2D


@export var balance: int = 1000

# Called when the node enters the scene tree for the first time.
func _ready():
	update_balance_view()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func update_balance_view():
	$BoxContainer/RichTextLabel.text = '[center]{0}[/center]'.format([str(balance)])

func get_balance() -> int:
	return balance

func withdraw(amount) -> bool:
	if balance >= amount:
		balance -= amount
		update_balance_view()
		return true
	return false
	
func deposit(amount):
	balance += amount
	update_balance_view()
