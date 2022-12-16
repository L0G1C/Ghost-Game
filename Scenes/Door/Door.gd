extends StaticBody2D

export var tutorial_door = false
export var tool_tip_text : String
export(String, "spacebar") var tool_tip_icon
var tooltip = preload("res://Scenes/Game/Tooltip/Tooltip.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _process(delta):
	if (get_node_or_null("Tooltip")):
		$Tooltip.global_rotation = 0


func _on_Area2D_body_entered(body):
	if (body is Player && tutorial_door && get_node_or_null("Tooltip") == null):
		var phase_tooltip = tooltip.instance()
		phase_tooltip.tooltip_config(tool_tip_text, tool_tip_icon)
		phase_tooltip.visible = true
		phase_tooltip.position = Vector2(position.x - 30, position.y - 30)		
		add_child(phase_tooltip)		
		
func _on_Area2D_body_exited(body):
	if (body is Player && tutorial_door && get_node_or_null("Tooltip")):
		$Tooltip.fade()
		yield(get_tree().create_timer(0.6), "timeout")
		$Tooltip.queue_free()
