extends Node

@onready var bgm: AudioStreamPlayer2D = $BGM
@onready var menu_music: AudioStreamPlayer2D = $MenuMusic
@onready var footstep: AudioStreamPlayer2D = $Footstep
@onready var jump: AudioStreamPlayer2D = $Jump
@onready var level_complete: AudioStreamPlayer2D = $LevelComplete
@onready var spring: AudioStreamPlayer2D = $Spring
@onready var death: AudioStreamPlayer2D = $Death

func play_bgm() -> void:
	if !bgm.playing:
		bgm.play()
