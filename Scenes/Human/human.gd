extends KinematicBody2D
class_name Human

signal player_giving_human_key
export var tutorial = false

onready var anim_player = $AnimationPlayer
var key_collection = {}
var tooltip_scene = preload("res://Scenes/Game/Tooltip/Tooltip.tscn")

func _ready():
	pass # Replace with function body.

# warning-ignore:unused_argument
func _process(delta):
	pass
	if (tutorial && get_node_or_null("Tooltip")):
		if (get_node_or_null("Tooltip") == null):
			return
			
		$Tooltip.fade()
		
		yield(get_tree().create_timer(0.6), "timeout")
		
		if (get_node_or_null("Tooltip") == null):
			return
			
		$Tooltip.queue_free()
		
	if ($KeyArea.get_overlapping_bodies().size() > 0 && Input.is_action_pressed("interact")):
		SoundManager.play_sfx("give_key")
		emit_signal("player_giving_human_key")
		
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
		
		if (get_node_or_null("Tooltip") == null):
			return
		$Tooltip.queue_free()

func _on_key_added(key_color):
	print("adding key %s" % key_color)	
	key_collection[key_color] = 1
	print(key_collection)

func door_unlocked(key_color):
	print("Erasing %s" % key_color)
	if(key_collection[key_color] != null):
		key_collection.erase(key_color)
	print(key_collection)
