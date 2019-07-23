extends EnemyBase_old
class_name EnemyCrawl_old

enum RotationType { INNER = -1, OUTER = 1, NONE = 0}
const PI_HALF : float = PI / 2

#==== node function ====
func _ready() -> void:
	next_vectors()


#==== custom processors ====
#= @override =
func process_movement(delta : float) -> void:
	if is_on_floor():
		# test for wall ahead of enemy
		# do inner circle rotation
		if test_move(global_transform, forward_vector):
			linear_velocity = Vector2()
			position += gravity_vector
			next_vectors(RotationType.INNER)
			return
		# test for gap ahead of enemy
		# do outer circle rotation
		elif not test_move(global_transform.translated(forward_vector * save_margin), gravity_vector):
			linear_velocity = Vector2()
			position += forward_vector + gravity_vector
			next_vectors(RotationType.OUTER)
			return
		
		linear_velocity = forward_vector * movement_speed * delta * C.TILE_SIZEF
#==== custom functions ====
func next_vectors(rotation_type : int = RotationType.NONE) -> void:
	# calculate new gravity vector
	var next_gavity_vector : Vector2 = gravity_vector.rotated(PI_HALF * facing * rotation_type)
	gravity_vector = U.no_negative_zero_vector2(next_gavity_vector)
	
	# calculate all movement related vectors
	forward_vector = U.no_negative_zero_vector2(next_gavity_vector.rotated(-PI_HALF * facing))	
	snap_vector = gravity_vector * C.SNAP_VECTOR.length()
	floor_vector = -gravity_vector
	
	# rotate EnemySprite accordingly
	get_node("EnemySprite").rotation_degrees = round(rad2deg(forward_vector.angle()))
