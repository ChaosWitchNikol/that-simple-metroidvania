tool
extends Action
class_name ActionRegion


#==== exports ====
#	when movement speed == 0 the movement will not be processed
export(float, 0, 4096, 0.5) var movement_speed : float = 0
#==== variables ====
var position : Vector2 = Vector2() setget set_position
var direction : Vector2 = Vector2() setget set_direction


#==== node functions ====
func _physics_process(delta: float) -> void:
	if movement_speed > 0.0:
		self.position += direction * movement_speed * delta


#==== functions ====
func fire_attack(origin_position : Vector2, target_position : Vector2) -> void:
	self.position = origin_position
	self.direction = origin_position - target_position


#==== setters ====
func set_position(value: Vector2) -> void:
	position = value
	$Region.position = position

func set_direction(value : Vector2) -> void:
	direction = value.normalized()
 

#==== signals ====
func _on_Region_body_entered(body: PhysicsBody2D) -> void:
	call_deferred("set_process", false)
	call_deferred("apply_effects", body)
	print(body.name)

func _on_RemoveTimeout_timeout() -> void:
	call_deferred("queue_free")
