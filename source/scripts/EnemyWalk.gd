extends EnemyBase_old
class_name EnemyWalk_old

#==== custom processors ====
#= @override =
func process_movement(delta : float) -> void:
	if is_on_floor():
		if not target:
			if not can_move_forward():
				flip_facing()
			move_forward(delta)
		else:
			if global_position.distance_squared_to(target.position) > 0.0:
				pass
			pass
		

#==== custom functions ====
func can_move_forward() -> bool:
	return not (test_move(global_transform, forward_vector) or not test_move(global_transform.translated(gravity_vector * C.TILE_SIZEF ), forward_vector * C.HALF_TILE_SIZEF))

func move_forward(delta : float) -> void:
	linear_velocity = forward_vector * movement_speed * delta * C.TILE_SIZEF