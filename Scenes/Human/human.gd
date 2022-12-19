extends KinematicBody2D
class_name Human

export var tutorial = false

onready var anim_player = $AnimationPlayer
var tooltip_scene = preload("res://Scenes/Game/Tooltip/Tooltip.tscn")

func _ready():
	pass # Replace with function body.


func animate_walk():
	anim_player.play("Walk")

func animate_idle():
	anim_player.play("Idle")


func _on_TutorialArea_body_entered(body):
	if (!body is Player || !(body as Player).key_collection.has("Intro")):
		return
		
	if (tutorial):
		var tooltip = tooltip_scene.instance()
		tooltip.tooltip_config("Give Human key.", "e_btn")
		tooltip.visible = true
		tooltip.position = Vector2(position.x - 30, position.y - 30)		
		add_child(tooltip)


func _on_TutorialArea_body_exited(body):
	if (!body is Player || !(body as Player).key_collection.has("Intro")):
		return
			
	if (body is Player && tutorial && get_node_or_null("Tooltip")):
		$Tooltip.fade()
		yield(get_tree().create_timer(0.6), "timeout")
		$Tooltip.queue_free()
