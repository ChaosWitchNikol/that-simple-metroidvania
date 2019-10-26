extends Area2D
class_name CollectableContainer


signal collected

export(C.COLLECTABLE_TYPE) var type : int
export(Resource) var item : Resource
export(bool) var persist : bool = false

#==== node functions ====
func _ready() -> void:
	# subscribe to all currently existing CollectableHandler nodes
	for handler in get_tree().get_nodes_in_group(C.GROUP_COLLECTABLE_HANDLER):
		if not self.is_connected("collected", handler, "_on_CollectableContainer_collected"):
			self.connect("collected", handler, "_on_CollectableContainer_collected") 
	pass


#==== signals ====
func _on_CollectableContainer_body_entered(body: PhysicsBody2D) -> void:
	if body is Hero:
		emit_signal("collected", type, item)
		queue_free()
