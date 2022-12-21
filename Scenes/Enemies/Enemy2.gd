extends KinematicBody2D

signal player_spotted

onready var is_active = true
var reversed = false
var tween_values = [55, -55]

func _ready():
	start_tween()

func _physics_process(delta):
	if !is_active:
		$Tween.stop_all()

func _on_dialogue_pause():
	is_active = !is_active

func _on_SpotArea_body_entered(body):
	emit_signal("player_spotted", "daddy")
	
	
func start_tween():
		$Tween.interpolate_property(self, "rotation_degrees", tween_values[0], tween_values[1],3, Tween.TRANS_LINEAR)
		$Tween.start()

func _on_Tween_tween_completed(object, key):
		tween_values.invert()
		start_tween()
