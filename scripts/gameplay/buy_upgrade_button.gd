extends PanelContainer
class_name BuyUpgradeButton

@onready var title: Label = %Title
@onready var description: Label = %Description
@onready var price: Label = %Price
@onready var level: ProgressBar = %Level
@onready var button: Button = %Button

var _price: float
var id: int = -1

func _ready() -> void:
	button.valid_transaction.connect(_on_valid_transaction)
	button.hover.connect(_on_hover)
	button.unhover.connect(_on_unhover)
	pivot_offset_ratio = Vector2(0.5, 0.5)


func set_title(upgrade_id: int) -> void:
	title.text = str(UpgradesData.get_ui_name(upgrade_id))

func set_description(upgrade_id: int) -> void:
	description.text = str(UpgradesData.get_description(upgrade_id))

func set_price(upgrade_id: int) -> void:
	_price = UpgradesData.get_cost(upgrade_id)
	button.price = _price
	price.text = str(_price)

func set_level(upgrade_id: int) -> void:
	var max_level: int = UpgradesData.get_max_level(upgrade_id)
	level.max_value = max_level
	level.value = min(GameData.get_current_level(upgrade_id), max_level)

func update_ui() -> void:
	button.change_color()
	set_level(id)
	set_price(id)

func _on_valid_transaction() -> void:
	Events.upgrade_bought.emit()
	UpgradesData.increase_level(id)
	update_ui()

func _on_hover() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1.025, 1.025), 0.1)

func _on_unhover() -> void:
	var tween: Tween = create_tween()
	tween.tween_property(self, "scale", Vector2(1, 1), 0.1)
