extends HandlerNode




#==== node funcitons ====
func _ready() -> void:
	# connect all CollectableContainer nodes in case they are already not connected
	for container in get_tree().get_nodes_in_group(C.GROUP_COLLECTABLE_CONTAINER):
		if not container.is_connected("collected", self, "_on_CollectableContainer_collected"):
			container.connect("collected", self, "_on_CollectableContainer_collected")
			





#==== signals ====
func _on_CollectableContainer_collected(type : int, item : Resource) -> void:
	print(type, item)
	pass