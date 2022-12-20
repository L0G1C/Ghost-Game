extends Node

var key_stream = load("res://Resources/Audio/pickup.wav")
var door_open = load("res://Resources/Audio/door_open.wav")

var game_music = load("res://Resources/Audio/game-music.wav")

onready var sfx_player = $SFXPlayer
onready var music_player = $MusicPlayer

func _ready():
	pass # Replace with function body.

func play_music(name):
	match name:
		"game":
			music_player.stream = game_music
			music_player.play()

func play_sfx(name):
	match name:
		"key":
			sfx_player.stream = key_stream
			sfx_player.play()
		"door_open":
			sfx_player.stream = door_open
			sfx_player.play()
