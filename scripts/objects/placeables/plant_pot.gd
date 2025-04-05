extends Node3D

# True if placed directly in editor
@export var is_placed_in_editor: bool = false
@export var selected_plant: int = 0

@export var plant_scene: PackedScene

@onready var plant_node_placement: Node3D = $PlantNode


func _ready() -> void:
	if is_placed_in_editor:
		set_plant(selected_plant)


func set_plant(fruit_number: int):
	var plant_instance = plant_scene.instantiate()
	plant_node_placement.add_child(plant_instance)
	plant_instance.global_transform.origin = plant_node_placement.global_transform.origin
	plant_instance.set_fruit(selected_plant)
