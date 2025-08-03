extends Node2D

@onready var start_game: Button = $MainMenuButtons/VBoxContainer/StartGame
@onready var level_select_buttons: VBoxContainer = $LevelSelectButtons
@onready var main_menu_buttons: HBoxContainer = $MainMenuButtons
@onready var player: Player = $Player
@onready var _1: Button = $"LevelSelectButtons/LevelSelectButtonsRowOne/1"
@onready var bunny: Sprite2D = $Bunny
@onready var hop: Sprite2D = $Hop
@onready var ui: Ui = $ui
@onready var music_check_box: CheckBox = $Settings/VBoxContainer/HBoxContainer/MusicCheckBox
@onready var settings: PanelContainer = $Settings
@onready var settings_button: Button = $MainMenuButtons/VBoxContainer2/Settings
@onready var credits: PanelContainer = $Credits
@onready var settings_back: Button = $Settings/VBoxContainer/HBoxContainer3/SettingsBack
@onready var credits_back: Button = $Credits/VBoxContainer/CreditsBack


func _ready() -> void:
	$ui.hide()
	start_game.grab_focus()
	AudioManager.menu_music.play()
	AudioManager.footstep.volume_db = 0.0
	player.accepting_input = false
	player.playing_footsteps = false
	ui.is_in_level = false


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	player.velocity.x = 300

func _on_settings_pressed() -> void:
	if player.is_on_floor():
		player.velocity.y = -300
	main_menu_buttons.hide()
	bunny.hide()
	hop.hide()
	settings.show()
	settings_back.grab_focus()

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

func _on_music_check_box_toggled(toggled_on: bool) -> void:
	if player.is_on_floor():
		player.velocity.y = -300
	AudioServer.set_bus_mute(1, toggled_on)

func _on_sfx_check_box_toggled(toggled_on: bool) -> void:
	if player.is_on_floor():
		player.velocity.y = -300
	AudioServer.set_bus_mute(2, toggled_on)

func _on_settings_back_pressed() -> void:
	if player.is_on_floor():
		player.velocity.y = -300
	settings.hide()
	hop.show()
	bunny.show()
	main_menu_buttons.show()
	start_game.grab_focus()

func _on_credits_pressed() -> void:
	if player.is_on_floor():
		player.velocity.y = -300
	main_menu_buttons.hide()
	credits.show()
	bunny.hide()
	hop.hide()
	credits_back.grab_focus()

func _on_credits_back_pressed() -> void:
	if player.is_on_floor():
		player.velocity.y = -300
	credits.hide()
	hop.show()
	bunny.show()
	main_menu_buttons.show()
	start_game.grab_focus()
