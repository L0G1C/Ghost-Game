extends Node2D

signal dialogue_pause

var key_dialog_complete = false
var level_complete = false
var tween_values = [0.0, 20.0]
var shake_complete = false

func _ready():
	# queue music
	SoundManager.play_music("game")
	
	# signal connects
	$Key.connect("key_picked_up", $CanvasLayer/MarginContainer/PhaseBar, "on_player_add_key")
	$Player.connect("phase", $CanvasLayer/MarginContainer/PhaseBar, "on_phase_cooldown")
	$Player.connect("cooldown_tick", $CanvasLayer/MarginContainer/PhaseBar, "on_cooldown_tick")
	$Player.connect("shake_phase_bar", self , "_on_shake_phase_bar")
	$Navigation2D/Human.connect("player_giving_human_key", $CanvasLayer/MarginContainer/PhaseBar, "on_human_add_key")
	$Door1.connect("door_unlocked", self, "door_unlocked")
	$CanvasLayer/MarginContainer/PhaseBar.connect("human_key_added", $Navigation2D/Human, "_on_key_added")
	$CanvasLayer/MarginContainer/PhaseBar.connect("human_key_added", $Door1 , "_unlock_on_human_key_add")
	connect("dialogue_pause", $Player, "_on_dialogue_pause")
	connect("dialogue_pause", $Navigation2D, "_on_activate")
	emit_signal("dialogue_pause")
	
	var new_dialog = Dialogic.start("/Intro")
	new_dialog.connect("dialogic_signal", self, "dialog_listener")
	add_child(new_dialog)

func door_unlocked(door_color):
	if (door_color == "yellow"):
		level_complete = true
		$Navigation2D/Navmesh.enabled = false
		$Navigation2D/Navmesh_unlocked.enabled = true

func dialog_listener(string):	
	match (string):
		"intro_complete":
			emit_signal("dialogue_pause")
		"intro-post-phase":	
			var door = $Door1 as Door
			door.tutorial_door = false
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

func _on_shake_phase_bar():
	start_tween()

func start_tween():
	$Tween.interpolate_property($CanvasLayer, "offset:y", tween_values[0], tween_values[1], 0.055)
	$Tween.interpolate_property($CanvasLayer, "offset:x", tween_values[0], tween_values[1], 0.055)
	$Tween.start()

func _on_Tween_tween_completed(object, key):
	if(!shake_complete):
		tween_values.invert()
		start_tween()
		shake_complete = true
