class_name VerticalWrap extends Node2D

enum SIDES {TOP, BOTTOM}

@export var target: VerticalWrap
@export var side: SIDES

var can_transition: bool = true

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Node2D) -> void:
	if !can_transition:
		return
	if body in get_tree().get_nodes_in_group("player"):
		target.can_transition = false
		body.global_position.y = target.global_position.y
