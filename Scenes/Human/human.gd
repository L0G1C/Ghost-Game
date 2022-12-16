extends KinematicBody2D

onready var anim_player = $AnimationPlayer

func _ready():
	pass # Replace with function body.


func animate_walk():
	anim_player.play("Walk")

func animate_idle():
	anim_player.play("Idle")
