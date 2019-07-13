extends EnemyBaseOld
class_name EnemyFlyOld



var next_position : Vector2 = Vector2()

#	flying enemy does not need gravity :D
func process_gravity(delta : float, do_process : bool = true) -> void:
	pass

func process_movement(delta : float) -> void:
	if target:
		linear_velocity = forward_vector * src.movement_speed * delta * C.TILE_SIZEF


