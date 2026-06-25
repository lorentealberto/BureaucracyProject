extends Node2D
class_name Eye

@onready var spr: Sprite2D = $Sprite2D

const RADIUS: float = 2.5

func _process(_delta: float) -> void:
	var dir: Vector2 = (get_global_mouse_position() - global_position).normalized()
	spr.global_position = spr.global_position.lerp(global_position + dir * RADIUS, 0.25)
