class_name WrapAround extends Node2D

@onready var camera_2d: Camera2D = $"../Camera2D"

enum SIDES {RIGHT, LEFT, TOP, BOTTOM}

@export var target: WrapAround
@export var side: SIDES

var can_transition: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_area_2d_body_entered(body: Node2D) -> void:
	if !can_transition:
		return
	if body in get_tree().get_nodes_in_group("player"):
		target.can_transition = false
		if side == SIDES.RIGHT or side == SIDES.LEFT:
			body.global_position.x = target.global_position.x
		elif side == SIDES.TOP or side == SIDES.BOTTOM:
			body.global_position.y = target.global_position.y

func _on_visible_on_screen_notifier_2d_screen_entered() -> void:
	if side == SIDES.LEFT:
		camera_2d.limit_left = global_position.x
	elif side == SIDES.RIGHT:
		camera_2d.limit_right = global_position.x


func _on_area_2d_body_exited(body: Node2D) -> void:
	if body in get_tree().get_nodes_in_group("player"):
		can_transition = true
