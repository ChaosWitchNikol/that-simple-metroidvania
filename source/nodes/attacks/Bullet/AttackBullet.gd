tool
extends Attack
class_name AttackBullet


#==== exports ====
export(float, -1024, 1024, 0.1) var movement_speed : float = 0
#==== variables ====
var direction : Vector2



#==== node functions ====
func _physics_process(delta: float) -> void:
	global_position += direction * movement_speed * delta



#==== functions ====
func fire_bullet(target_pos : Vector2, origin_pos : Vector2 = Vector2.ZERO, speed : float = 0) -> void:
	if origin_pos == Vector2.ZERO:
		origin_pos = _origin.global_position
	global_position = origin_pos
	direction = (target_pos - origin_pos).normalized()
	if speed != 0:
		movement_speed = speed
	



#==== signals ====
func _on_Bullet_body_entered(body: PhysicsBody2D) -> void:
	call_deferred("execute_on", body)
