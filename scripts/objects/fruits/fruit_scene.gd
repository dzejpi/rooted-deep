extends Node3D


var fruit_type: int = 0
var grow_speed: float = 0.1

var is_collectable: bool = false

var target_scale: Vector3 = Vector3(1, 1, 1)
var current_scale: Vector3 = Vector3(0, 0, 0)

@onready var fruit_model: Node3D = $FruitModel


func _ready() -> void:
	current_scale = Vector3(0, 0, 0)
	is_collectable = false


func set_fruit(fruit_index:int, fruit_grow_speed: int) -> void:
	fruit_type = fruit_index
	grow_speed = grow_speed


func increase_fruit(delta: float) -> void:
	if not is_collectable:
		current_scale += Vector3(grow_speed * delta, grow_speed * delta, grow_speed * delta)
		
		# Scale the fruit model
		fruit_model.scale = current_scale
		
		# Fruit grown, stop growing
		if current_scale == target_scale:
			is_collectable = true


# Collecting just resets the scale
func collect_fruit():
	if is_collectable:
		current_scale = Vector3(0, 0, 0)
		is_collectable = false
		return fruit_type
