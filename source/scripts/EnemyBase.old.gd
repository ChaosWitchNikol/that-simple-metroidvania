extends KinematicBody2D
class_name EnemyBaseOld

export(Resource) var src : Resource = null


export(float) var gravity : float = C.GRAVITY_VALUE
export(C.FACING) var facing : int = C.FACING.RIGHT


var linear_velocity : Vector2 = Vector2()
var gravity_vector := C.GRAVITY_VECTOR
var snap_vector := C.SNAP_VECTOR
var floor_vector := C.FLOOR_VECTOR

var save_margin : float = 1.1 + get("collision/safe_margin")


var forward_vector : Vector2 = Vector2()
var target : Node2D


func _ready() -> void:
	print(">>> ", name)
	if src == null:
		print("Source is missing")
		queue_free()
		return
	
	set_facing(facing)
	



func _physics_process(delta: float) -> void:
	process_gravity(delta, not is_on_floor())
	process_movement(delta)
	#	finally move
	linear_velocity = move_and_slide_with_snap(linear_velocity, snap_vector, floor_vector)
	#	pixel perfect snap correction
	position = position.round()
	
func process_gravity(delta : float, do_process : bool = true) -> void:
	if not do_process:
		linear_velocity = Vector2()
		return
	
	linear_velocity += gravity_vector * gravity * src.mass * delta
	
func process_movement(delta : float) -> void:
	pass


func flip_facing() -> void:
	set_facing(facing * -1)


func set_target(target_node2d : Node2D = null) -> void:
	target = target_node2d

func set_facing(new_facing : int = C.FACING.RIGHT) -> void:
	facing = new_facing
	$Sprite.flip_h = facing == C.FACING.LEFT
	$View.position.x = abs($View.position.x) * facing
	forward_vector = Vector2(facing, 0)

func _on_View_body_entered(body: PhysicsBody2D) -> void:
	if body.is_in_group("enemy_target") and not src.passive:
		call_deferred("set_target", body as Node2D)
		print(body.name)