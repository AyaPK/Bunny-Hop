class_name Flag extends Node2D

@export var speed_requirement: int
@onready var speed_indicator: RichTextLabel = $SpeedIndicator
@onready var ui: Ui = $"../ui"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	speed_indicator.text = str(speed_requirement)
	if speed_requirement == 0:
		speed_indicator.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Player) -> void:
	if body in get_tree().get_nodes_in_group("player"):
		if body.sanitised_velocity >= speed_requirement:
			AudioManager.level_complete.play()
			body.accepting_input = false
			ui.winbuttons.show()
			ui.complete.show()
			ui.nextbutton.grab_focus()
			if body.velocity.y < 0:
				body.velocity.y = 0
