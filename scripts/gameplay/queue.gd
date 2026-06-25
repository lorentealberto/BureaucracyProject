extends Sprite2D

@export var customer: PackedScene
@onready var timer: Timer = $Timer

var inst: Customer = null

func _ready() -> void:
	#create_new_customer()
	Events.bell_pressed.connect(create_new_customer)
	#timer.timeout.connect(create_new_customer)


func create_new_customer() -> void:
	if not is_instance_valid(inst):
		inst = customer.instantiate()
		inst.global_position = global_position
		get_tree().root.call_deferred("add_child", inst)
