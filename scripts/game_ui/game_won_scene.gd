extends Node2D


@onready var score: Label = $Score
@onready var time: Label = $Time


func _ready() -> void:
	hide()


func show_game_won() -> void:
	update_game_over_label()
	show()
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)


func update_game_over_label() -> void:
	score.text = "You generated " + str(GlobalVar.current_profits) + "# of profits for your shareholders."
	
	var minutes = int(GlobalVar.current_playtime) / 60
	var seconds = int(GlobalVar.current_playtime) % 60
	
	time.text = "It only took you " + str(minutes) + " minutes and " + str(seconds) + " seconds to win!"
