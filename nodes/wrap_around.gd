class_name WrapAround extends Node2D

@onready var camera_2d: Camera2D = $"../Camera2D"

enum DIRECTIONS {HORIZONAL, VERTICAL}
enum SIDES {RIGHT, LEFT, TOP, BOTTOM}

@export var target: WrapAround
@export var direction: DIRECTIONS
@export var side: SIDES

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if body in get_tree().get_nodes_in_group("player"):
		body.global_position.x = target.global_position.x + 25

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	if side == SIDES.LEFT:
		camera_2d.limit_left = global_position.x
	elif side == SIDES.RIGHT:
		camera_2d.limit_right = global_position.x
