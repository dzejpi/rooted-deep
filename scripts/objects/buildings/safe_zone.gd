extends Node3D


@export var player_node: CharacterBody3D


func _on_safe_zone_area_body_entered(body: Node3D) -> void:
	print("Player entered the area")
	if player_node:
		player_node.is_gaining_oxygen = true


func _on_safe_zone_area_body_exited(body: Node3D) -> void:
	print("Player left the area")
	if player_node:
		player_node.is_gaining_oxygen = false
