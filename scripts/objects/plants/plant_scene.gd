extends Node3D

@onready var fruit_points: Node3D = $FruitPoints

# Points for easily setting fruit positions
@onready var point_a: Node3D = $FruitPoints/PointA
@onready var point_b: Node3D = $FruitPoints/PointB
@onready var point_c: Node3D = $FruitPoints/PointC
@onready var point_d: Node3D = $FruitPoints/PointD
@onready var point_e: Node3D = $FruitPoints/PointE
@onready var point_f: Node3D = $FruitPoints/PointF
@onready var point_g: Node3D = $FruitPoints/PointG
@onready var point_h: Node3D = $FruitPoints/PointH

var is_growing = false
var base_countdown = 1
var current_countdown = 0


func _process(delta: float) -> void:
	if current_countdown > 0:
		current_countdown -= 1 * delta
	else:
		current_countdown = base_countdown
		
		# Signal to all fruits to grow
		grow_fruit(delta)


func set_fruit(fruit_number: int):
	is_growing = true


func grow_fruit(delta: float) -> void:
	var current_fruit_points = fruit_points.get_children()
	
	for fruit_point in current_fruit_points:
		if fruit_point.get_child_count() > 0:
			var fruit = fruit_point.get_child(0)
			if fruit is Node3D:
				fruit.increase_fruit(delta)
