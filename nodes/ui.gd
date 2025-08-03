class_name Ui extends CanvasLayer

@onready var complete: RichTextLabel = $complete
@onready var winbuttons: HBoxContainer = $winbuttons
@onready var nextbutton: Button = $winbuttons/nextbutton
@onready var retrybutton: Button = $winbuttons/retrybutton
@onready var pausebuttons: HBoxContainer = $pausebuttons
@onready var restartbutton: Button = $pausebuttons/restartbutton
@onready var paused: RichTextLabel = $paused

var is_paused: bool = false
var is_in_level: bool = true

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Pause") and is_in_level:
		if !is_paused:
			pausebuttons.show()
			get_tree().get_nodes_in_group("player")[0].process_mode = Node.PROCESS_MODE_DISABLED
			is_paused = true
			restartbutton.grab_focus()
			AudioManager.bgm.stream_paused = true
			paused.show()
		else:
			pausebuttons.hide()
			get_tree().get_nodes_in_group("player")[0].process_mode = Node.PROCESS_MODE_ALWAYS
			is_paused = false
			AudioManager.bgm.stream_paused = false
			paused.hide()

func _on_nextbutton_pressed() -> void:
	if Globals.level == 15:
		AudioManager.bgm.stop()
		Globals.complete = true
		get_tree().change_scene_to_file("res://menu/main_menu.tscn")
	else:
		Globals.level += 1
		get_tree().change_scene_to_file("res://levels/level_"+str(Globals.level)+".tscn")

func _on_retrybutton_pressed() -> void:
	get_tree().reload_current_scene()

func _on_restartbutton_pressed() -> void:
	AudioManager.bgm.stream_paused = false
	get_tree().reload_current_scene()

func _on_quitbutton_pressed() -> void:
	get_tree().change_scene_to_file("res://menu/main_menu.tscn")
	AudioManager.bgm.stop()
