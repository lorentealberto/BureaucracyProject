extends PanelContainer
class_name BuyUpgradeButton

@onready var title: Label = %Title
@onready var description: Label = %Description
@onready var price: Label = %Price
@onready var level: ProgressBar = %Level

func set_title(upgrade_id: int) -> void:
	title.text = str(UpgradesData.get_ui_name(upgrade_id))

func set_description(upgrade_id: int) -> void:
	description.text = str(UpgradesData.get_description(upgrade_id))

func set_price(upgrade_id: int) -> void:
	price.text = str(UpgradesData.get_cost(upgrade_id))

func set_level(upgrade_id: int) -> void:
	var max_level: int = UpgradesData.get_max_level(upgrade_id)
	level.max_value = max_level
	level.value = min(GameData.get_current_level(upgrade_id), max_level)
