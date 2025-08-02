extends Node2D

@onready var start_game: Button = $MainMenuButtons/VBoxContainer/StartGame
@onready var level_select_buttons: VBoxContainer = $LevelSelectButtons
@onready var main_menu_buttons: HBoxContainer = $MainMenuButtons
@onready var player: Player = $Player
@onready var _1: Button = $"LevelSelectButtons/LevelSelectButtonsRowOne/1"
@onready var bunny: Sprite2D = $Bunny
@onready var hop: Sprite2D = $Hop

func _ready() -> void:
	$ui.hide()
	start_game.grab_focus()
	AudioManager.menu_music.play()
	AudioManager.footstep.volume_db = 0.0
	player.accepting_input = false
	player.playing_footsteps = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	player.velocity.x = 300

func _on_settings_pressed() -> void:
	if player.is_on_floor():
		player.velocity.y = -300

func _on_start_game_pressed() -> void:
	AudioManager.menu_music.stop()
	get_tree().change_scene_to_file("res://levels/level_1.tscn")

func _on_level_select_pressed() -> void:
	if player.is_on_floor():
		player.velocity.y = -300
	main_menu_buttons.hide()
	level_select_buttons.show()
	bunny.hide()
	hop.hide()
	_1.grab_focus()

func _on_back_pressed() -> void:
	if player.is_on_floor():
		player.velocity.y = -300
	main_menu_buttons.show()
	level_select_buttons.hide()
	hop.show()
	bunny.show()
	start_game.grab_focus()
	
