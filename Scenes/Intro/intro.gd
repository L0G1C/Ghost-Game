extends Node2D

onready var anim_player = $AnimationPlayer

func _ready():
	pass

func _process(delta):
	pass


func update_text(chapter):
	match (chapter):
		"closet":
			$CanvasLayer/PanelContainer/RichTextLabel.text = "See, little Ghosty? Look there, nothing to worry about. No humans here! Go to sleep now, little one..."
