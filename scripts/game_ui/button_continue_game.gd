extends TextureButton


@export var game_pause_scene: Node


func _on_pressed() -> void:
	game_pause_scene.unpause_game()
	GlobalVar.play_sound("select_a")
	release_focus()
