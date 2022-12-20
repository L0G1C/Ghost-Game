extends Node2D

func _ready():
	# queue music
	SoundManager.play_music("game")
	
	# signal connects
	$Key.connect("key_picked_up", $CanvasLayer/PhaseBar, "on_player_add_key")
	$Player.connect("phase", $CanvasLayer/PhaseBar, "on_phase_cooldown")
	$Player.connect("cooldown_tick", $CanvasLayer/PhaseBar, "on_cooldown_tick")
	$Navigation2D/Human.connect("player_giving_human_key", $CanvasLayer/PhaseBar, "on_human_add_key")
	$Door1.connect("door_unlocked", self, "door_unlocked")
	$CanvasLayer/PhaseBar.connect("human_key_added", $Navigation2D/Human, "_on_key_added")
	$CanvasLayer/PhaseBar.connect("human_key_added", $Door1 , "_unlock_on_human_key_add")
	connect("dialogue_pause", $Player, "_on_dialogue_pause")
	connect("dialogue_pause", $Navigation2D, "_on_activate")
	emit_signal("dialogue_pause")
