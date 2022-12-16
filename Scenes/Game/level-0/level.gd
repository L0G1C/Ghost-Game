extends Node2D

signal dialogue_pause


func _ready():
	$Player.connect("phase", $CanvasLayer/PhaseBar, "on_phase_cooldown")
	$Player.connect("cooldown_tick", $CanvasLayer/PhaseBar, "on_cooldown_tick")
	connect("dialogue_pause", $Player, "_on_dialogue_pause")
	connect("dialogue_pause", $Navigation2D, "_on_activate")
	emit_signal("dialogue_pause")
	
	var new_dialog = Dialogic.start("/Intro")
	new_dialog.connect("dialogic_signal", self, "dialog_listener")
	add_child(new_dialog)


func dialog_listener(string):
	match string:
		"intro_complete":
			emit_signal("dialogue_pause")
		"intro_post_phase":
			var door = $Door as Door
			door.tool_tip_text = "You need a key"
			door.tool_tip_icon = "key"
			emit_signal("dialogue_pause")



func _on_DialogueTrigger_area_entered(area):
	emit_signal("dialogue_pause")
	
	var new_dialog = Dialogic.start("/Intro-post-phase")
	new_dialog.connect("dialogic_signal", self, "dialog_listener")
	add_child(new_dialog)
