extends EnemyBaseOld
class_name EnemyWalkOld


func _ready() -> void:
	forward_vector = Vector2(facing, 0)

func process_movement(delta : float) -> void:
	if is_on_floor():
		if not target:
			if not test_move(transform.translated(gravity_vector * C.TILE_SIZEF ), forward_vector * C.HALF_TILE_SIZEF) or test_move(transform, forward_vector):
				flip_facing()
			linear_velocity = forward_vector * src.movement_speed * delta * C.TILE_SIZEF
