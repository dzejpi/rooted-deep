extends TextureButton


@export var main_menu_scene: Node


func _on_pressed() -> void:
	main_menu_scene.current_focus = "credits"
	GlobalVar.play_sound("select_a")
	release_focus()
