extends Camera2D

@onready var player: Player = $"../Player"

var shake_strength: float = 4.0
var speed_threshold: float = 300.0
var rng := RandomNumberGenerator.new()

func _ready() -> void:
	rng.randomize()

func _process(_delta: float) -> void:
	if player:
		var target_pos = player.global_position
		shake_strength = (player.velocity.x - 300) / 250
		if player.velocity.x > speed_threshold:
			var shake_offset = Vector2(
				rng.randf_range(-shake_strength, shake_strength),
				rng.randf_range(-shake_strength, shake_strength)
			)
			global_position.x = target_pos.x
			global_position.y = 0
			global_position += shake_offset
		else:
			global_position.x = target_pos.x
