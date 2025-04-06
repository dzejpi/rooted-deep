extends CharacterBody3D


var current_speed: float = 5.0
const FLOAT_VELOCITY: float = 50

@onready var player_camera: Camera3D = $PlayerHead/Camera
@onready var ray_cast: RayCast3D = $PlayerHead/Camera/RayCast3D

# UI parts
@onready var typewriter_dialog: Node2D = $PlayerUI/GameUI/TypewriterDialogScene
@onready var player_tooltip: Node2D = $PlayerUI/GameUI/PlayerTooltip

@onready var game_over_scene: Node2D = $PlayerUI/GameEnd/GameOverScene
@onready var game_won_scene: Node2D = $PlayerUI/GameEnd/GameWonScene

@onready var player_ui: Node2D = $PlayerUI/PlayerUi
@onready var currency_label: Label = $PlayerUI/PlayerUi/CurrencyLabel
@onready var oxygen_label: Label = $PlayerUI/PlayerUi/OxygenLabel

@onready var manage_ui: Node2D = $PlayerUI/ManageUi

@export var placeable_objects: Node3D
@export var plant_pot_preview: PackedScene
var preview_instance: Node3D

@export var plant_pot_scene: PackedScene
var currently_selected_plant = 0

var fruits_a: int = 0
var fruits_b: int = 0
var fruits_c: int = 0
var fruits_d: int = 0

var plant_a_seeds: int = 1
var plant_b_seeds: int = 1
var plant_c_seeds: int = 1
var plant_d_seeds: int = 1

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")

var mouse_sensitivity: float = 0.75
# Mouse movement
var mouse_delta: Vector2 = Vector2.ZERO

# Constant gravitational pull downwards
var is_pulled_down: bool = true

# Debug for console info
var debug: bool = true

# Last collider player looked at
var last_looked_at: String = ""

var current_currency: int = 50000
var max_oxygen: float = 100.0
var current_oxygen: float = 50
var is_gaining_oxygen: bool = false

var oxygen_down_rate: float = 1
var oxygen_up_rate: float = 8

var is_placing_plant: bool = false

var snapped_position: Vector3
var is_pot_placeable: bool = false

var current_tooltip = ""


func _ready() -> void:
	GlobalVar.reset_game()
	TransitionOverlay.fade_out()
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	# Reset score
	GlobalVar.current_profits = 0
	# Reset label
	update_coins(0)


func _input(event: InputEvent) -> void:
	if GlobalVar.is_game_active:
		if event is InputEventMouseMotion:
			mouse_delta = event.relative
		
		if event.is_action_pressed("interact"):
			if is_pot_placeable and is_placing_plant:
				print("Placing pot")
				place_plant_pot()
			else:
				try_to_collect_fruit()
		
		if event.is_action_pressed("computer_up"):
			try_to_access_computer()
		
		if event.is_action_pressed("dismiss_placement"):
			if is_placing_plant:
				dismiss_plant_placing()
		
		if event.is_action_pressed("fruit_a"): 
			if not is_placing_plant:
				if plant_a_seeds > 0:
					currently_selected_plant = 0
					start_plant_placing()
			else:
				dismiss_plant_placing()
		
		if event.is_action_pressed("fruit_b"):
			if not is_placing_plant:
				if plant_b_seeds > 0:
					currently_selected_plant = 1
					start_plant_placing()
			else:
				dismiss_plant_placing()
		
		if event.is_action_pressed("fruit_c"):
			if not is_placing_plant:
				if plant_c_seeds > 0:
					currently_selected_plant = 2
					start_plant_placing()
			else:
				dismiss_plant_placing()
		
		if event.is_action_pressed("fruit_d"):
			if not is_placing_plant:
				if plant_d_seeds > 0:
					currently_selected_plant = 3
					start_plant_placing()
			else:
				dismiss_plant_placing()


func _process(delta: float) -> void:
	toggle_ui()
	
	if not GlobalVar.is_game_active:
		return
	
	update_oxygen_level(delta)
	
	update_pot_preview()


func _physics_process(delta: float) -> void:
	# Not processing at all if the game isn't active
	if not GlobalVar.is_game_active:
		return
	
	# Camera movement
	adjust_camera(delta)
	
	# Vertical movement
	var vertical_velocity: float = 0.0
	if Input.is_action_pressed("move_jump"):
		vertical_velocity += FLOAT_VELOCITY * delta
		start_plant_placing()
	elif Input.is_action_pressed("move_crouch"):
		vertical_velocity -= FLOAT_VELOCITY * delta
	
	# Nonstop pull downwards (underwater)
	if is_pulled_down:
		vertical_velocity -= (gravity / 4) * delta
	
	# Smoothly reduce if no input
	velocity.y = lerp(velocity.y, vertical_velocity, 0.1)
	
	# Get the input direction and handle the movement/deceleration.
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	# Sprinting
	var speed_multiplier: float = 1.0
	if Input.is_action_pressed("move_sprint"):
		speed_multiplier = 2.0
	
	# Final horizontal velocity
	velocity.x = move_toward(velocity.x, direction.x * current_speed * speed_multiplier, current_speed * delta)
	velocity.z = move_toward(velocity.z, direction.z * current_speed * speed_multiplier, current_speed * delta)
	
	move_and_slide()
	process_collisions()


func adjust_camera(delta: float) -> void:
	rotation_degrees.y -= (mouse_delta.x * mouse_sensitivity * delta * 60) / 10
	player_camera.rotation_degrees.x = clamp(player_camera.rotation_degrees.x - (mouse_delta.y * mouse_sensitivity * delta * 60) / 10, -90, 90)
	
	# Reset mouse delta
	mouse_delta = Vector2.ZERO


