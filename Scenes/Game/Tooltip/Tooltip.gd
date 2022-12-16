extends Node2D

onready var tween = $Tween

# Called when the node enters the scene tree for the first time.
func _ready():
	tween.interpolate_property(self, "modulate",  Color(1, 1, 1, 0), Color(1, 1, 1, 1), 0.56, 
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()


func tooltip_config(text, icon):
	$Background/Text.text = text
	
	match (icon):
		"spacebar":
			$Background/Icon.animation = "spacebar"

func fade():
	tween.interpolate_property(self, "modulate",  Color(1, 1, 1, 1), Color(1, 1, 1, 0), 0.56, 
		Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
