extends EnemyBase
class_name EnemyFly


	

#==== custom processors ====
#= @override =
func process_gravity(delta : float) -> void:
	pass
#= @override =
func process_movement(delta : float) -> void:
	if target:
		var direction : Vector2 = (target.position - global_position).normalized()
		linear_velocity = direction * delta * movement_speed * C.TILE_SIZE
	pass
