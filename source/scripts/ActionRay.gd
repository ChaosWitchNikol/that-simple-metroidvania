tool
extends Action
class_name ActionRay


#==== variables ====
export(float) var max_range : float = 0 
var position : Vector2 = Vector2() setget set_position
var cast_to : Vector2 = Vector2() setget set_cast_to
var target : Node2D
var parent : Node2D


#==== node functions ====
func _physics_process(delta: float) -> void:
	if target:
		self.position = parent.global_position
		self.cast_to = target.global_position - parent.global_position


#==== setters ====
func set_position(value : Vector2) -> void:
	position = value
	$Ray.position = position

func set_cast_to(value : Vector2) -> void:
	if max_range == 0.0:
		cast_to = value
	else:
		cast_to = value.normalized() * max_range
	$Ray.cast_to = cast_to
	