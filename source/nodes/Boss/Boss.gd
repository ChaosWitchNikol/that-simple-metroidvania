tool
extends KinematicBody2D
class_name Boss

#==== variables ====
#==== life ====
export(Array, Resource) var phases : Array = [] setget _set_phases
var target : Node setget set_target
var target_in_range : bool = false
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


#==== node functions ====
func _ready() -> void:
	print("==== boss: %s ====" % name)
	for ph in phases:
		print(U.object2string(ph, ["min_health_percent"]))
	phases = BossUtils.sort_phases(phases)
	for ph in phases:
		print(U.object2string(ph, ["min_health_percent"]))
	print("==== boss ====")



#==== getters ====
func get_current_phase() -> BossPhaseSrc:
	if phases.empty():
		return null
	
	return null
	


#==== setters ====
func _set_phases(array : Array) -> void:
	if U.in_editor() and not array.empty():
		for i in range(0, array.size()):
			if not array[i] or array[i].get_class() != C.ClassNames.BossPhaseSrc:
				array[i] = BossPhaseSrc.new()
				
	phases = array


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
	$View.position.x = abs($View.position.x) * facing
	$AttackRange.position.x = abs($AttackRange.position.x) * facing
	forward_vector = U.gravity_vector2forward_vector(gravity_vector, facing)





