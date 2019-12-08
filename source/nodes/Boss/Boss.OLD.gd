tool
extends KinematicBody2D
class_name Boss

#==== variables ====
#==== life ====
export(float, 1, 9999, 0.01) var max_health : float = 1 
var health : float = 1 setget _set_health
var health_percent : float = 1
export(Array, Resource) var phases : Array = [] setget _set_phases
var current_phase_src : BossPhaseSrc
var current_phase_node : Node
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


#==== node functions ====
func _ready() -> void:
	if U.in_editor():
		return
	
	health = max_health # set up health
	phases = BossUtils.sort_phases(phases) # order phases by health percentage asc
	update_current_phase()
	print(phases, current_phase_src)
	


func _physics_process(delta: float) -> void:
	pass


#==== functions ====
func update_current_phase() -> void:
	var new_phase_src : BossPhaseSrc = get_phase_by_health_percent(health_percent)
	
	if new_phase_src == current_phase_src:
		return
	
	current_phase_src = new_phase_src
	
	if current_phase_node:
		current_phase_node.queue_free()
		yield(current_phase_node, "tree_exited")
	
	if current_phase_src.handler_scene:
		current_phase_node = current_phase_src.handler_scene.instance()
		add_child(current_phase_node)
	
		


#==== getters ====
func get_phase_by_health_percent(health_percent : float) -> BossPhaseSrc:
	if phases.empty():
		return null
	var current_phase : BossPhaseSrc = phases[0]
	for phase in phases:
		if health_percent <= phase.start_at_health_percent :
			current_phase = phase
	return current_phase
	


#==== setters ====
func _set_health(value : float) -> void:
	health = value
	health_percent = ((max_health / 100) * health) / 100
	update_current_phase()


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
#	$View.position.x = abs($View.position.x) * facing
#	$AttackRange.position.x = abs($AttackRange.position.x) * facing
	forward_vector = U.gravity_vector2forward_vector(gravity_vector, facing)





