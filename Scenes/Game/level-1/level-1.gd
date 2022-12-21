extends Node2D

signal dialogue_pause

var level_complete = false
var tween_values = [0.0, 20.0]
var shake_complete = false

var current_scene = "res://Scenes/Game/level-1/level-1.tscn"

func _ready():
	if (!SoundManager.playing_music):
		SoundManager.play_music("game")
		
	# signal connects
# warning-ignore:return_value_discarded
	$Key.connect("key_picked_up", $CanvasLayer/MarginContainer/PhaseBar, "on_player_add_key")
# warning-ignore:return_value_discarded
	$Key2.connect("key_picked_up", $CanvasLayer/MarginContainer/PhaseBar, "on_player_add_key")
# warning-ignore:return_value_discarded
	$Player.connect("phase", $CanvasLayer/MarginContainer/PhaseBar, "on_phase_cooldown")
# warning-ignore:return_value_discarded
	$Player.connect("cooldown_tick", $CanvasLayer/MarginContainer/PhaseBar, "on_cooldown_tick")
# warning-ignore:return_value_discarded
	$Player.connect("shake_phase_bar", self , "_on_shake_phase_bar")
# warning-ignore:return_value_discarded
	$Navigation2D/Human.connect("player_giving_human_key", $CanvasLayer/MarginContainer/PhaseBar, "on_human_add_key")
# warning-ignore:return_value_discarded
	$Door1.connect("door_unlocked", self, "door_unlocked")
	$Door1.connect("door_unlocked", $Navigation2D/Human, "door_unlocked")
# warning-ignore:return_value_discarded
	$Door2.connect("door_unlocked", self, "door_unlocked")
	$Door2.connect("door_unlocked", $Navigation2D/Human, "door_unlocked")
# warning-ignore:return_value_discarded
	$CanvasLayer/MarginContainer/PhaseBar.connect("human_key_added", $Navigation2D/Human, "_on_key_added")
# warning-ignore:return_value_discarded
	$CanvasLayer/MarginContainer/PhaseBar.connect("human_key_added", $Door1 , "_unlock_on_human_key_add")
# warning-ignore:return_value_discarded
	$CanvasLayer/MarginContainer/PhaseBar.connect("human_key_added", $Door2 , "_unlock_on_human_key_add")
# warning-ignore:return_value_discarded
	connect("dialogue_pause", $Player, "_on_dialogue_pause")
# warning-ignore:return_value_discarded
	connect("dialogue_pause", $Navigation2D, "_on_dialogue_pause")
# warning-ignore:return_value_discarded
	connect("dialogue_pause", $Path2D, "_on_dialogue_pause")
# warning-ignore:return_value_discarded
	connect("dialogue_pause", $Enemy2, "_on_dialogue_pause")
# warning-ignore:return_value_discarded
	$Path2D/PathFollow2D/Enemy.connect("player_spotted", self, "dialog_player_spotted")
# warning-ignore:return_value_discarded
	$Enemy2.connect("player_spotted", self, "dialog_player_spotted")
	
func door_unlocked(door_color):	
	if (door_color == "yellow"):
		$Navigation2D/Navmesh.enabled = false
		$Navigation2D/Navmesh_unlocked.enabled = true
	if (door_color == "blue"):
		level_complete = true
		$Navigation2D/Navmesh_unlocked.enabled = false
		$Navigation2D/Navmesh_unlocked2.enabled = true
		
func dialog_player_spotted(character):
	emit_signal("dialogue_pause")
	SoundManager.play_music("spotted_music")
	
	var new_dialog = Dialogic.start("/Spotted")
	if (character == "mommy"):
		Dialogic.set_variable("Spotter", "Mommy")
	elif(character == "daddy"):
		Dialogic.set_variable("Spotter", "Daddy")
	new_dialog.connect("dialogic_signal", self, "dialog_listener")
	add_child(new_dialog)
	
func dialog_listener(string):	
	match (string):
		"spot_complete":
			SceneLoader.load_scene(current_scene)
			#get_tree().reload_current_scene()

func get_spotting_enemy():
	return "test"

func _on_shake_phase_bar():
	start_tween()

func start_tween():
	$Tween.interpolate_property($CanvasLayer, "offset:y", tween_values[0], tween_values[1], 1.0)
	$Tween.interpolate_property($CanvasLayer, "offset:x", tween_values[0], tween_values[1], 0.055)
	$Tween.start()

# warning-ignore:unused_argument
# warning-ignore:unused_argument
func _on_Tween_tween_completed(object, key):
	if(!shake_complete):
		tween_values.invert()
		start_tween()
		shake_complete = true


func _on_ExitTrigger_body_entered(body):
	if (!level_complete):
		return
	else:
		SceneLoader.load_scene("res://Scenes/GameOver/GameOver.tscn")
