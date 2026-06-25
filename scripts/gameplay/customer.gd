extends Sprite2D
class_name Customer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	var go_forward: Tween = create_tween()

	go_forward.tween_property(self, "offset:y", -20, 1)
	go_forward.tween_callback(func() -> void: Events.customer_ready.emit())

	Events.job_done.connect(func() -> void: animation_player.play("fade_out"))
