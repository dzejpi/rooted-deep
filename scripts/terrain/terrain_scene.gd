extends Node3D

# Generate collision for map chunks
func _ready() -> void:
	var children_node_count = get_child_count()
	
	if children_node_count > 0:
		for i in children_node_count:
			get_child(i).get_child(0).create_trimesh_collision()
			
			# Collision created
			for child in get_child(i).get_child(0).get_children():
				if child is CollisionObject3D:
					child.add_to_group("ground")
			
			i += 1
