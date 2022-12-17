extends Area2D


export(Texture) var texture
export(String) var door_name

func _ready():
	$Sprite.texture = texture


func _on_Key_body_entered(body):
	if (body is Player):
		var player = body as Player
		player.key_collection[door_name] = 1
		queue_free()
