extends TextureProgressBar
class_name JobTimer

@export var job_done_sfx: PackedScene
@export var done_fx: PackedScene
@onready var timer: Timer = $Timer
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	timer.timeout.connect(increase_progress)
	animation_player.animation_finished.connect(manage_state)


func increase_progress() -> void:
	value += 1

	if value >= max_value:
		var inst: SFX = job_done_sfx.instantiate()
		inst.global_position = global_position + pivot_offset
		animation_player.play("disappear")
		get_tree().root.add_child(inst)
		get_tree().root.add_child(done_fx.instantiate())
		Events.job_done.emit()

func manage_state(anim_name: String) -> void:
	match anim_name:
		"appear":
			timer.start()
		"disappear":
			queue_free()

func update_data() -> void:
	timer.wait_time -= GameData.calculate_work_speed()
	max_value -= GameData.calculate_total_work()
