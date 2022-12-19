extends Node2D

onready var audioplayer = $AudioStreamPlayer
onready var tween_out = $Tween

export var transition_duration = 1.00
export var transition_type = 1 # TRANS_SINE

func _ready():
	pass

func _process(delta):
	if (Input.is_action_just_pressed("jump")):
		$AnimationPlayer.stop()
		SceneLoader.load_scene("res://Scenes/Game/level-0/level-0.tscn")


func update_text(chapter):
	match (chapter):
		"closet":
			$CanvasLayer/PanelContainer/RichTextLabel.text = "See, little Ghosty? Look there, nothing to worry about. No humans here! Go to sleep now, little one..."

func fade_out(stream_player):
	var stream_player_object = get_node(stream_player)
	# tween music volume down to 0
	tween_out.interpolate_property(stream_player_object, "volume_db", 0, -80, transition_duration, transition_type, Tween.EASE_IN, 0)
	tween_out.start()
	# when the tween ends, the music will be stopped

func _on_TweenOut_tween_completed(object, key):
	# stop the music -- otherwise it continues to run at silent volume
	object.stop()
	object.volume_db = 0 # reset volume
	
func _on_AnimationPlayer_animation_finished(anim_name):
	SceneLoader.load_scene("res://Scenes/Game/level-0/level-0.tscn")
