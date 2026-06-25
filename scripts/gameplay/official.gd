extends Sprite2D
class_name Official

@export var job_timer: PackedScene

func _ready() -> void:
	Events.customer_ready.connect(start_job)

func start_job() -> void:
	var inst: JobTimer = job_timer.instantiate()
	inst.global_position = global_position
	get_tree().root.add_child(inst)
