extends Path2D


onready var path_follow = $PathFollow2D
onready var path_length = self.curve.get_baked_length()
onready var enemy = $PathFollow2D/Enemy as Enemy
var reversed = false

func _physics_process(delta):
	if (!reversed):
		path_follow.offset += 70 * delta
		if (path_follow.offset >= (path_length - 30)):
			reversed = true
	elif (reversed):
		enemy.my_sprite.flip_h = true
		path_follow.offset -= 70 * delta
		if (path_follow.offset <= 30):
			reversed = false
