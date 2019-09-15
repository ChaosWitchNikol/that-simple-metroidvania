tool
extends Sprite
class_name DoorOld

export(C.FACING) var facing : int = C.FACING.RIGHT setget _set_facing
export(Color) var color_front : Color = Color("#FFFFFF") setget _set_color_front
export(Color) var color_back : Color = Color("#FFFFFF") setget _set_color_back
export(float, 0.01, 4096, 0.01) var lock_timeout : float = 0.5 setget _set_lock_timeout

export(NodePath) var unlock_target_door : NodePath
var is_target : bool = false




#==== functions ====
func unlock() -> void:
	$Front/Collision.disabled = true
	self_modulate.a = 0


func relock() -> void:
	$Front/Collision.disabled = false
	self_modulate.a = 255





func unlock_target() -> void:
	if not unlock_target_door:
		return
	get_node(unlock_target_door).set_as_target()
	get_node(unlock_target_door).unlock()


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


func set_as_target() -> void:
	is_target = true


#==== signals ====
func _on_Lock_area_entered(area: Area2D) -> void:
	call_deferred("unlock")
	$LockTimeout.call_deferred("start", lock_timeout)


func _on_Lock_body_exited(body: PhysicsBody2D) -> void:
	$LockTimeout.call_deferred("start", lock_timeout)
	if not is_target:
		call_deferred("unlock_target")
	is_target = false

func _on_Lock_body_entered(body: PhysicsBody2D) -> void:
	if not $LockTimeout.is_stopped():
		$LockTimeout.call_deferred("stop")


func _on_LockTimeout_timeout() -> void:
	call_deferred("relock")
