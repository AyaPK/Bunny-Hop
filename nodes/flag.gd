class_name Flag extends Node2D

@export var speed_requirement: int
@onready var speed_indicator: RichTextLabel = $SpeedIndicator

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed_indicator.text = str(speed_requirement)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Player) -> void:
	if body in get_tree().get_nodes_in_group("player"):
		if body.sanitised_velocity >= speed_requirement:
			print("player finished!")
		else:
			print("more speed needed")
