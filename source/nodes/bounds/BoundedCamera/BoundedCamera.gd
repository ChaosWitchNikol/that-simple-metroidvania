extends Camera2D




var boundaries : Array = []




#==== functions ====
func set_current_limits() -> void:
	var boundary : Boundary = _get_current_boundary()
	if boundary:
		_set_limits(boundary.get_limits())

func reset_limits() -> void:
	limit_left = -10000000	
	limit_top = -10000000
	limit_right = 10000000
	limit_bottom = 10000000


#==== getters ====
func _get_current_boundary() -> Boundary:
	if boundaries.empty():
		return null
	return boundaries[0]


#==== setters ====
func _set_limits(limits : Dictionary) -> void:
	print(limits)
	limit_left = limits.limit_left
	limit_top = limits.limit_top
	limit_right = limits.limit_right
	limit_bottom = limits.limit_bottom


#==== singals ====
func _on_Center_area_entered(area: Area2D) -> void:
	if area is Boundary:
		boundaries.push_front(area as Boundary)
		call_deferred("set_current_limits")


func _on_Center_area_exited(area: Area2D) -> void:
	if area is Boundary and area in boundaries and boundaries.size() > 1:
		boundaries.erase(area)
