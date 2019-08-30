tool
extends Enemy
class_name EnemyFlying


#==== node functions ====
# @override
func _ready() -> void:
	set_process_gravity(false)


#==== processors ====
func _process_movement(delta: float, on_floor: bool) -> void:
	if target:
		var direction : Vector2 = (target.global_position - global_position).normalized()
		linear_velocity = direction * delta * movement_speed * C.TILE_SIZEF
		$AttackRange.position = direction * $AttackRange.position.length()
		if linear_velocity.length() > 0:
			if linear_velocity.x > 0:
				set_facing(C.FACING.RIGHT)
			elif linear_velocity.x < 0:
				set_facing(C.FACING.LEFT)