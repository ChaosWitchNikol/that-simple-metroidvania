extends Object
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
