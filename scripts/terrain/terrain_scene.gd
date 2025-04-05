extends Node3D

# Generate collision for map chunks
func _ready() -> void:
	var children_node_count = get_child_count()
	
	if children_node_count > 0:
		for i in children_node_count:
			get_child(i).get_child(0).create_trimesh_collision()
			i += 1
