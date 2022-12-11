extends KinematicBody2D

var Velocity = Vector2.ZERO
const ACCELERATION = 450
const MAX_SPEED = 100;
const FRICTION = 450;

onready var _animTree = $AnimationTree
onready var _animState = _animTree.get("parameters/playback")

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	var inputVector = Vector2.ZERO
	inputVector.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
	inputVector.y = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
	inputVector = inputVector.normalized()
	
	if (inputVector != Vector2.ZERO):
		_animState.travel("Walk")
		Velocity = Velocity.move_toward(inputVector * MAX_SPEED, ACCELERATION * delta)
		
		if (inputVector == Vector2.LEFT):
			$Sprite.flip_h = true
		elif (inputVector == Vector2.RIGHT):
			$Sprite.flip_h = false

	else:
		Velocity = Velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		_animState.travel("Idle")
		
	Velocity = move_and_slide(Velocity)

