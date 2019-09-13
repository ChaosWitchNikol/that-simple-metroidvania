tool
extends Sprite
class_name Door

export(C.FACING) var facing : int = C.FACING.RIGHT setget _set_facing
export(Color) var color_front : Color = Color("#FFFFFF") setget _set_color_front
export(Color) var color_back : Color = Color("#FFFFFF") setget _set_color_back






#==== setters ====
func _set_facing(value : int) -> void:
	facing = value
	var flip : bool = value == C.FACING.LEFT
	flip_h = flip
	$Back.flip_h = flip
	var direction : int = -1
	if flip:
		direction = 1
	$Back.position.x = abs($Back.position.x) * direction
	$Back/Body.position.x = abs($Back/Body.position.x) * direction


func _set_color_front(value : Color) -> void:
	color_front = value
	self_modulate = value


func _set_color_back(value : Color) -> void:
	color_back = value
	if not is_inside_tree():
		yield(self, "ready")
		_set_color_back(value)
		return
	$Back.self_modulate = value



#==== signals ====
func _on_Lock_area_entered(area: Area2D) -> void:
	print("player action entered")
