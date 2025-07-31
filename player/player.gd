class_name Player extends CharacterBody2D

enum DIRECTIONS {LEFT, RIGHT}

var pressing: DIRECTIONS
var moving: DIRECTIONS
var sanitised_velocity: int

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
	camera = get_viewport().get_camera_2d()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var jump_input = Input.is_action_pressed("ui_accept")
	
	if jump_input and is_on_floor():
		velocity.y = JUMP_VELOCITY
		jump_held = true
	elif not jump_input:
		jump_held = false

	var direction := Input.get_axis("ui_left", "ui_right")
	
	if is_on_floor():
		var current_speed = abs(velocity.x)
		
		if direction:			
			if current_speed < SPEED_THRESHOLD:
				velocity.x += direction * MAX_ACCELERATION * delta
				velocity.x = clamp(velocity.x, -SPEED_THRESHOLD, SPEED_THRESHOLD)
			else:
				velocity.x = move_toward(velocity.x, direction * SPEED_THRESHOLD, 100 * delta)
		else:
			velocity.x = move_toward(velocity.x, 0, 1200 * delta)
		
	else:
		if direction:
			var current_speed = abs(velocity.x)
			var acceleration = AIR_ACCELERATION
			
			if current_speed > SPEED_THRESHOLD:
				acceleration *= SLOW_ACCELERATION_FACTOR
			
			velocity.x += direction * acceleration * delta
	
	if velocity.x > 0: 
		moving = DIRECTIONS.RIGHT
	elif velocity.x < 0:
		moving = DIRECTIONS.LEFT
	
	if direction:
		if direction > 0:
			pressing = DIRECTIONS.RIGHT
		elif direction < 0:
			pressing = DIRECTIONS.LEFT
	
	if direction and pressing != moving:
		velocity.x = move_toward(velocity.x, 0, 1200 * delta)
	
	move_and_slide()
	sanitised_velocity = floor(abs(velocity.x/10))
	rich_text_label.text = str(sanitised_velocity)
