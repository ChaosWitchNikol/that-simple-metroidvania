extends KinematicBody2D
class_name MovingPlatform

#==== signals ====
signal moving_platform_arrived

export(NodePath) var path : NodePath
export(NodePath) var start_point : NodePath

#==== motion variables ====
var target_position : Vector2 = Vector2() 
var movement_speed : float = 200

#==== node functions ====
func _physics_process(delta: float) -> void:
	var direction : Vector2 = (target_position - position).normalized()
	var motion : Vector2 = direction * movement_speed * delta
	
	var motion_length = motion.length()
	# if motion length is 0 movement does not have to be proccessed
	# can be 0 when target_position and position are same
	# or when movement_speed is 0
	if motion_length == 0.0:
		return
	elif motion_length > position.distance_to(target_position):
		position = target_position
		emit_signal("moving_platform_arrived")
	else:
		position += motion


