tool
extends KinematicBody2D
class_name Enemy


#==== variables ====
#==== life ====
export(bool) var is_passive : bool = false
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
#==== attack ====
export(PackedScene) var attack_scene : PackedScene
export(Array, PackedScene) var attack_scenes : Array
var attack_index : int = -1

#==== utils ====
var sm : float = 1.1 + get("collision/safe_margin") 
var _process_gravity : bool = true setget set_process_gravity
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
#	create request for attack
func call_attack(index : int = 0, target : Node = null) -> void:
	if not can_attack(index):
		return
	if target:
		self.target = target
	attack_index = index
	$AnimPlayer.play("attack")

func execute_attack() -> void:
	var attack_instance := (attack_scenes[attack_index] as PackedScene).instance()
	attack_instance.position = $AttackRange.global_position
	get_parent().add_child(attack_instance)
	if attack_instance is ActionRegion:
		attack_instance.fire_attack($AttackRange.global_position, target.position)
		print("is action region")


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

func set_process_gravity(value : bool) -> void:
	_process_gravity = value

func set_pixel_snap(value : bool) -> void:
	_pixel_snap = value


#==== signals ====
func _on_View_body_entered(body: PhysicsBody2D) -> void:
	if body and not is_passive:
		call_deferred("set_target", body)

func _on_AttackRange_body_entered(body: PhysicsBody2D) -> void:
	print("call_attack", name, " ", target)
	call_attack()
	pass # Replace with function body.
