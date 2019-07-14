extends EnemyBase
class_name EnemyWalk

#==== custom processors ====
#= @override =
func process_movement(delta : float) -> void:
	if is_on_floor():
		if not target:
			if test_move(global_transform, forward_vector) or not test_move(global_transform.translated(gravity_vector * C.TILE_SIZEF ), forward_vector * C.HALF_TILE_SIZEF):
				flip_facing()
			linear_velocity = forward_vector * movement_speed * delta * C.TILE_SIZEF