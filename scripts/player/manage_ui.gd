extends Node2D

@onready var floating_player_scene: CharacterBody3D = $"../.."

# Content
@onready var sell_ui: Node2D = $SellUi
@onready var buy_ui: Node2D = $BuyUi
@onready var upgrade_ui: Node2D = $UpgradeUi

# Switches
@onready var sell_button: TextureButton = $Switches/SellButton
@onready var buy_button: TextureButton = $Switches/BuyButton
@onready var upgrade_button: TextureButton = $Switches/UpgradeButton
@onready var label_coins: Label = $Switches/LabelCoins

# Buy
@onready var buy_a_button: TextureButton = $BuyUi/FruitA/BuyAButton
@onready var buy_all_a_button: TextureButton = $BuyUi/FruitA/BuyAllAButton
@onready var buy_b_button: TextureButton = $BuyUi/FruitB/BuyBButton
@onready var buy_all_b_button: TextureButton = $BuyUi/FruitB/BuyAllBButton
@onready var buy_c_button: TextureButton = $BuyUi/FruitC/BuyCButton
@onready var buy_all_c_button: TextureButton = $BuyUi/FruitC/BuyAllCButton
@onready var buy_d_button: TextureButton = $BuyUi/FruitD/BuyDButton
@onready var buy_all_d_button: TextureButton = $BuyUi/FruitD/BuyAllDButton

# Sell
@onready var sell_a_button: TextureButton = $SellUi/FruitA/SellAButton
@onready var sell_all_a_button: TextureButton = $SellUi/FruitA/SellAllAButton
@onready var sell_b_button: TextureButton = $SellUi/FruitB/SellBButton
@onready var sell_all_b_button: TextureButton = $SellUi/FruitB/SellAllBButton
@onready var sell_c_button: TextureButton = $SellUi/FruitC/SellCButton
@onready var sell_all_c_button: TextureButton = $SellUi/FruitC/SellAllCButton
@onready var sell_d_button: TextureButton = $SellUi/FruitD/SellDButton
@onready var sell_all_d_button: TextureButton = $SellUi/FruitD/SellAllDButton


var fruit_a_sell_price: int = 100
var fruit_b_sell_price: int = 200
var fruit_c_sell_price: int = 300
var fruit_d_sell_price: int = 400

var seed_a_buy_price: int = 200
var seed_b_buy_price: int = 400
var seed_c_buy_price: int = 600
var seed_d_buy_price: int = 800

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
	update_coins()
	update_eligibility()
	
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
	match(flower_index):
		0:
			floating_player_scene.fruits_a -= 1
		1:
			floating_player_scene.fruits_b -= 1
		2:
			floating_player_scene.fruits_c -= 1
		3:
			floating_player_scene.fruits_d -= 1
	
	update_coins()
	update_eligibility()


func sell_max(flower_index: int, gainz: int) -> void:
	match(flower_index):
		0:
			var fruit_amount = floating_player_scene.fruits_a
			floating_player_scene.fruits_a -= fruit_amount
			floating_player_scene.current_currency += gainz * fruit_amount
		1:
			var fruit_amount = floating_player_scene.fruits_b
			floating_player_scene.fruits_b -= fruit_amount
			floating_player_scene.current_currency += gainz * fruit_amount
		2:
			var fruit_amount = floating_player_scene.fruits_c
			floating_player_scene.fruits_c -= fruit_amount
			floating_player_scene.current_currency += gainz * fruit_amount
		3:
			var fruit_amount = floating_player_scene.fruits_d
			floating_player_scene.fruits_d -= fruit_amount
			floating_player_scene.current_currency += gainz * fruit_amount
	
	update_coins()
	update_eligibility()


func buy(flower_index: int, cost: int) -> void:
	floating_player_scene.current_currency -= cost
	
	match(flower_index):
		0:
			floating_player_scene.plant_a_seeds += 1
		1:
			floating_player_scene.plant_b_seeds += 1
		2:
			floating_player_scene.plant_c_seeds += 1
		3:
			floating_player_scene.plant_d_seeds += 1
	
	update_coins()
	update_eligibility()


func buy_max(flower_index: int, cost: int) -> void:
	# Integer division
	var max_amount = floor(floating_player_scene.current_currency / cost)
	
	floating_player_scene.current_currency -= cost * max_amount
	
	match(flower_index):
		0:
			floating_player_scene.plant_a_seeds += max_amount
		1:
			floating_player_scene.plant_b_seeds += max_amount
		2:
			floating_player_scene.plant_c_seeds += max_amount
		3:
			floating_player_scene.plant_d_seeds += max_amount
	
	update_coins()
	update_eligibility()


