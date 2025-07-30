class_name Player extends CharacterBody2D


const BASE_SPEED = 100.0
const MAX_ACCELERATION = 800.0
const JUMP_VELOCITY = -400.0
const GROUND_FRICTION = 200
const AIR_ACCELERATION = 500.0
const SPEED_THRESHOLD = 100.0
const SLOW_ACCELERATION_FACTOR = 0.1

var jump_held = false
var camera: Camera2D

@onready var rich_text_label: RichTextLabel = $"../CanvasLayer/RichTextLabel"

func _ready() -> void:
	# Find the camera in the scene
	camera = get_viewport().get_camera_2d()

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump - bhop style (hold to jump on landing)
	var jump_input = Input.is_action_pressed("ui_accept")
	
	if jump_input and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_held = true
	elif not jump_input:
		jump_held = false

	# Get the input direction
	var direction := Input.get_axis("ui_left", "ui_right")
	
	# Bhop movement mechanics
	if is_on_floor():
		# Ground movement - capped at 200 speed and decays toward 200
		var current_speed = abs(velocity.x)
		
		if direction:
			# Only accelerate if under the speed threshold
			if current_speed < SPEED_THRESHOLD:
				velocity.x += direction * MAX_ACCELERATION * delta
				# Clamp to speed threshold
				velocity.x = clamp(velocity.x, -SPEED_THRESHOLD, SPEED_THRESHOLD)
			else:
				# If above threshold, just maintain direction but decay toward threshold
				velocity.x = move_toward(velocity.x, direction * SPEED_THRESHOLD, 100 * delta)
		else:
			# Apply friction when no input - decay toward 0
			velocity.x = move_toward(velocity.x, 0, 1200 * delta)
		
		## Always decay speed toward threshold if above it
		#if current_speed > SPEED_THRESHOLD:
			#var target_velocity = sign(velocity.x) * SPEED_THRESHOLD
			#velocity.x = move_toward(velocity.x, target_velocity, 600 * delta)
	else:
		# Air movement - allows for air strafing and speed building
		if direction:
			var current_speed = abs(velocity.x)
			var acceleration = AIR_ACCELERATION
			
			# Reduce acceleration if moving very fast
			if current_speed > SPEED_THRESHOLD:
				acceleration *= SLOW_ACCELERATION_FACTOR
			
			# Air strafing - allow direction changes but with physics that feel good
			velocity.x += direction * acceleration * delta

	move_and_slide()
	rich_text_label.text = str(int(velocity.x)).substr(0, len(str(int(velocity.x)))-1)
