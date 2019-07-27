tool
extends Enemy
class_name EnemyCrawling

#==== constants ====
enum RotationType { INNER = -1, OUTER = 1, NONE = 0 }
const PI_HALF : float = PI / 2


#==== node functions ====
func _ready() -> void:
	set_pixel_snap(true)	
	next_vectors()


#==== processors ====
# @override
func _process_movement(delta : float, on_floor : bool) -> void:
	if on_floor:
		# test for wall ahead of enemy
		# do inner circle rotation
		if test_move(transform, forward_vector):
			linear_velocity = Vector2()
			position += gravity_vector
			next_vectors(RotationType.INNER)
			return
		# test for gap ahead of enemy
		# do outer circle rotation
		elif not test_move(transform.translated(forward_vector * sm), gravity_vector):
			linear_velocity = Vector2()
			position += forward_vector + gravity_vector
			next_vectors(RotationType.OUTER)
			return
		
		linear_velocity = forward_vector * movement_speed * delta * C.TILE_SIZEF


#==== functions ====
func next_vectors(rotation_type : int = RotationType.NONE) -> void:
	# calculate new gravity vector
	var next_gavity_vector : Vector2 = gravity_vector.rotated(PI_HALF * facing * rotation_type)
	gravity_vector = U.no_negative_zero_vector2(next_gavity_vector)
	
	# calculate all movement related vectors
	forward_vector = U.no_negative_zero_vector2(next_gavity_vector.rotated(-PI_HALF * facing))
	snap_vector = gravity_vector * C.SNAP_VECTOR.length()
	floor_vector = -gravity_vector
	
	# rotate Sprite, ArrackRange, View accordingly
	var new_rotation_degrees = round(rad2deg(forward_vector.angle()))
	if facing == C.FACING.LEFT:
		new_rotation_degrees += 180
	_set_node_rotation($Sprite, new_rotation_degrees)
	_set_node_rotation($AttackRange, new_rotation_degrees)
	_set_node_rotation($View, new_rotation_degrees)


#==== setters ====
func _set_node_rotation(node: Node2D, new_rotation_degrees: float) -> void:
	var position_length = node.position.length()
	if position_length > 0.0:
		node.position = forward_vector * position_length
	node.rotation_degrees = new_rotation_degrees
