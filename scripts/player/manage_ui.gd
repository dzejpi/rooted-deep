extends Node2D


@onready var sell_ui: Node2D = $SellUi
@onready var buy_ui: Node2D = $BuyUi
@onready var upgrade_ui: Node2D = $UpgradeUi

# Switches
@onready var sell_button: TextureButton = $Switches/SellButton
@onready var buy_button: TextureButton = $Switches/BuyButton
@onready var upgrade_button: TextureButton = $Switches/UpgradeButton


@onready var floating_player_scene: CharacterBody3D = $"../.."

var selected_section: int = 0


func _ready() -> void:
	self.hide()


func _input(_event) -> void:
	if Input.is_action_just_pressed("game_manager"):
		GlobalVar.toggle_manage_ui()
		update_manage_state()
		switch_section(selected_section)
		
	if Input.is_action_just_pressed("game_pause"):
		if self.visible:
			GlobalVar.toggle_manage_ui()
			update_manage_state()
			switch_section(selected_section)


func switch_section(new_section: int) -> void:
	sell_ui.hide()
	buy_ui.hide()
	upgrade_ui.hide()
	
	match(new_section):
		0:
			sell_ui.show()
			sell_button.pressed
		1:
			buy_ui.show()
			buy_button.pressed
		2:
			upgrade_ui.show()
			upgrade_button.pressed


func update_manage_state() -> void:
	if GlobalVar.is_ui_active:
		show()
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		switch_section(selected_section)
	else:
		hide()
		Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)


func change_selection(new_selection: int) -> void:
	selected_section = new_selection
	switch_section(selected_section)


func _on_quit_pressed() -> void:
	GlobalVar.toggle_manage_ui()
	update_manage_state()


func _on_sell_button_pressed() -> void:
	selected_section = 0
	switch_section(selected_section)


func _on_buy_button_pressed() -> void:
	selected_section = 1
	switch_section(selected_section)


func _on_upgrade_pressed() -> void:
	selected_section = 2
	switch_section(selected_section)


func sell(flower_index: int, gainz: int) -> void:
	floating_player_scene.current_currency += gainz


func buy(flower_index: int, cost: int) -> void:
	floating_player_scene.current_currency -= cost
