extends Button

var price: float

func _ready() -> void:
	mouse_entered.connect(_on_mouse_entered)
	mouse_exited.connect(_on_mouse_exited)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	print(price)


func _on_mouse_entered() -> void:
	pass


func _on_mouse_exited() -> void:
	pass
