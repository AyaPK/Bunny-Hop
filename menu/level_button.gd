extends Button

func _ready() -> void:
	pass

func _process(_delta: float) -> void:
	pass

func _pressed() -> void:
		AudioManager.menu_music.stop()
		get_tree().change_scene_to_file("res://levels/level_"+text+".tscn")
