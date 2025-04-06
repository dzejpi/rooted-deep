extends Node3D

# True if placed directly in editor
@export var is_placed_in_editor: bool = false
@export var selected_plant: int = 0

@export var fruit_growth_speed: float = 0.25
@export var current_fruit_growth: float = 0.0

@onready var plant_body: Node3D = $PlantBody

var is_autocollecting = false

# PLANT models 
const PLANT_A = preload("res://scenes/objects/plants/plant_a.tscn")
const PLANT_B = preload("res://scenes/objects/plants/plant_b.tscn")
const PLANT_C = preload("res://scenes/objects/plants/plant_c.tscn")
const PLANT_D = preload("res://scenes/objects/plants/plant_d.tscn")

# FRUIT models
const FRUIT_A = preload("res://scenes/objects/fruits/fruit_a.tscn")
const FRUIT_B = preload("res://scenes/objects/fruits/fruit_b.tscn")
const FRUIT_C = preload("res://scenes/objects/fruits/fruit_c.tscn")
const FRUIT_D = preload("res://scenes/objects/fruits/fruit_d.tscn")

@onready var fruit_points: Node3D = $FruitPoints
@onready var point_a: Node3D = $FruitPoints/PointA
@onready var point_b: Node3D = $FruitPoints/PointB
@onready var point_c: Node3D = $FruitPoints/PointC
@onready var point_d: Node3D = $FruitPoints/PointD
@onready var point_e: Node3D = $FruitPoints/PointE
@onready var point_f: Node3D = $FruitPoints/PointF
@onready var point_g: Node3D = $FruitPoints/PointG
@onready var point_h: Node3D = $FruitPoints/PointH

@onready var plant_autocollect: Node3D = $PlantAutocollect

var is_plant_set = false


func _ready() -> void:
	if is_placed_in_editor:
		set_plant(selected_plant)


func _process(delta: float) -> void:
	# More forgiving - plants grow even when game is paused
	if is_plant_set:
		manage_growth(delta)


func set_plant(fruit_number: int):
	# Instantiate PLANT
	match(fruit_number):
		0:
			var plant_a = PLANT_A.instantiate()
			plant_body.add_child(plant_a)
		1:
			var plant_b = PLANT_B.instantiate()
			plant_body.add_child(plant_b)
		2:
			var plant_c = PLANT_C.instantiate()
			plant_body.add_child(plant_c)
		3:
			var plant_d = PLANT_D.instantiate()
			plant_body.add_child(plant_d)
	
	# Instantiate its FRUITS
	match(fruit_number):
		0:
			var fruit_a_a = FRUIT_A.instantiate()
			point_a.add_child(fruit_a_a)
			
			var fruit_a_b = FRUIT_A.instantiate()
			point_c.add_child(fruit_a_b)
			
			var fruit_a_c = FRUIT_A.instantiate()
			point_h.add_child(fruit_a_c)
		1:
			var fruit_b_a = FRUIT_B.instantiate()
			point_b.add_child(fruit_b_a)
			
			var fruit_b_b = FRUIT_B.instantiate()
			point_c.add_child(fruit_b_b)
			
			var fruit_b_c = FRUIT_B.instantiate()
			point_d.add_child(fruit_b_c)
			
			var fruit_b_d = FRUIT_B.instantiate()
			point_g.add_child(fruit_b_d)
		2:
			var fruit_c_a = FRUIT_C.instantiate()
			point_b.add_child(fruit_c_a)
			
			var fruit_c_b = FRUIT_C.instantiate()
			point_c.add_child(fruit_c_b)
			
			var fruit_c_c = FRUIT_C.instantiate()
			point_e.add_child(fruit_c_c)
			
			var fruit_c_d = FRUIT_C.instantiate()
			point_f.add_child(fruit_c_d)
			
			var fruit_c_e = FRUIT_C.instantiate()
			point_h.add_child(fruit_c_e)
		3:
			var fruit_d_a = FRUIT_D.instantiate()
			point_b.add_child(fruit_d_a)
			
			var fruit_d_b = FRUIT_D.instantiate()
			point_c.add_child(fruit_d_b)
			
			var fruit_d_c = FRUIT_D.instantiate()
			point_e.add_child(fruit_d_c)
			
			var fruit_d_d = FRUIT_D.instantiate()
			point_g.add_child(fruit_d_d)
	
	is_plant_set = true


func manage_growth(delta: float) -> void:
	if current_fruit_growth > 0:
		current_fruit_growth -= delta
	else:
		signal_growth(delta)
		current_fruit_growth = fruit_growth_speed


func signal_growth(delta: float) -> void:
	for point in fruit_points.get_children():
		for fruit in point.get_children():
			if fruit.is_in_group("fruits"):
				fruit.increase_fruit(delta)


func buy_auto_collection() -> void:
	print("Autocollecting now")
	is_autocollecting = true
	plant_autocollect.show()
	
	for point in fruit_points.get_children():
		for fruit in point.get_children():
			if fruit.is_in_group("fruits"):
				fruit.set_autocollectable()
