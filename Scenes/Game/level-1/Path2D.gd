extends Path2D

onready var is_active = true
onready var path_follow = $PathFollow2D
onready var path_length = self.curve.get_baked_length()
onready var enemy = $PathFollow2D/Enemy as Enemy

var reversed = false

func _physics_process(delta):
	if !is_active:
		return
		
	if (!reversed):
		enemy.my_sprite.scale = Vector2(1,1)
		path_follow.offset += 70 * delta
		if (path_follow.offset >= (path_length - 30)):
			reversed = true
	elif (reversed):
		enemy.my_sprite.scale = Vector2(-1,1)
		path_follow.offset -= 70 * delta
		if (path_follow.offset <= 30):
			reversed = false
			
func _on_dialogue_pause():
	is_active = !is_active
