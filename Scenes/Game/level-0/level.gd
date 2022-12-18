extends Node2D

signal dialogue_pause

var key_dialog_complete = false
var level_complete = false


func _ready():
	# warning-ignore:return_value_discarded
	$Player.connect("phase", $CanvasLayer/PhaseBar, "on_phase_cooldown")
	# warning-ignore:return_value_discarded
	$Player.connect("cooldown_tick", $CanvasLayer/PhaseBar, "on_cooldown_tick")
	$Door.connect("door_unlocked", self, "door_unlocked")
	# warning-ignore:return_value_discarded
	connect("dialogue_pause", $Player, "_on_dialogue_pause")
	# warning-ignore:return_value_discarded
	connect("dialogue_pause", $Navigation2D, "_on_activate")
	emit_signal("dialogue_pause")
	
	var new_dialog = Dialogic.start("/Intro")
	new_dialog.connect("dialogic_signal", self, "dialog_listener")
	add_child(new_dialog)

func door_unlocked(door_name):
	if (door_name == "Intro"):
		level_complete = true
		$Navigation2D/Navmesh.enabled = false
		$Navigation2D/Navmesh_unlocked.enabled = true

func dialog_listener(string):	
	match (string):
		"intro_complete":
			emit_signal("dialogue_pause")
		"intro-post-phase":	
			var door = $Door as Door
			door.tool_tip_text = "You need a key"
			door.tool_tip_icon = "key"
			$DialogueTrigger.queue_free()
			emit_signal("dialogue_pause")


func _on_DialogueTrigger_body_entered(body):
	if (!body is Player) || key_dialog_complete:
		return
		
	key_dialog_complete = true
	emit_signal("dialogue_pause")
	$Player.Velocity = Vector2.ZERO
	$Player/Sprite.flip_h = true
	var new_dialog = Dialogic.start("/Intro-post-phase")
	new_dialog.connect("dialogic_signal", self, "dialog_listener")
	add_child(new_dialog)


func _on_ExitTrigger_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if (!level_complete):
		return
	else:
		SceneLoader.load_scene("res://Scenes/Game/level-1/level-1.tscn")
