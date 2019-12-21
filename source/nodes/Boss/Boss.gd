tool
extends KinematicBody2D
class_name Boss

#==== variables ====
#==== life ====
export(float, 1, 9999, 0.01) var max_health : float = 1 
var health : float = 1 setget _set_health
var health_percent : float = 1
var target : Node setget set_target
#==== gravity ====
export(float) var gravity_value : float = C.GRAVITY_VALUE
export(float) var mass : float = 100
var gravity_vector : Vector2 = C.GRAVITY_VECTOR setget set_gravity_vector
#==== movement ====
export(float) var movement_speed : float = 300
export(C.FACING) var facing : int = C.FACING.RIGHT setget set_facing
var linear_velocity : Vector2 = Vector2()
var forward_vector : Vector2 = Vector2()
var snap_vector : Vector2 = C.SNAP_VECTOR
var floor_vector : Vector2 = C.FLOOR_VECTOR







#==== setters ====
func _set_health(value : float) -> void:
	health = value
	health_percent = ((max_health / 100) * health) / 100




func set_target(value : Node2D) -> void:
	target = value


func set_gravity_vector(value : Vector2) -> void:
	gravity_vector = value.normalized()
	snap_vector = gravity_vector * C.SNAP_VECTOR.length()
	floor_vector = -gravity_vector
	forward_vector = U.gravity_vector2forward_vector(gravity_vector, facing)


func set_facing(value : int) -> void:
	facing = value
	$Sprite.flip_h = facing == C.FACING.LEFT
#	$View.position.x = abs($View.position.x) * facing
#	$AttackRange.position.x = abs($AttackRange.position.x) * facing
	forward_vector = U.gravity_vector2forward_vector(gravity_vector, facing)