func update_coins() -> void:
	label_coins.text = "∅: " + str(floating_player_scene.current_currency)


func update_eligibility() -> void:
	var current_currency: int = floating_player_scene.current_currency
	
	# Sell
	if floating_player_scene.fruits_a <= 0:
		sell_a_button.disabled = true
		sell_all_a_button.disabled = true
	else:
		sell_a_button.disabled = false
		sell_all_a_button.disabled = false
	
	if floating_player_scene.fruits_b <= 0:
		sell_b_button.disabled = true
		sell_all_b_button.disabled = true
	else:
		sell_b_button.disabled = false
		sell_all_b_button.disabled = false
	
	if floating_player_scene.fruits_c <= 0:
		sell_c_button.disabled = true
		sell_all_c_button.disabled = true
	else:
		sell_c_button.disabled = false
		sell_all_c_button.disabled = false
	
	if floating_player_scene.fruits_d <= 0:
		sell_d_button.disabled = true
		sell_all_d_button.disabled = true
	else:
		sell_d_button.disabled = false
		sell_all_d_button.disabled = false
	
	# Buy
	if current_currency < seed_a_buy_price:
		buy_a_button.disabled = true
		buy_all_a_button.disabled = true
	else:
		buy_a_button.disabled = false
		buy_all_a_button.disabled = false
	
	if current_currency < seed_b_buy_price:
		buy_b_button.disabled = true
		buy_all_b_button.disabled = true
	else:
		buy_b_button.disabled = false
		buy_all_b_button.disabled = false
	
	if current_currency < seed_c_buy_price:
		buy_c_button.disabled = true
		buy_all_c_button.disabled = true
	else:
		buy_c_button.disabled = false
		buy_all_c_button.disabled = false
	
	if current_currency < seed_d_buy_price:
		buy_d_button.disabled = true
		buy_all_d_button.disabled = true
	else:
		buy_d_button.disabled = false
		buy_all_d_button.disabled = false


func _on_sell_a_button_pressed() -> void:
	if floating_player_scene.fruits_a > 0:
		sell(0, fruit_a_sell_price)


func _on_sell_all_a_button_pressed() -> void:
	if floating_player_scene.fruits_a > 0:
		sell_max(0, fruit_a_sell_price)


func _on_sell_b_button_pressed() -> void:
	if floating_player_scene.fruits_b > 0:
		sell(1, fruit_b_sell_price)


func _on_sell_all_b_button_pressed() -> void:
	if floating_player_scene.fruits_b > 0:
		sell_max(1, fruit_b_sell_price)


func _on_sell_c_button_pressed() -> void:
	if floating_player_scene.fruits_c > 0:
		sell(2, fruit_c_sell_price)


func _on_sell_all_c_button_pressed() -> void:
	if floating_player_scene.fruits_c > 0:
		sell_max(2, fruit_c_sell_price)


func _on_sell_d_button_pressed() -> void:
	if floating_player_scene.fruits_d > 0:
		sell(3, fruit_d_sell_price)


func _on_sell_all_d_button_pressed() -> void:
	if floating_player_scene.fruits_d > 0:
		sell_max(3, fruit_d_sell_price)


func _on_buy_a_button_pressed() -> void:
	if floating_player_scene.current_currency >= seed_a_buy_price:
		buy(0, seed_a_buy_price)


func _on_buy_all_a_button_pressed() -> void:
	if floating_player_scene.current_currency >= seed_a_buy_price:
		buy_max(0, seed_a_buy_price)


func _on_buy_b_button_pressed() -> void:
	if floating_player_scene.current_currency >= seed_b_buy_price:
		buy(1, seed_b_buy_price)


func _on_buy_all_b_button_pressed() -> void:
	if floating_player_scene.current_currency >= seed_b_buy_price:
		buy_max(1, seed_b_buy_price)


func _on_buy_c_button_pressed() -> void:
	if floating_player_scene.current_currency >= seed_c_buy_price:
		buy(2, seed_c_buy_price)


func _on_buy_all_c_button_pressed() -> void:
	if floating_player_scene.current_currency >= seed_c_buy_price:
		buy_max(2, seed_c_buy_price)


func _on_buy_d_button_pressed() -> void:
	if floating_player_scene.current_currency >= seed_d_buy_price:
		buy(3, seed_d_buy_price)


func _on_buy_all_d_button_pressed() -> void:
	if floating_player_scene.current_currency >= seed_d_buy_price:
		buy_max(3, seed_d_buy_price)
