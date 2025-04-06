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

# Upgrades
@onready var upgrade_a: TextureButton = $UpgradeUi/UpgradeA
@onready var upgrade_b: TextureButton = $UpgradeUi/UpgradeB
@onready var upgrade_c: TextureButton = $UpgradeUi/UpgradeC
@onready var upgrade_d: TextureButton = $UpgradeUi/UpgradeD
@onready var upgrade_e: TextureButton = $UpgradeUi/UpgradeE
@onready var upgrade_f: TextureButton = $UpgradeUi/UpgradeF
@onready var upgrade_g: TextureButton = $UpgradeUi/UpgradeG
@onready var upgrade_h: TextureButton = $UpgradeUi/UpgradeH
@onready var upgrade_i: TextureButton = $UpgradeUi/UpgradeI
@onready var upgrade_j: TextureButton = $UpgradeUi/UpgradeJ
@onready var upgrade_k: TextureButton = $UpgradeUi/UpgradeK
@onready var upgrade_l: TextureButton = $UpgradeUi/UpgradeL

# Labels
@onready var sell_fruit_a_label: Label = $SellUi/FruitA/SellFruitALabel
@onready var sell_fruit_b_label: Label = $SellUi/FruitB/SellFruitBLabel
@onready var sell_fruit_c_label: Label = $SellUi/FruitC/SellFruitCLabel
@onready var sell_fruit_d_label: Label = $SellUi/FruitD/SellFruitDLabel

@onready var buy_fruit_a_label: Label = $BuyUi/FruitA/BuyFruitALabel
@onready var buy_fruit_b_label: Label = $BuyUi/FruitB/BuyFruitBLabel
@onready var buy_fruit_c_label: Label = $BuyUi/FruitC/BuyFruitCLabel
@onready var buy_fruit_d_label: Label = $BuyUi/FruitD/BuyFruitDLabel

var fruit_a_sell_price: int = 10
var fruit_b_sell_price: int = 20
var fruit_c_sell_price: int = 30
var fruit_d_sell_price: int = 40

var seed_a_buy_price: int = 20
var seed_b_buy_price: int = 40
var seed_c_buy_price: int = 60
var seed_d_buy_price: int = 80

var selected_section: int = 0

# Too drunk for arrays
var upgrade_a_unlocked: bool = false
var upgrade_b_unlocked: bool = false
var upgrade_c_unlocked: bool = false
var upgrade_d_unlocked: bool = false
var upgrade_e_unlocked: bool = false
var upgrade_f_unlocked: bool = false
var upgrade_g_unlocked: bool = false
var upgrade_h_unlocked: bool = false
var upgrade_i_unlocked: bool = false
var upgrade_j_unlocked: bool = false
var upgrade_k_unlocked: bool = false
var upgrade_l_unlocked: bool = false

var upgrade_a_price: int = 25
var upgrade_b_price: int = 50
var upgrade_c_price: int = 75
var upgrade_d_price: int = 100
var upgrade_e_price: int = 150
var upgrade_f_price: int = 250
var upgrade_g_price: int = 500
var upgrade_h_price: int = 750
var upgrade_i_price: int = 1000
var upgrade_j_price: int = 1500
var upgrade_k_price: int = 2000
var upgrade_l_price: int = 2500

var profit_increase: float = 1.0


func _ready() -> void:
	self.hide()


func _input(_event) -> void:
	#if Input.is_action_just_pressed("game_manager"):
	#	GlobalVar.toggle_manage_ui()
	#	update_manage_state()
	#	switch_section(selected_section)
	
	if Input.is_action_just_pressed("game_pause"):
		if self.visible:
			GlobalVar.toggle_manage_ui()
			update_manage_state()
			switch_section(selected_section)


func display_manage_ui() -> void:
	GlobalVar.toggle_manage_ui()
	update_manage_state()
	update_amounts()
	switch_section(selected_section)
	
	selected_section = 0
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
			sell_button.grab_focus()
		1:
			buy_ui.show()
			buy_button.grab_focus()
		2:
			upgrade_ui.show()
			upgrade_button.grab_focus()


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
	floating_player_scene.current_currency += int(gainz * profit_increase)
	GlobalVar.current_profits += int(gainz * profit_increase)
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
	update_amounts()


