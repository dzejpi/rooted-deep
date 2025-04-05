extends Node2D


@onready var score: Label = $Score


func _ready() -> void:
	hide()


func show_game_over() -> void:
	update_game_over_label()
	show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func update_game_over_label() -> void:
	score.text = "You generated " + str(GlobalVar.current_profits) + "∅ of profits for your shareholders."
