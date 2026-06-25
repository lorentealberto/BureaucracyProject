extends Sprite2D

@export var bell_sfx: PackedScene
@onready var area_2d: Area2D = $Area2D
@onready var animation_player: AnimationPlayer = $AnimationPlayer

var is_hovering: bool = false

func _ready() -> void:
	area_2d.mouse_entered.connect(func() -> void:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		is_hovering = true)
	area_2d.mouse_exited.connect(func() -> void:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		is_hovering = false)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
			if is_hovering:
				get_tree().root.add_child(bell_sfx.instantiate())
				Events.bell_pressed.emit()
				animation_player.play("press")
