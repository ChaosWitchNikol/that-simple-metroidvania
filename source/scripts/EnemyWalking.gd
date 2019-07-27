tool
extends Enemy
class_name EnemyWalking

#==== processors ====
# @override
func _process_movement(delta: float, on_floor) -> void:
	if on_floor:
		if not can_move_forward():
			set_facing(facing * -1)
		move_forward(delta)



#==== functions ====
func move_forward(delta: float) -> void:
	linear_velocity = forward_vector * movement_speed * delta * C.TILE_SIZEF


#==== computers ====
func can_move_forward() -> bool:
	return not (test_move(global_transform, forward_vector) or not test_move(global_transform.translated(gravity_vector * C.TILE_SIZEF ), forward_vector * C.HALF_TILE_SIZEF))