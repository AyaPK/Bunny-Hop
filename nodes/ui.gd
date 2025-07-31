class_name Ui extends CanvasLayer

@onready var complete: RichTextLabel = $complete
@onready var nextbutton: Button = $nextbutton

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _on_nextbutton_pressed() -> void:
	Globals.level += 1
	get_tree().change_scene_to_file("res://levels/level_"+str(Globals.level)+".tscn")
