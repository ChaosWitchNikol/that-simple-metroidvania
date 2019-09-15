tool
extends Area2D
class_name Door

export(bool) var flip_h : bool = false setget _set_flip_h
export(NodePath) var teleport_path : NodePath


var teleport : Teleport


#==== node functions ====
func _ready() -> void:
	if U.in_editor():
		return
	
	if teleport_path:
		teleport = get_node(teleport_path)
	
	if teleport:
#		teleport.connect("teleport_exited", self, "_on_teleport_teleport_exited")
		teleport.connect("is_being_exited", self, "_on_teleport_is_being_exited")
	



#==== functions ====
func unlock() -> void:
	$FrontBody/Collision.disabled = true
	$FrontSprite.visible = false
	$ReLockTimeout.start()


func relock() -> void:
	$FrontBody/Collision.disabled = false
	$FrontSprite.visible = true




#==== setters ====
func _set_flip_h(value :  bool) -> void:
	flip_h = value
	$FrontSprite.flip_h = value
	$BackSprite.flip_h = value
	
	var direction = -1
	if flip_h:
		direction = 1
	$BackSprite.position.x = abs($BackSprite.position.x) * direction
	$BackBody.position.x = abs($BackBody.position.x) * direction




#==== signals =====
#func _on_teleport_teleport_exited(teleport : Teleport) -> void:
#	print(U.node2string(teleport, ["name", "global_position"]))

func _on_teleport_is_being_exited() -> void:
	call_deferred("unlock")



func _on_Door_area_entered(area: Area2D) -> void:
	call_deferred("unlock")


func _on_Door_body_exited(body: PhysicsBody2D) -> void:
	call_deferred("unlock")


func _on_Door_body_entered(body: PhysicsBody2D) -> void:
	$ReLockTimeout.call_deferred("stop")


func _on_ReLockTimeout_timeout() -> void:
	call_deferred("relock")
