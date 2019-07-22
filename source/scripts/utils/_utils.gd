extends Node
class_name U

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

#==== editor ====
static func in_editor() -> bool:
	return Engine.editor_hint




#==== pathway ====
static func get_pathway_points(pathway : Pathway) -> Array:
	var points : Array = []
	
	if not pathway:
		return points
	
	for child in pathway.get_children():
		if child is PathwayPoint:
			points.append(child)
	
	return points

static func get_next_pathway_point(pathway : Pathway, current_point : PathwayPoint) -> PathwayPoint:
	var points : Array = get_pathway_points(pathway)
	
	if points.size() == 0:
		return null
	
	var index : int = points.find(current_point)
	
	if index == -1:
		return points[0]
	
	return points[(index + 1) % points.size()]


