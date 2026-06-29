extends Label
class_name XPPoints

func _process(_delta: float) -> void:
	text = str(GameData.total_money).pad_zeros(4)
