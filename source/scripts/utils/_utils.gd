extends Object
class_name U

static func no_negative_zero_vector2(src : Vector2) -> Vector2:
	if src.x == -0:
		src.x = 0
	if src.y == -0:
		src.y = 0
	return src