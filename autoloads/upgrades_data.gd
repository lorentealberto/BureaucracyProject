extends Node

const grow_factor: float = 1.15

enum BaseStat {
	NONE,
	work_speed,
	total_work,
	customer_gains,
	special_customer_prob
}

#region Data IDs
const UI_NAME_ID: int = 0
const DESCRIPTION_ID: int = 1
const BASE_STAT_ID: int = 2
const COST_ID: int = 3
const MAX_LEVEL_ID: int = 4
const BONUS_ID: int = 5
#endregion

var bonuses: Dictionary[UpgradesData.BaseStat, float] = {
	UpgradesData.BaseStat.work_speed: 0,
	UpgradesData.BaseStat.total_work: 0,
	UpgradesData.BaseStat.customer_gains: 0,
	UpgradesData.BaseStat.special_customer_prob: 0
}

var upgrades_list: Array
var _work_speed_upgrades: Array[int]
var _total_work_upgrades: Array[int]
var _customer_gains_upgrades: Array[int]
var _special_customer_prob: Array[int]

func _ready() -> void:
	upgrades_list = _load_data()
	GameData.meta_upgrades = _init_meta_upgrades()

	_work_speed_upgrades = _get_work_speed_upgrades()
	_total_work_upgrades = _get_total_work_upgrades()
	_customer_gains_upgrades = _get_customer_gains_upgrades()
	_special_customer_prob = _get_special_customer_prob_upgrades()

func update_bonuses() -> void:
	bonuses[BaseStat.work_speed] = _get_work_speed_bonus()
	bonuses[BaseStat.total_work] = _get_total_work_bonus()
	bonuses[BaseStat.customer_gains] = _get_customer_gains_bonus()
	bonuses[BaseStat.special_customer_prob] = _get_special_customer_prob_bonus()

#region Init
func _init_meta_upgrades() -> Array[Array]:
	var temp: Array[Array]
	for id: int in UpgradesData.upgrades_list.size():
		temp.append([id, 0])
	return temp

func _load_data() -> Array[Array]:
	var upgrades: Array[Array]
	var path: String = "res://upgrades/"
	var file_names: Array[String] = _get_file_names(path)
	file_names.sort()

	for file_name in file_names:
		upgrades.append(_process_upgrade_file(path, file_name))
	return upgrades

func _get_file_names(base_path: String) -> Array[String]:
	var file_names: Array[String]
	var dir: DirAccess = DirAccess.open(base_path)

	#Safety check
	if not dir: return []

	dir.list_dir_begin()
	var file_name: String = dir.get_next()

	while file_name != "":
		if file_name.get_extension() == "tres":
			file_names.append(file_name)
		file_name = dir.get_next()
	dir.list_dir_end()

	return file_names

func _process_upgrade_file(base_path: String, file_name: String) -> Array:
	var file: Upgrade = load(base_path + file_name)
	var data: Array = [
		file.ui_name,
		file.description,
		file.base_stat,
		file.cost,
		file.max_value,
		file.bonus,
	]
	return data
#endregion

func increase_level(upgrade_id: int) -> void:
	var cost: int = get_cost(upgrade_id)
	if get_current_level(upgrade_id) < get_max_level(upgrade_id) and GameData.total_money >= cost:
		GameData.meta_upgrades[upgrade_id][1] += 1
		GameData.total_money -= cost

#region Getters
func get_ui_name(id: int) -> String:
	return upgrades_list[id][UI_NAME_ID]

func get_description(id: int) -> String:
	return upgrades_list[id][DESCRIPTION_ID]

func get_cost(id: int) -> int:
	return upgrades_list[id][COST_ID] * pow(grow_factor, get_current_level(id))

func get_current_level(upgrade_id: int) -> int:
	return GameData.meta_upgrades[upgrade_id][1]

func get_max_level(id: int) -> int:
	return upgrades_list[id][MAX_LEVEL_ID]

func _get_bonus(id: int) -> float:
	return upgrades_list[id][BONUS_ID]

func _get_base_stat(id: int) -> int:
	return BaseStat.values()[upgrades_list[id][BASE_STAT_ID]]
#endregion
#GET UPGRADES
func _get_work_speed_upgrades() -> Array[int]:
	var valid_upgrades: Array[int]
	for id in upgrades_list.size():
		if _get_base_stat(id) == BaseStat.work_speed:
			valid_upgrades.append(id)
	return valid_upgrades

func _get_total_work_upgrades() -> Array[int]:
	var valid_upgrades: Array[int]
	for id in upgrades_list.size():
		if _get_base_stat(id) == BaseStat.total_work:
			valid_upgrades.append(id)
	return valid_upgrades

func _get_customer_gains_upgrades() -> Array[int]:
	var valid_upgrades: Array[int]
	for id in upgrades_list.size():
		if _get_base_stat(id) == BaseStat.customer_gains:
			valid_upgrades.append(id)
	return valid_upgrades

func _get_special_customer_prob_upgrades() -> Array[int]:
	var valid_upgrades: Array[int]
	for id in upgrades_list.size():
		if _get_base_stat(id) == BaseStat.special_customer_prob:
			valid_upgrades.append(id)
	return valid_upgrades

#GET BONUSES
func _get_work_speed_bonus() -> float:
	var total_bonus: float = 0
	for id in _work_speed_upgrades:
		var upgrade_level: int = GameData.meta_upgrades[id][1]
		var bonus: float = _get_bonus(id) * upgrade_level
		total_bonus += bonus
	return total_bonus

func _get_total_work_bonus() -> float:
	var total_bonus: float = 0
	for id in _total_work_upgrades:
		var upgrade_level: int = GameData.meta_upgrades[id][1]
		var bonus: float = _get_bonus(id) * upgrade_level
		total_bonus += bonus
	return total_bonus

func _get_customer_gains_bonus() -> float:
	var total_bonus: float = 0
	for id in _customer_gains_upgrades:
		var upgrade_level: int = GameData.meta_upgrades[id][1]
		var bonus: float = _get_bonus(id) * upgrade_level
		total_bonus += bonus
	return total_bonus

func _get_special_customer_prob_bonus() -> float:
	var total_bonus: float = 0
	for id in _special_customer_prob:
		var upgrade_level: int = GameData.meta_upgrades[id][1]
		var bonus: float = _get_bonus(id) * upgrade_level
		total_bonus += bonus
	return total_bonus
