tool
extends Position2D
class_name Point


#==== wait time ====
export(float, -1, 2048, 0.25) var wait_time : float = -1 setget _set_wait_time


#==== setters ====
func _set_wait_time(value : float = -1) -> void:
	if value < 0.01:
		value = -1
	wait_time = value

