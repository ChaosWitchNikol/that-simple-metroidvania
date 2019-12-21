extends Node
class_name U


#==== editor ====
static func in_editor() -> bool:
	return Engine.editor_hint




#==== vectors ====
static func no_negative_zero_vector2(src : Vector2) -> Vector2:
	if src.x == -0:
		src.x = 0
	if src.y == -0:
		src.y = 0
	return src


static func gravity_direction2vector(gravity_direction : int) -> Vector2:
	if gravity_direction < 0 or gravity_direction >= C.GRAVITY_VECTOR_SET.size():
		return C.GRAVITY_VECTOR
	return C.GRAVITY_VECTOR_SET[gravity_direction]


static func gravity_vector2forward_vector(gravity_vector : Vector2, facing : int) -> Vector2:
	return no_negative_zero_vector2(gravity_vector.rotated(-(PI / 2) * facing).round())



#==== timers ====
static func setup_timer(timer_node : Timer, wait_time : float ) -> void:
	if wait_time == -1:
		timer_node.queue_free()
	else:
		timer_node.wait_time = wait_time
		timer_node.start()






#==== to dictionary ====
static func object2dict(obj : Object, keys : Array = []) -> Dictionary:
	var props : Dictionary = {}
	
	for prop in obj.get_property_list():
		if keys and keys.size() > 0:
			if prop.name in keys:
				props[prop.name] = obj.get(prop.name)
		else:
			props[prop.name] = obj.get(prop.name)
			
	return props


static func object2string(obj : Object, keys : Array = []) -> String:
	return to_json(object2dict(obj, keys))


static func node2dict(node : Node, keys : Array = []) -> Dictionary:
	return object2dict(node, keys)


static func node2string(node : Node, keys : Array = []) -> String:	
	return to_json(node2dict(node, keys))



#==== groups ====
static func add_node_to_groups(node : Node, groups : Array = [], persistent : bool = false) -> void:
	if not groups or groups.empty():
		return
	
	for group in groups:
		node.add_to_group(group, persistent)

