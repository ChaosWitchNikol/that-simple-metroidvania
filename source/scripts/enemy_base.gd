extends KinematicBody2D
class_name EnemyBase

export(Resource) var src : Resource = null


export(float) var gravity : float = C.GRAVITY_VALUE
export(C.FACING) var facing : int = C.FACING.RIGHT

var linear_velocity : Vector2 = Vector2()
var gravity_vector := C.GRAVITY_VECTOR
var snap_vector := C.SNAP_VECTOR

func _ready() -> void:
	pass # Replace with function body.
	

func _physics_process(delta: float) -> void:
	process_gravity(delta, not is_on_floor())
	pass
	
	#	finally move
	linear_velocity = move_and_slide_with_snap(linear_velocity, snap_vector, C.FLOOR_VECTOR)
	

func process_gravity(delta : float, do_process : bool = true) -> void:
	if not do_process:
		return
	
	linear_velocity += gravity_vector * gravity * src.mass * delta
	

