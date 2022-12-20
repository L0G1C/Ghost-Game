extends Control

onready var cooldown_bar = $VBoxContainer/Container/MainBar
onready var flash_bar = $VBoxContainer/Container/FlashBar
onready var tween = $VBoxContainer/Container/Tween
onready var key_container = $VBoxContainer/MarginContainer/HBoxContainer

onready var yellow_key = $VBoxContainer/MarginContainer/HBoxContainer/YellowKey
onready var blue_key = $VBoxContainer/MarginContainer/HBoxContainer/BlueKey
onready var red_key = $VBoxContainer/MarginContainer/HBoxContainer/RedKey

var current_shake_priority = 0

signal human_key_added

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
func _process(_delta):
	pass

func on_phase_cooldown():
	cooldown_bar.value = 0
	tween.interpolate_property(flash_bar, "value", flash_bar.value, 0, 0.3, Tween.TRANS_LINEAR, Tween.EASE_IN)
	tween.start()
	
func on_cooldown_tick(value):
	cooldown_bar.value += value
	flash_bar.value += value

func on_player_add_key(key_color):
	var text_rect = TextureRect.new()
	match key_color:
		"yellow":
			yellow_key.show()
		"red":
			red_key.show()
		"blue":
			blue_key.show()
			
func on_human_add_key():	
	if(yellow_key.visible == true):
		emit_signal("human_key_added", "yellow")
		yellow_key.hide()
	if(red_key.visible == true):
		emit_signal("human_key_added", "red")
		red_key.hide()
	if(blue_key.visible == true):
		emit_signal("human_key_added", "blue")
		blue_key.hide()
