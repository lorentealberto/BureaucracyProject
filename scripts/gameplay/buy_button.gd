extends Button


signal valid_transaction
signal hover
signal unhover
@export var selected_fx: PackedScene

var price: float

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)
	pressed.connect(_on_pressed)

func _on_mouse_entered() -> void:
	hover.emit()
	if _check_can_afford():
		theme_type_variation = "enough_money"
	else:
		theme_type_variation = "no_money"

func _on_mouse_exited() -> void:
	unhover.emit()

func _check_can_afford() -> bool:
	var total_money: int = GameData.total_money
	return price <= total_money

func _on_pressed() -> void:
	if _check_can_afford():
		get_tree().root.call_deferred("add_child", selected_fx.instantiate())
		valid_transaction.emit()
	else:
		print("Error: Cannot afford this item.")
