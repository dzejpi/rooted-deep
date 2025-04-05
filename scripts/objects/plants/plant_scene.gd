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

@onready var plant_body: Node3D = $PlantBody

const FRUIT_SCENE = preload("res://scenes/objects/fruits/fruit_scene.tscn")

# TODO adjust properly once they exist!
const PLANT_A = preload("res://scenes/objects/plants/plant_a.tscn")
const PLANT_B = preload("res://scenes/objects/plants/plant_a.tscn")
const PLANT_C = preload("res://scenes/objects/plants/plant_a.tscn")
const PLANT_D = preload("res://scenes/objects/plants/plant_a.tscn")

# TODO adjust properly once they exist!
const FRUIT_A = preload("res://scenes/objects/fruits/fruit_a.tscn")
const FRUIT_B = preload("res://scenes/objects/fruits/fruit_a.tscn")
const FRUIT_C = preload("res://scenes/objects/fruits/fruit_a.tscn")
const FRUIT_D = preload("res://scenes/objects/fruits/fruit_a.tscn")

var is_growing = false
var is_fruit_set = false
var base_countdown = 1
var current_countdown = 0


func _process(delta: float) -> void:
	if current_countdown > 0:
		current_countdown -= 1 * delta
	else:
		current_countdown = base_countdown
		
		# Signal to all fruits to grow
		if is_fruit_set:
			grow_fruit(delta)


func set_fruit(fruit_number: int):
	var plant_scene = null
	is_growing = true
	
	# Add plant into the pot
	match(fruit_number):
		0:
			plant_scene = PLANT_A.instantiate()
		1:
			plant_scene = PLANT_B.instantiate()
		2:
			plant_scene = PLANT_A.instantiate()
		3:
			plant_scene = PLANT_A.instantiate()
	
	# Instantiate
	if plant_scene:
		plant_body.add_child(plant_scene)
	
	# TODO Adjust fruits
	match(fruit_number):
		0:
			var fruit_a_scene = null
			fruit_a_scene = FRUIT_A.instantiate()
			point_a.add_child(fruit_a_scene)
		1:
			var fruit_b_scene = null
			fruit_b_scene = FRUIT_A.instantiate()
			point_a.add_child(fruit_b_scene)
		2:
			var fruit_c_scene = null
			fruit_c_scene = FRUIT_A.instantiate()
			point_a.add_child(fruit_c_scene)
		3:
			var fruit_d_scene = null
			fruit_d_scene = FRUIT_A.instantiate()
			point_a.add_child(fruit_d_scene)
		
	is_fruit_set = true


func grow_fruit(delta: float) -> void:
	for fruit in get_tree().get_nodes_in_group("fruit"):
		print("Increasng fruit")
		fruit.increase_fruit(delta)
