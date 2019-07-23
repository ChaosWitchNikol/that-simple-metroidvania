"""
	In test_move() function always use global_transform
	transform is relative to the EnemySpawner parent node
"""
extends KinematicBody2D
class_name EnemyBase_old

#==== signals ====
signal enemy_died

var AttackScene : PackedScene = preload("res://scenes/Attack.tscn") 

#==== gravity ====
var gravity_value : float = C.GRAVITY_VALUE
var gravity_vector : Vector2 = C.GRAVITY_VECTOR setget set_gravity_vector
var mass : float = 0
#==== movement ====
var linear_velocity : Vector2 = Vector2()
var forward_vector : Vector2 = Vector2()
var movement_speed : float = 0
var snap_vector : Vector2 = C.SNAP_VECTOR
var floor_vector : Vector2 = C.FLOOR_VECTOR
var facing : int = C.FACING.RIGHT setget set_facing
#==== life ====
var passive : bool = false
var target : Node2D setget set_target
#==== attack ====
var attack_source : CTAttack_old
var attack : ResAttack_old
#==== utils ====
var save_margin : float = 1.1 + get("collision/safe_margin")


#==== node function ====
func _ready() -> void:
	print(">>> ", name)
	set_facing(facing)

func _physics_process(delta: float) -> void:
	process_gravity(delta)
	process_movement(delta)
	#	finally move
	linear_velocity = move_and_slide_with_snap(linear_velocity, snap_vector, floor_vector)
	#	pixel perfect snap correction
	position = position.round()



#==== custom processors ====
func process_gravity(delta : float) -> void:
	linear_velocity += gravity_vector * gravity_value * mass * delta

func process_movement(delta : float) -> void:
	pass


#==== custom functions ====
func flip_facing() -> void:
	set_facing(facing * -1)

func do_attack() -> void:
	if not attack_source:
		return
	$Anims.play("attack")

func fire_attack() -> void:
	var attack_instance : Attack_old = I.attack_source2instance(attack_source, AttackScene)
	if not attack_instance:
		return
	attack_instance.fire()
	get_node("/root").add_child(attack_instance)
#	var atk : Attack = I.attack_source2instance()
	pass

#==== setters ====
func set_target(target_node2d : Node2D = null) -> void:
	target = target_node2d

func set_facing(new_facing : int = C.FACING.RIGHT) -> void:
	facing = new_facing
	$EnemySprite.flip_h = facing == C.FACING.LEFT
	$View.position.x = abs($View.position.x) * facing
	$AttackRange.position.x = abs($AttackRange.position.x) * facing
	forward_vector = U.gravity_vector2forward_vector(gravity_vector, facing)

func set_gravity_vector(new_gravity_vector : Vector2 = C.GRAVITY_VECTOR) -> void:
	gravity_vector = new_gravity_vector.normalized()
	snap_vector = gravity_vector * C.SNAP_VECTOR.length()
	floor_vector = -gravity_vector
	forward_vector = U.gravity_vector2forward_vector(gravity_vector, facing)


#==== signals ====
func _on_View_body_entered(body: PhysicsBody2D) -> void:
	if body and body.is_in_group("enemy_target") and not passive:
		call_deferred("set_target", body as Node2D)

func _on_AttackRange_body_entered(body: PhysicsBody2D) -> void:
	if body and body.is_in_group("enemy_target") and not passive:
		print("do attack")