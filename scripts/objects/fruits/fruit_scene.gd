extends Node3D


@export var fruit_type: int = 0
var grow_speed: float = 1

var is_collectable: bool = false

var empty_scale: Vector3 = Vector3(0.01, 0.01, 0.01)
var target_scale: Vector3 = Vector3(0.5, 0.5, 0.5)
var current_scale: Vector3 = empty_scale


func _ready() -> void:
	current_scale = empty_scale
	is_collectable = false
	self.scale = current_scale


func set_fruit(fruit_index:int, fruit_grow_speed: float) -> void:
	fruit_type = fruit_index
	grow_speed = fruit_grow_speed
	
	self.scale = current_scale


func increase_fruit(delta: float) -> void:
	if not is_collectable:
		current_scale += Vector3(grow_speed * delta, grow_speed * delta, grow_speed * delta)
		
		# Scale the fruit model
		self.scale = current_scale
		
		# Fruit grown, stop growing
		if current_scale >= target_scale:
			is_collectable = true


# Collecting just resets the scale
func collect_fruit() -> int:
	if is_collectable:
		current_scale = empty_scale
		is_collectable = false
		return fruit_type
	else:
		return -1
