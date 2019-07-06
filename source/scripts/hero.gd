extends KinematicBody2D

export(float, 0, 39.2) var gravity : float = C.GRAVITY_VALUE
export(float, 0, 400) var mass : float = 100
export(float, 0, 1000) var movement_speed : float = 500
export(float, 0, 2000) var jump_force : float = 15
export(int, 0, 10) var allowed_jumps : int = 1
export(float, 0, 1) var jump_delay : float = 0.1
export(bool) var allow_wall_climbing : bool = false


var linear_velocity := Vector2()
var jumps_count : int = 0
var jump_timeout : float = 0



func _process(delta: float) -> void:
	print(position)
	#	change sprite facing whenever linear velocity is different than zero
	if linear_velocity.x != 0:
		$Sprite.flip_h = linear_velocity.x < 0
	
	#	decrease delay between jumps
	if jump_timeout > 0:
		jump_timeout -= delta

func _physics_process(delta: float) -> void:
	if is_on_floor():
		#	reset jumps and do not process gravity
		linear_velocity.y = 0
		jumps_count = 0
	else:
		#	will be processed only when hero is not on ground
		#	process gravity
		linear_velocity.y += gravity * mass * delta
		#	check if hero collides with wall when falling
		#	and if wall climbing is allowed
		if is_on_wall() and allow_wall_climbing:
			jumps_count = 0
			#	slows down falling when sticking to wall
			if linear_velocity.y > 0:
				linear_velocity.y *= 0.75
	
	#	reset snap vector
	var snap_vector := C.SNAP_VECTOR
	
	if Input.is_action_just_pressed("ui_select"):
		if jump_timeout <= 0 and jumps_count < allowed_jumps:
			linear_velocity.y = -jump_force * C.TILE_SIZEF
			jumps_count += 1
			jump_timeout = jump_delay
			snap_vector = C.JUMP_SNAP_VECTOR
			
	#	reset linear velocity before setting its value
	#	if not reset hero will keep moving
	linear_velocity.x = 0
	if Input.is_action_pressed("ui_left"):
		linear_velocity.x = -movement_speed * delta * C.TILE_SIZEF
	if Input.is_action_pressed("ui_right"):
		linear_velocity.x = movement_speed * delta * C.TILE_SIZEF
	
	#	when on ceiling imeddiatelly apply gravity
	if is_on_ceiling():
		linear_velocity.y += gravity
	
	#	finally move
	linear_velocity = move_and_slide_with_snap(linear_velocity, snap_vector, C.FLOOR_VECTOR)