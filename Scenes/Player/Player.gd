class_name Player
extends KinematicBody2D


var Velocity = Vector2.ZERO
var ghost_state = false;
var ghost_state_timer = 6;
var ghost_state_tick = 0;
var cooldown_time = 4;
var cooldown_time_tick = 0;
var on_cooldown = false;
var dialogue_pause = false;
const ACCELERATION = 550
const MAX_SPEED = 200;
const FRICTION = 450;

signal phase
signal cooldown_tick

onready var _animTree = $AnimationTree
onready var _cooldownTimer = $CooldownTimer
onready var _animState = _animTree.get("parameters/playback")

func _ready():
	pass

func _physics_process(delta):
	if (dialogue_pause):
		return
		
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
		if (on_cooldown):
			print("on cooldown!")
			return
			
		on_cooldown = true
		ghost_state = true
		_cooldownTimer.start()
		emit_signal("phase")
		
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


func _on_CooldownTimer_timeout():	
	if (on_cooldown && cooldown_time_tick < cooldown_time):
		cooldown_time_tick += 0.5
		emit_signal("cooldown_tick", 0.5)
		_cooldownTimer.start()
	elif (cooldown_time_tick >= cooldown_time):
		cooldown_time_tick = 0
		on_cooldown = false
		
func _on_dialogue_pause():
	dialogue_pause = !dialogue_pause
