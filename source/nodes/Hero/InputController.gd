extends UniqueHandlerNode

func _process(delta: float) -> void:
	if not is_current:
		return
	#	change sprite facing whenever linear velocity is different than zero
#	if P.linear_velocity.x != 0:
#		P.get_node("Sprite").flip_h = P.linear_velocity.x < 0
	
	#	decrease delay between jumps
	if P.jump_timeout > 0:
		P.jump_timeout -= delta

func _physics_process(delta: float) -> void:
	if not is_current:
		return
	
	if P.is_on_floor():
		#	reset jumps and do not process gravity
		P.linear_velocity.y = 0
		P.jumps_count = 0
	else:
		#	will be processed only when hero is not on ground
		#	process gravity
		P.linear_velocity.y += P.gravity * P.mass * delta
		#	check if hero collides with wall when falling
		#	and if wall climbing is allowed
		if P.is_on_wall() and P.allow_wall_climbing:
			P.jumps_count = 0
			#	slows down falling when sticking to wall
			if P.linear_velocity.y > 0:
				P.linear_velocity.y *= 0.75
	
	#	reset snap vector
	var snap_vector := C.SNAP_VECTOR
	
	if Input.is_action_just_pressed("ui_select"):
		if P.jump_timeout <= 0 and P.jumps_count < P.allowed_jumps:
			P.linear_velocity.y = -P.jump_force * C.TILE_SIZEF
			P.jumps_count += 1
			P.jump_timeout = P.jump_delay
			snap_vector = C.JUMP_SNAP_VECTOR
			
	#	reset linear velocity before setting its value
	#	if not reset hero will keep moving
	P.linear_velocity.x = 0
	if Input.is_action_pressed("ui_left"):
		P.linear_velocity.x = -P.movement_speed * delta * C.TILE_SIZEF
	if Input.is_action_pressed("ui_right"):
		P.linear_velocity.x = P.movement_speed * delta * C.TILE_SIZEF
	
	#	when on ceiling imeddiatelly apply gravity
	if P.is_on_ceiling():
		P.linear_velocity.y += P.gravity
	
	#	finally move
	P.linear_velocity = P.move_and_slide_with_snap(P.linear_velocity, snap_vector, C.FLOOR_VECTOR)



func _unhandled_key_input(event: InputEventKey) -> void:
	if event.is_action_pressed("ui_left"):
		P.set_facing(C.FACING.LEFT)
	
	if event.is_action_pressed("ui_right"):
		P.set_facing(C.FACING.RIGHT)
	
	if event.is_action_pressed("ui_select"):
		P.fire()