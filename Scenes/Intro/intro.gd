extends Node2D

func _ready():
	pass

func _process(delta):
	if (Input.is_action_just_pressed("jump")):
		$AnimationPlayer.stop()
		SceneLoader.load_scene("res://Scenes/Game/level-0/level-0.tscn")


func update_text(chapter):
	match (chapter):
		"closet":
			$CanvasLayer/PanelContainer/RichTextLabel.text = "See, little Ghosty? Look there, nothing to worry about. No humans here! Go to sleep now, little one..."


func _on_AnimationPlayer_animation_finished(anim_name):
	SceneLoader.load_scene("res://Scenes/Game/level-0/level-0.tscn")
