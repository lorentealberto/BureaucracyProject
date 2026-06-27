extends Button

var price: float
var _total_money: float

func _ready() -> void:
	_total_money = GameData.total_money
	mouse_entered.connect(_on_mouse_entered)
	pressed.connect(_on_pressed)

func _on_mouse_entered() -> void:
	if price > _total_money:
		theme_type_variation = "no_money"

func _on_pressed() -> void:
	_total_money = GameData.total_money