func sell_max(flower_index: int, gainz: int) -> void:
	match(flower_index):
		0:
			var fruit_amount = floating_player_scene.fruits_a
			floating_player_scene.fruits_a -= fruit_amount
			floating_player_scene.current_currency += int(gainz * profit_increase * fruit_amount)
			GlobalVar.current_profits += int(gainz * profit_increase * fruit_amount)
		1:
			var fruit_amount = floating_player_scene.fruits_b
			floating_player_scene.fruits_b -= fruit_amount
			floating_player_scene.current_currency += int(gainz * profit_increase * fruit_amount)
			GlobalVar.current_profits += int(gainz * profit_increase * fruit_amount)
		2:
			var fruit_amount = floating_player_scene.fruits_c
			floating_player_scene.fruits_c -= fruit_amount
			floating_player_scene.current_currency += int(gainz * profit_increase * fruit_amount)
			GlobalVar.current_profits += int(gainz * profit_increase * fruit_amount)
		3:
			var fruit_amount = floating_player_scene.fruits_d
			floating_player_scene.fruits_d -= fruit_amount
			floating_player_scene.current_currency += int(gainz * profit_increase * fruit_amount)
			GlobalVar.current_profits += int(gainz * profit_increase * fruit_amount)
	
	update_coins()
	update_eligibility()
	update_amounts()


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
	
	floating_player_scene.update_seed_count_ui()
	update_coins()
	update_eligibility()
	update_amounts()


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
	
	floating_player_scene.update_seed_count_ui()
	update_coins()
	update_eligibility()
	update_amounts()


func update_coins() -> void:
	label_coins.text = "#: " + str(floating_player_scene.current_currency)


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
	
	# Upgrades
	if current_currency < upgrade_a_price or upgrade_a_unlocked:
		upgrade_a.disabled = true
	else:
		upgrade_a.disabled = false
	
	if current_currency < upgrade_b_price or upgrade_b_unlocked:
		upgrade_b.disabled = true
	else:
		upgrade_b.disabled = false
	
	if current_currency < upgrade_c_price or upgrade_c_unlocked:
		upgrade_c.disabled = true
	else:
		upgrade_c.disabled = false
	
	if current_currency < upgrade_d_price or upgrade_d_unlocked:
		upgrade_d.disabled = true
	else:
		upgrade_d.disabled = false
	
	if current_currency < upgrade_e_price or upgrade_e_unlocked:
		upgrade_e.disabled = true
	else:
		upgrade_e.disabled = false
	
	if current_currency < upgrade_f_price or upgrade_f_unlocked:
		upgrade_f.disabled = true
	else:
		upgrade_f.disabled = false
	
	if current_currency < upgrade_g_price or upgrade_g_unlocked:
		upgrade_g.disabled = true
	else:
		upgrade_g.disabled = false
	
	if current_currency < upgrade_h_price or upgrade_h_unlocked:
		upgrade_h.disabled = true
	else:
		upgrade_h.disabled = false
	
	if current_currency < upgrade_i_price or upgrade_i_unlocked:
		upgrade_i.disabled = true
	else:
		upgrade_i.disabled = false
	
	if current_currency < upgrade_j_price or upgrade_j_unlocked:
		upgrade_j.disabled = true
	else:
		upgrade_j.disabled = false
	
	if current_currency < upgrade_k_price or upgrade_k_unlocked:
		upgrade_k.disabled = true
	else:
		upgrade_k.disabled = false
	
	if current_currency < upgrade_l_price or upgrade_l_unlocked:
		upgrade_l.disabled = true
	else:
		upgrade_l.disabled = false


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


func _on_upgrade_a_pressed() -> void:
	var upgrade_price = upgrade_a_price
	if not upgrade_a_unlocked:
		if floating_player_scene.current_currency >= upgrade_price:
			increase_oxygen(5)
			floating_player_scene.current_currency -= upgrade_price
			upgrade_a_unlocked = true
			update_coins()
			update_eligibility()
			update_amounts()


func _on_upgrade_b_pressed() -> void:
	var upgrade_price = upgrade_b_price
	if not upgrade_b_unlocked:
		if floating_player_scene.current_currency >= upgrade_price:
			increase_speed(1.05)
			floating_player_scene.current_currency -= upgrade_price
			upgrade_b_unlocked = true
			update_coins()
			update_eligibility()
			update_amounts()


func _on_upgrade_c_pressed() -> void:
	var upgrade_price = upgrade_c_price
	if not upgrade_c_unlocked:
		if floating_player_scene.current_currency >= upgrade_price:
			increase_oxygen(20)
			floating_player_scene.current_currency -= upgrade_price
			upgrade_c_unlocked = true
			update_coins()
			update_eligibility()
			update_amounts()


