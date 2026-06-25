extends CPUParticles2D
class_name SFX

func _ready() -> void:
	emitting = true
	finished.connect(func() -> void: queue_free())
