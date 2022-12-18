extends Node2D

onready var anim_player = $AnimationPlayer

func _ready():
	pass

func _process(delta):
	pass


func update_text(chapter):
	match (chapter):
		"closet":
			$CanvasLayer/PanelContainer/RichTextLabel.text = "See, little Ghosty? Look there, nothing to worry about. Now you have a good night and we'll haunt again tomorrow!"
