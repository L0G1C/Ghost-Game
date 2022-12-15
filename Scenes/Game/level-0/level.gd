extends Node2D

signal dialogue_pause


func _ready():
	$Player.connect("phase", $CanvasLayer/PhaseBar, "on_phase_cooldown")
	$Player.connect("cooldown_tick", $CanvasLayer/PhaseBar, "on_cooldown_tick")
	connect("dialogue_pause", $Player, "_on_dialogue_pause")
	emit_signal("dialogue_pause")
	
	var new_dialog = Dialogic.start("/Intro")
	new_dialog.connect("dialogic_signal", self, "dialog_listener")
	add_child(new_dialog)


func dialog_listener(string):
	match string:
		"intro_complete":
			emit_signal("dialogue_pause")

