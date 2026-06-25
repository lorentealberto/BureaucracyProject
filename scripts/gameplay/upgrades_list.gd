extends VBoxContainer

@onready var buy_upgrade_button_scene: PackedScene = preload("res://scenes/prefabs/buy_upgrade_button.tscn")
func _ready() -> void:
	_setup_buttons()

func _setup_buttons() -> void:
	for i: int in UpgradesData.upgrades_list.size():
			var button: BuyUpgradeButton = buy_upgrade_button_scene.instantiate()
			add_child(button)
			button.set_title(i) #1
			button.set_description(i) #2
			button.set_price(i)
			button.set_level(i)
