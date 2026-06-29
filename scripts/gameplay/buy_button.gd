extends Button

signal valid_transaction
var price: float
var can_afford: bool = false

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	pressed.connect(_on_pressed)

func _on_mouse_entered() -> void:
	var total_money: int = GameData.total_money
	can_afford = price <= total_money
	if can_afford:
		theme_type_variation = "enough_money"
	else:
		theme_type_variation = "no_money"

func _on_pressed() -> void:
	if can_afford:
		valid_transaction.emit()
	else:
		print("Error: Cannot afford this item.")
