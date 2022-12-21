extends Area2D

signal key_picked_up

export(Texture) var texture
export(String, "yellow", "blue", "red") var key_color

var yellow = load("res://Resources/Art/yellow-key.png")
var red = load("res://Resources/Art/red-key.png")
var blue = load("res://Resources/Art/blue-key.png")

func _ready():
	match key_color:
		"yellow":
			$Sprite.texture = yellow
		"red":
			$Sprite.texture = red
		"blue":
			$Sprite.texture = blue


func _on_Key_body_entered(body):
	if (body is Player):
		SoundManager.play_sfx("key")
		var player = body as Player
		player.key_collection[key_color] = 1
		emit_signal("key_picked_up", key_color)
		queue_free()		
