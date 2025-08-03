extends Node2D

const DEATH_PARTICLES = preload("res://nodes/death_particles.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_area_2d_body_entered(body: Player) -> void:
	if body in get_tree().get_nodes_in_group("player") and body.accepting_input:
		body.sprite.hide()
		body.accepting_input = false
		AudioManager.death.play()
		
		var death = DEATH_PARTICLES.instantiate()
		get_parent().add_child(death)
		death.global_position = body.global_position
		death.emitting = true
		
		await get_tree().create_timer(0.3).timeout
		body.accepting_input = true
		body.sprite.show()
		body.global_position = body.spawn_pos
		await death.finished
		death.queue_free()
