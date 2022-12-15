class_name Player
extends KinematicBody2D


var Velocity = Vector2.ZERO
var ghost_state = false;
var ghost_state_timer = 6;
var ghost_state_tick = 0;
const ACCELERATION = 550
const MAX_SPEED = 200;
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
		
		if (inputVector.x < 0):
			$Sprite.flip_h = true
		elif (inputVector.x >= 0):
			$Sprite.flip_h = false

	else:
		Velocity = Velocity.move_toward(Vector2.ZERO, FRICTION * delta)
		_animState.travel("Idle")
		
	Velocity = move_and_slide(Velocity)

	if (Input.is_action_just_pressed("jump")):		
		ghost_state = true
		
	if (ghost_state && ghost_state_tick < ghost_state_timer):		
		ghost_state_tick += delta * 10
		$Sprite.modulate.a = 0.5
		set_collision_mask(6)
		set_collision_layer(6)
	elif (ghost_state && ghost_state_tick >= ghost_state_timer):
		ghost_state = false
		$Sprite.modulate.a = 1
		ghost_state_tick = 0
		set_collision_mask(5)
		set_collision_layer(5)

func get_state():
	return ghost_state
