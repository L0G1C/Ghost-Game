extends Navigation2D

export(float) var character_speed = 400.0
export(NodePath) var playerPath
var path = []

onready var is_active = true
onready var character = $Human
onready var player

func _ready():
	player = get_node(playerPath)

func _process(delta):
	var walk_distance = character_speed * delta
	move_along_path(walk_distance)

# warning-ignore:unused_argument
func _unhandled_input(event):
	if !is_active:
		return
	
	_update_navigation_path(character.position, Vector2(player.position.x - 40, player.position.y - 35))


func move_along_path(distance):
	var last_point = character.position
	while path.size():
		var distance_between_points = last_point.distance_to(path[0])
		# The position to move to falls between two points.
		if distance <= distance_between_points:
			character.position = last_point.linear_interpolate(path[0], distance / distance_between_points)
			return
		# The position is past the end of the segment.
		distance -= distance_between_points
		last_point = path[0]
		path.remove(0)
	# The character reached the end of the path.
	character.position = last_point
	character.animate_idle()


func _update_navigation_path(start_position, end_position):
	# get_simple_path is part of the Navigation2D class.
	# It returns a PoolVector2Array of points that lead you
	# from the start_position to the end_position.
	path = get_simple_path(start_position, end_position, true)
	# The first point is always the start_position.
	# We don't need it in this example as it corresponds to the character's position.
	path.remove(0)
	character.animate_walk()

func _on_activate():	
	is_active = !is_active
