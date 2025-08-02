extends Node2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _ready() -> void:
	pass # Replace with function body.


func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Player) -> void:
	if body in get_tree().get_nodes_in_group("player"):
		body.velocity.y -= 250
		body.velocity.x = -body.velocity.x

		animation_player.play("sprung")
		AudioManager.spring.play()
		await animation_player.animation_finished
		animation_player.play("idle")
