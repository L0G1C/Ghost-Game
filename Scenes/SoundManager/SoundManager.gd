extends Node

var key_stream = load("res://Resources/Audio/pickup.wav")
var door_open = load("res://Resources/Audio/door_open.wav")
var door_shut = load("res://Resources/Audio/door_shut.wav")
var key_give = load("res://Resources/Audio/key_give.wav")
var phase = load("res://Resources/Audio/phase.wav")
var phase_cooldown = load("res://Resources/Audio/phase_cd.wav")

var intro_music = load("res://Resources/Audio/intro-music.wav")
var game_music = load("res://Resources/Audio/game-music.wav")
var spotted_music = load("res://Resources/Audio/spotted-music.wav")

onready var sfx_player = $SFXPlayer
onready var music_player = $MusicPlayer
var playing_music = false

func _ready():
	pass # Replace with function body.

func play_music(name):
	match name:
		"intro":
			music_player.stream = intro_music
			music_player.play(33.8)
			playing_music = false
		"game":
			music_player.stream = game_music
			music_player.play()
			playing_music = true
		"spotted_music":
			music_player.stream = spotted_music
			music_player.play()
			playing_music = false
			
func play_sfx(name):
	match name:
		"key":
			sfx_player.stream = key_stream
			sfx_player.play()
		"door_open":
			sfx_player.stream = door_open
			sfx_player.play()
		"door_shut":
			sfx_player.stream = door_shut
			sfx_player.play()
		"give_key":
			sfx_player.stream = key_give
			sfx_player.play()
		"phase":
			sfx_player.stream = phase
			sfx_player.play()
		"phase_cooldown":
			sfx_player.stream = phase_cooldown
			sfx_player.play()

func stop():
	music_player.stop()
