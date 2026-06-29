extends VBoxContainer

@onready var buy_upgrade_button_scene: PackedScene = preload("res://scenes/prefabs/buy_upgrade_button.tscn")
func _ready() -> void:
	_setup_buttons()

func _setup_buttons() -> void:
	var buttons_tween: Tween = create_tween()
	for i: int in UpgradesData.upgrades_list.size():
		buttons_tween.tween_callback(_add_button.bind(i))
		buttons_tween.tween_interval(0.1)

func _add_button(id: int) -> void:
	var button: BuyUpgradeButton = buy_upgrade_button_scene.instantiate()
	add_child(button)
	button.id = id
	button.set_title(id) #1
	button.set_description(id) #2
	button.set_price(id)
	button.set_level(id)
