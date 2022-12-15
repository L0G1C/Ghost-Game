extends Control

onready var cooldown_bar = $MainBar
onready var flash_bar = $FlashBar
onready var tween = $Tween


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
