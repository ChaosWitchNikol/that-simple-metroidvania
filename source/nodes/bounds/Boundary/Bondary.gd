extends Area2D
class_name Boundary

var bounds : Dictionary = {}


#==== functions ====
func assemble(origin_position : Vector2, bounds : Dictionary, collision_rect_extents : Vector2) -> void:
	print(bounds, collision_rect_extents)
	self.bounds = bounds
	global_position = origin_position
	var new_shape : RectangleShape2D = $Collision.shape.duplicate()
	new_shape.extents = collision_rect_extents
	$Collision.shape = new_shape




#==== getters ====
func get_limits() -> Dictionary:
	return {
		"limit_left": bounds.left,
		"limit_top": bounds.top,
		"limit_right": bounds.right,
		"limits_bottom": bounds.bot
	}
	