func process_collisions() -> void:
	if ray_cast.is_colliding():
		var collider = ray_cast.get_collider()
		var collision_object = ray_cast.get_collider().name
		manage_tooltip(collider, collision_object)
		
		if collision_object != last_looked_at:
			last_looked_at = collision_object
			if debug:
				print("Player is looking at: " + collision_object + ".")
	else:
		dismiss_tooltip()
		if last_looked_at != "nothing":
			last_looked_at = "nothing"
			if debug:
				print("Player is looking at: nothing.")


func trigger_game_over() -> void:
	GlobalVar.update_high_score()
	GlobalVar.toggle_game_over()
	game_over_scene.show_game_over()


func trigger_game_won() -> void:
	GlobalVar.update_high_score()
	GlobalVar.toggle_game_won()
	game_won_scene.show_game_won()


func update_oxygen_level(delta: float) -> void:
	if is_gaining_oxygen:
		if current_oxygen < max_oxygen:
			if current_oxygen >= max_oxygen:
				current_oxygen = max_oxygen
			else:
				current_oxygen += oxygen_up_rate * delta 
	else:
		current_oxygen -= oxygen_down_rate * delta
		if current_oxygen < 0.0:
			current_oxygen = 0.0
			trigger_game_over()
	
	oxygen_label.text = "Oxygen: " + str(int(current_oxygen)) + "%"


func update_coins(amount: int) -> void:
	current_currency += amount
	
	# Corporation always makes money 
	GlobalVar.current_profits += abs(amount)
	
	currency_label.text = "∅: " + str(current_currency)


func toggle_ui() -> void:
	if GlobalVar.is_game_active:
		player_ui.show()
	else:
		player_ui.hide()


func start_plant_placing() -> void:
	is_placing_plant = true


func dismiss_plant_placing() -> void:
	is_placing_plant = false
	dismiss_tooltip()


func update_pot_preview() -> void:
	if is_placing_plant:
		if ray_cast.is_colliding() and ray_cast.get_collider().is_in_group("ground") and not ray_cast.get_collider().is_in_group("pots"):
			var collision_point = ray_cast.get_collision_point()
			
			snapped_position = Vector3(snappedf(collision_point.x, 2.0), collision_point.y, snappedf(collision_point.z, 2.0))
			
			# If preview is not displayed yet
			if preview_instance == null:
				preview_instance = plant_pot_preview.instantiate()
				add_child(preview_instance)
			
			preview_instance.show()
			
			# Move it to the collision point
			preview_instance.global_transform.origin = snapped_position
			
			# Lock rotation
			var transform = preview_instance.global_transform
			transform.basis = Basis()
			preview_instance.global_transform = transform
			
			is_pot_placeable = true
			
			current_tooltip = "Place pot"
			player_tooltip.display_tooltip(current_tooltip, false)
		else:
			is_pot_placeable = false 
			
			# Hide the pot preview if not visible
			if preview_instance != null:
				preview_instance.hide()
	else:
		is_pot_placeable = false
		if preview_instance != null:
			preview_instance.hide()


func place_plant_pot() -> void:
	# Set to snapper position
	var new_pot = plant_pot_scene.instantiate()
	# Place object into Objects node
	placeable_objects.add_child(new_pot)
	
	new_pot.global_transform.origin = snapped_position
	new_pot.set_plant(currently_selected_plant)
	
	match(currently_selected_plant):
		0:
			plant_a_seeds -= 1
		1:
			plant_b_seeds -= 1
		2:
			plant_c_seeds -= 1
		3:
			plant_d_seeds -= 1
	
	# Remove pot rotation
	var transform = new_pot.global_transform
	transform.basis = Basis()
	preview_instance.global_transform = transform
	
	# Reset everything
	preview_instance.queue_free()
	preview_instance = null
	is_pot_placeable = false
	is_placing_plant = false


func try_to_collect_fruit() -> void:
	var collider = ray_cast.get_collider()
	if collider and collider.is_in_group("fruit_collision"):
		# Get parent of collider
		var fruit_node = collider.get_parent()
		if fruit_node.has_method("collect_fruit"):
			var result = fruit_node.collect_fruit()
			
			match(result):
				0:
					fruits_a += 1
					print("Fruits A: " + str(fruits_a))
				1:
					fruits_b += 1
				2:
					fruits_c += 1
				3:
					fruits_d += 1
			
			print("Collected fruit of type: " + str(result))


func try_to_access_computer() -> void:
	var collider = ray_cast.get_collider().name
	if collider == "ComputerBody":
		print("Trying to display computer")
		manage_ui.display_manage_ui()
		dismiss_tooltip()


func manage_tooltip(ray_object: Object, object_name: String) -> void:
	if ray_object == null or object_name == "nothing":
		dismiss_tooltip()
		return
	
	match(object_name):
		"FruitBody":
			if ray_object.get_parent().has_method("collect_fruit"):
				if ray_object.get_parent().is_collectable:
					current_tooltip = "Collect fruit"
					player_tooltip.display_tooltip(current_tooltip, false)
				else:
					current_tooltip = "Fruit is growing"
					player_tooltip.display_tooltip(current_tooltip, false)
		"ComputerBody":
			if not manage_ui.visible:
				current_tooltip = "E to access computer"
				player_tooltip.display_tooltip(current_tooltip, false)


func dismiss_tooltip() -> void:
	player_tooltip.dismiss_tooltip()
