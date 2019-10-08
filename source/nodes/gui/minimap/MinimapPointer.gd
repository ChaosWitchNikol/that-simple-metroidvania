extends Sprite


var follow : Node2D
var nscale : float

func _enter_tree() -> void:
	set_process(false)
#func _ready() -> void:
#	set_process(false)


func _process(delta: float) -> void:
	global_position = follow.global_position / nscale
	



#==== functions ====
func setup(follow_node : Node2D, n_scale : float = 1, color: Color = "#FFFFFF") -> void:
	follow = follow_node
	nscale = n_scale
	scale /= n_scale
	self_modulate = color
	set_process(true)