extends KinematicBody2D
class_name Enemy

var tooltip = preload("res://Scenes/Game/Tooltip/Tooltip.tscn")

onready var my_sprite : AnimatedSprite = $AnimatedSprite


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
