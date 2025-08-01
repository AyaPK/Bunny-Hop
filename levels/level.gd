class_name Level extends Node2D

@export var level_no: int

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("a")
	Globals.level = level_no
	AudioManager.play_bgm()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
