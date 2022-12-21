extends Control


func _ready():
	SoundManager.play_music("intro")

func _on_Button_pressed():
	SceneLoader.load_scene("res://Scenes/MainMenu/MainMenu.tscn")
