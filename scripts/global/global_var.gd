extends Node


@onready var music_node: AudioStreamPlayer = $MusicPlayer
@onready var sfx_node: AudioStreamPlayer = $SfxPlayer

# Assigned in Inspector
@export var music_game_music: AudioStream

# Replace null with a proper preload("res://...")
# Or delete fully and set everything through Inspector
@export var sfx_sounds: Dictionary = {
	"fruit_grab": preload("res://assets/sfx/sfx_fruit_grab.mp3"),
	"oxygen_breathing": preload("res://assets/sfx/sfx_oxygen_breathing.mp3"),
	"oxygen_death": preload("res://assets/sfx/sfx_oxygen_death.mp3"),
	"oxygen_struggle": preload("res://assets/sfx/sfx_oxygen_struggle.mp3"),
	"plant": preload("res://assets/sfx/sfx_plant.mp3"),
	"select_a": preload("res://assets/sfx/sfx_select.mp3"),
	"select_b": preload("res://assets/sfx/sfx_select_b.mp3"),
}

var is_game_paused: bool = false
var is_game_over: bool = false
var is_game_won: bool = false
var is_ui_active: bool = false

# General game active state 
var is_game_active: bool = true

var current_profits = 0
var highest_profits = 0

var current_playtime: float = 0.0


func _ready() -> void:
	play_music()


func play_music() -> void:
	if music_game_music:
		music_node.stream = music_game_music
		music_node.play()


func stop_music() -> void:
	music_node.stop()


func play_sound(sfx_name: String) -> void:
	if sfx_name in sfx_sounds and sfx_sounds[sfx_name]:
		sfx_node.stream = sfx_sounds[sfx_name]
		sfx_node.play()


func stop_sound(sfx_name: String) -> void:
	if sfx_name in sfx_sounds and sfx_sounds[sfx_name]:
		sfx_node.stop()


func reset_game() -> void:
	is_game_paused = false
	is_game_over = false
	is_game_won = false
	is_ui_active = false
	detect_active_state()


func toggle_game_pause() -> void:
	is_game_paused = not is_game_paused
	detect_active_state()


func unpause_game() -> void:
	is_game_paused = false
	detect_active_state()


func toggle_game_over() -> void:
	is_game_over = true
	detect_active_state()


func toggle_game_won() -> void:
	is_game_won = true
	detect_active_state()


func toggle_manage_ui() -> void:
	is_ui_active = not is_ui_active
	detect_active_state()


func detect_active_state() -> void:
	if is_game_paused or is_game_over or is_game_won or is_ui_active:
		is_game_active = false
	else:
		is_game_active = true


func update_high_score() -> void:
	if current_profits > highest_profits:
		highest_profits = current_profits
