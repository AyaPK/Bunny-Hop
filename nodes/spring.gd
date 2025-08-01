extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Player) -> void:
	if body in get_tree().get_nodes_in_group("player"):
		body.velocity.y -= 600
		if body.velocity.y < -600:
			body.velocity.y = -600
		animation_player.play("sprung")
		AudioManager.spring.play()
		await animation_player.animation_finished
		animation_player.play("idle")
	pass # Replace with function body.
