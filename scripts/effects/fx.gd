extends AudioStreamPlayer
class_name FX

func _ready() -> void:
	finished.connect(func() -> void: queue_free())
