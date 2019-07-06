extends EnemyBase

enum ROTATION { INNER = -1, OUTER = 1, NONE = 0 }

var SAVE_MARGIN : float = 1.1 + get("collision/safe_margin")

var forward_vector : Vector2
var next_rotaion : int = ROTATION.NONE
var should_flip : bool = false

func _ready() -> void:
	get_next_vectors()
	print(transform)
	print(transform.translated(gravity_vector * C.TILE_SIZEF))
	print(position)
	print(test_move(transform.translated(gravity_vector), forward_vector))

##	Override
func process_movement(delta : float) -> void:
	if is_on_floor():
		#	rotate inner circle
		if test_move(transform, forward_vector ):
			position += gravity_vector
			linear_velocity = Vector2()
			get_next_vectors(ROTATION.INNER)
			return
		#	outer wiche ckeck if rotation on the outer circle is possible
		elif not test_move(transform.translated(forward_vector * SAVE_MARGIN), gravity_vector ):
			linear_velocity = Vector2()
			position +=  (forward_vector  + gravity_vector) 
			get_next_vectors(ROTATION.OUTER)
			return
		else:
			print("I am error")
		
		linear_velocity = forward_vector * src.movement_speed * delta * C.TILE_SIZEF


func get_next_vectors(rotation_type : int = ROTATION.NONE) -> void:
	var next_gravity_vector := gravity_vector.rotated((PI / 2) * facing * rotation_type).round()
	forward_vector = U.no_negative_zero_vector2(next_gravity_vector.rotated(-(PI / 2) * facing).round())
	gravity_vector = U.no_negative_zero_vector2(next_gravity_vector)
	
	snap_vector = gravity_vector * C.SNAP_VECTOR.length()
	floor_vector = -gravity_vector
	
	$Sprite.rotation_degrees = round(rad2deg(forward_vector.angle())  * facing)

