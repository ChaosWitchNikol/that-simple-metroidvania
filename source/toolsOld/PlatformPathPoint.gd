tool
extends Position2D
class_name TPlatformPathPoint

#==== export variables ====
# when wait time is set to zero, default wait time from platform path will be used instead
export(float) var wait_time : float = -1 setget _set_wait_time


#==== setters ====
func _set_wait_time(value : float = -1) -> void:
	if value < 0.01:
		value = -1
	
	wait_time = value
