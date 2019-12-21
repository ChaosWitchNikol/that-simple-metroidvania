extends CPUParticles2D

# Declare member variables here. Examples:
# var a: int = 2
# var b: String = "text"
export(NodePath) var trigger_path : NodePath

var time = 0

func _ready() -> void:
	if trigger_path:
		var trigger = get_node(trigger_path)
		trigger.connect("triggered", self, "_on_Trigger_triggered")


func _process(delta: float) -> void:
	if time > 0:
		time -= delta
		if time - delta <= 0:
			emitting = false


func _on_Trigger_triggered(trigger : Trigger) -> void:
	emitting = true
	time = lifetime / speed_scale