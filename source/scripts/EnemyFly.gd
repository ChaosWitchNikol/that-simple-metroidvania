extends EnemyBase_old
class_name EnemyFly_old


	

#==== custom processors ====
#= @override =
func process_gravity(delta : float) -> void:
	pass
#= @override =
func process_movement(delta : float) -> void:
	if target:
		var direction : Vector2 = (target.position - global_position).normalized()
		linear_velocity = direction * delta * movement_speed * C.TILE_SIZE
		
		if linear_velocity.length() > 0:
			if linear_velocity.x > 0:
				set_facing(C.FACING.RIGHT)
			if linear_velocity.x < 0:
				set_facing(C.FACING.LEFT)
	

