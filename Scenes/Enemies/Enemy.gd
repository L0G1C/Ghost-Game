extends KinematicBody2D
class_name Enemy

signal player_spotted

var tooltip = preload("res://Scenes/Game/Tooltip/Tooltip.tscn")

onready var my_sprite : AnimatedSprite = $AnimatedSprite


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


# warning-ignore:unused_argument
func _on_SpotArea_body_entered(body):
	emit_signal("player_spotted")
