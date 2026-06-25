extends Area2D
class_name ClickableComponent

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@export var squash_fx: PackedScene

var is_hovering: bool = false

func _ready() -> void:
	mouse_entered.connect(func() -> void:
		Input.set_default_cursor_shape(Input.CURSOR_POINTING_HAND)
		is_hovering = true)
	mouse_exited.connect(func() -> void:
		Input.set_default_cursor_shape(Input.CURSOR_ARROW)
		is_hovering = false)


func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT :
			if is_hovering and animation_player.current_animation == "":
				get_tree().root.add_child(squash_fx.instantiate())
				animation_player.play("squash")