func _on_upgrade_d_pressed() -> void:
	var upgrade_price = upgrade_d_price
	if not upgrade_d_unlocked:
		if floating_player_scene.current_currency >= upgrade_price:
			increase_speed(1.20)
			floating_player_scene.current_currency -= upgrade_price
			upgrade_d_unlocked = true
			update_coins()
			update_eligibility()
			update_amounts()


func _on_upgrade_e_pressed() -> void:
	var upgrade_price = upgrade_e_price
	if not upgrade_e_unlocked:
		if floating_player_scene.current_currency >= upgrade_price:
			increase_profit(0.05)
			floating_player_scene.current_currency -= upgrade_price
			upgrade_e_unlocked = true
			update_coins()
			update_eligibility()
			update_amounts()


func _on_upgrade_f_pressed() -> void:
	var upgrade_price = upgrade_f_price
	if not upgrade_f_unlocked:
		if floating_player_scene.current_currency >= upgrade_price:
			increase_speed(1.25)
			floating_player_scene.current_currency -= upgrade_price
			upgrade_f_unlocked = true
			update_coins()
			update_eligibility()
			update_amounts()


func _on_upgrade_g_pressed() -> void:
	var upgrade_price = upgrade_g_price
	if not upgrade_g_unlocked:
		if floating_player_scene.current_currency >= upgrade_price:
			increase_oxygen(25)
			floating_player_scene.current_currency -= upgrade_price
			upgrade_g_unlocked = true
			update_coins()
			update_eligibility()
			update_amounts()


func _on_upgrade_h_pressed() -> void:
	var upgrade_price = upgrade_h_price
	if not upgrade_h_unlocked:
		if floating_player_scene.current_currency >= upgrade_price:
			increase_profit(0.25)
			floating_player_scene.current_currency -= upgrade_price
			upgrade_h_unlocked = true
			update_coins()
			update_eligibility()
			update_amounts()


func _on_upgrade_i_pressed() -> void:
	var upgrade_price = upgrade_i_price
	if not upgrade_i_unlocked:
		if floating_player_scene.current_currency >= upgrade_price:
			increase_oxygen(50)
			floating_player_scene.current_currency -= upgrade_price
			upgrade_i_unlocked = true
			update_coins()
			update_eligibility()
			update_amounts()


func _on_upgrade_j_pressed() -> void:
	var upgrade_price = upgrade_j_price
	if not upgrade_j_unlocked:
		if floating_player_scene.current_currency >= upgrade_price:
			increase_speed(1.5)
			floating_player_scene.current_currency -= upgrade_price
			upgrade_j_unlocked = true
			update_coins()
			update_eligibility()
			update_amounts()


func _on_upgrade_k_pressed() -> void:
	var upgrade_price = upgrade_k_price
	if not upgrade_k_unlocked:
		if floating_player_scene.current_currency >= upgrade_price:
			increase_profit(1)
			floating_player_scene.current_currency -= upgrade_price
			upgrade_k_unlocked = true
			update_coins()
			update_eligibility()
			update_amounts()


func _on_upgrade_l_pressed() -> void:
	var upgrade_price = upgrade_l_price
	if not upgrade_l_unlocked:
		if floating_player_scene.current_currency >= upgrade_price:
			win_game()
			floating_player_scene.current_currency -= upgrade_price
			upgrade_l_unlocked = true
			update_coins()
			update_eligibility()
			update_amounts()


func increase_oxygen(increase: int) -> void:
	floating_player_scene.max_oxygen += increase


func increase_speed(increase: int) -> void:
	floating_player_scene.current_speed += floating_player_scene.current_speed * increase


func increase_profit(increase: int) -> void:
	profit_increase += increase


func win_game() -> void:
	GlobalVar.toggle_manage_ui()
	update_manage_state()
	floating_player_scene.trigger_game_won()


func update_amounts() -> void:
	sell_fruit_a_label.text = "Lunara fruits: " + str(floating_player_scene.fruits_a)
	sell_fruit_b_label.text = "Ribin fruits: " + str(floating_player_scene.fruits_b)
	sell_fruit_c_label.text = "Velu fruits: " + str(floating_player_scene.fruits_c)
	sell_fruit_d_label.text = "Droqua fruits: " + str(floating_player_scene.fruits_d)
	
	buy_fruit_a_label.text = "Lunara seeds: " + str(floating_player_scene.plant_a_seeds)
	buy_fruit_b_label.text = "Ribin seeds: " + str(floating_player_scene.plant_b_seeds)
	buy_fruit_c_label.text = "Velu seeds: " + str(floating_player_scene.plant_c_seeds)
	buy_fruit_d_label.text = "Droqua seeds: " + str(floating_player_scene.plant_d_seeds)
