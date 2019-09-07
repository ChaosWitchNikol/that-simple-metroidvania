tool
extends KinematicBody2D
class_name Enemy


#==== variables ====
#==== life ====
export(bool) var is_passive : bool = false
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
#==== attack ====
export(Array, PackedScene) var attack_scenes : Array
export(float, -1, 1024, 0.1) var attack_timeout : float = 0.1 setget _set_attack_timeout
var attack_index : int = -1

#==== utils ====
var sm : float = 1.1 + get("collision/safe_margin") 
var _process_gravity : bool = true setget set_process_gravity
var _can_process_movement : bool = true setget set_process_movement
var _pixel_snap : bool = false setget set_pixel_snap


#==== node functions ====
func _ready() -> void:
	if U.in_editor():
		set_physics_process(false)
		return
	print(">> ", name)
	


func _physics_process(delta: float) -> void:
	var on_floor := is_on_floor()
	
	# process gravity
	if _process_gravity and not on_floor:
		linear_velocity += gravity_vector * gravity_value * mass * delta
	
	# process movement
	if _can_process_movement:
		_process_movement(delta, on_floor)
	
	# finally move
	linear_velocity = move_and_slide_with_snap(linear_velocity, snap_vector, floor_vector)
	
	# pixel perfect snap correction	
	if _pixel_snap and on_floor:
		position = position.round()


#==== processors ====
func _process_movement(delta : float, on_floor : bool) -> void:
	pass


#==== functions ====
func attack() -> void:
	if target_in_range:
		$AttackHandler.emit_attack(target)



#==== computers ====
func can_attack(attack_index : int) -> bool:
	return attack_scenes.size() > 0 and attack_index >= 0 and attack_index < attack_scenes.size()



#==== setters ====
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


func _set_attack_timeout(value : float) -> void:
	if value < 0.01:
		value = -1
	attack_timeout = value


func set_process_gravity(value : bool) -> void:
	_process_gravity = value


func set_process_movement(value : bool) -> void:
	_can_process_movement = value


func set_pixel_snap(value : bool) -> void:
	_pixel_snap = value


#==== signals ====
func _on_View_body_entered(body: PhysicsBody2D) -> void:
	if body and not is_passive:
		call_deferred("set_target", body)


func _on_AttackRange_body_entered(body: PhysicsBody2D) -> void:
	if body == target:
		target_in_range = true
		$AnimPlayer.call_deferred("play", "attack")


func _on_AttackRange_body_exited(body: PhysicsBody2D) -> void:
	if body == target:
		target_in_range = false
		

func _on_AttackHandler_cooled_down() -> void:
	$AnimPlayer.call_deferred("play", "attack")



