tool
extends Sprite
class_name Door

export(C.FACING) var facing : int = C.FACING.RIGHT setget _set_facing
export(Color) var color_front : Color = Color("#FFFFFF") setget _set_color_front
export(Color) var color_back : Color = Color("#FFFFFF") setget _set_color_back
export(float, 0.01, 4096, 0.01) var lock_timeout : float = 0.5 setget _set_lock_timeout





#==== functions ====
func unlock() -> void:
	$Front/Collision.disabled = true
	$Lock/Collision.disabled = true
	self_modulate.a = 0


func relock() -> void:
	$Front/Collision.disabled = true
	$Lock/Collision.disabled = true
	self_modulate.a = 1



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
	$Lock.position.x = abs($Lock.position.x) * direction


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


func _set_lock_timeout(value : float) -> void:
	lock_timeout = value



#==== signals ====
func _on_Lock_area_entered(area: Area2D) -> void:
	call_deferred("unlock")


func _on_Lock_body_exited(body: PhysicsBody2D) -> void:
	$LockTimeout.call_deferred("start", lock_timeout)


func _on_LockTimeout_timeout() -> void:
	call_deferred("relock")
