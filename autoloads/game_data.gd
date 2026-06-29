extends Node

var total_money: int = 20
var meta_upgrades: Array[Array]


func _ready() -> void:
	Events.job_done.connect(_add_money)

func _add_money() -> void:
	total_money += 1 * (1.0 + UpgradesData.bonuses[UpgradesData.BaseStat.customer_gains])

#For testing purpose only
func get_rnd_dataset() -> void:
	for id in UpgradesData.upgrades_list.size():
		meta_upgrades.append([id, randi_range(0, 10)])

func get_current_level(id: int) -> int:
	return GameData.meta_upgrades[id][1]
