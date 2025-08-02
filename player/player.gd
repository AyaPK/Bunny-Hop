class_name Player extends CharacterBody2D

enum DIRECTIONS {LEFT, RIGHT}

@onready var death_particles: GPUParticles2D = $DeathParticles
@onready var run_particles: GPUParticles2D = $RunParticles

var pressing: DIRECTIONS
var moving: DIRECTIONS
var sanitised_velocity: int
var accepting_input: bool = true

const BASE_SPEED = 100.0
const MAX_ACCELERATION = 800.0
const JUMP_VELOCITY = -400.0
const GROUND_FRICTION = 200
const AIR_ACCELERATION = 500.0
const SPEED_THRESHOLD = 100.0
const SLOW_ACCELERATION_FACTOR = 0.1

var jump_held = false
var camera: Camera2D
var playing_footsteps: bool = true

@onready var rich_text_label: RichTextLabel = $"../ui/RichTextLabel"
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sprite: Sprite2D = $Sprite2D
@onready var jump_particles: GPUParticles2D = $JumpParticles

var spawn_pos: Vector2

func _ready() -> void:
	spawn_pos = global_position
	sprite.scale.x = -1
	camera = get_viewport().get_camera_2d()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	if is_on_floor():
		jump_particles.emitting = false


	var jump_input = Input.is_action_pressed("jump")
	
	if jump_input and is_on_floor() and accepting_input:
		velocity.y = JUMP_VELOCITY
		jump_held = true
		AudioManager.jump.play()
		jump_particles.emitting = true
	elif not jump_input:
		jump_held = false

	var direction := Input.get_axis("left", "right")
	if !accepting_input:
		direction = 0
	
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
	
	
	emit_run_particles()
	move_and_slide()
	update_animation()
	sanitised_velocity = floor(abs(velocity.x/10))
	if rich_text_label:
		rich_text_label.text = " "+str(sanitised_velocity)


func update_animation() -> void:
	if velocity != Vector2.ZERO:
		animation_player.play("run")
		animation_player.speed_scale = velocity.x/100
	else:
		if animation_player.current_animation != "idle":
			animation_player.speed_scale = 1
			animation_player.play("idle")
	
	if !is_on_floor():
		animation_player.play("jump")
	
	if velocity.x > 0:
		sprite.scale.x = -1
	elif velocity.x < 0:
		sprite.scale.x = 1

func play_footstep() -> void:
	if playing_footsteps:
		AudioManager.footstep.play()

func emit_run_particles() -> void:
	#run_particles.speed_scale = velocity.x / 100
	if is_on_floor() and velocity.x >= 200:
		run_particles.emitting = true
	else:
		run_particles.emitting = false
