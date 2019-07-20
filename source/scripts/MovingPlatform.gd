extends Node2D
class_name MovingPlatform

#==== onready ====
onready var pathway : Pathway = get_node(pathway_node_path)
onready var start_point : PathwayPoint = get_node(start_point_node_path)

onready var point_wait_timer : Timer = get_node("PointWaitTimer")


#==== export variables ====
export(NodePath) var pathway_node_path : NodePath
export(NodePath) var start_point_node_path : NodePath

export(int, 2, 6, 1) var tile_width : int = 2
export(float, 0 , 1000) var movement_speed : float = 200


#==== motion variables ====
var target_point : PathwayPoint 


#==== node functions ====
func _ready() -> void:
	set_physics_process(false)
	visible = false

	if not pathway_node_path:
		return
	elif not start_point_node_path:
		start_point = pathway.get_next_path_point(null)
	
	# create tiles
	create_tiles()
	
	# TODO: make sure that it jumps to initial position
	# set intial position
	position = start_point.global_position
	visible = true
	target_point = pathway.get_next_path_point(start_point)
	
	set_physics_process(true)

func _physics_process(delta: float) -> void:
	var direction : Vector2 = (target_point.global_position - position).normalized()
	var motion : Vector2 = direction * movement_speed * delta
	
	var motion_length = motion.length()
	# if motion length is 0 movement does not have to be proccessed
	# can be 0 when target_point.global_position and position are same
	# or when movement_speed is 0
	if motion_length == 0.0:
		return
	elif motion_length > position.distance_to(target_point.global_position):
		select_next_point()
	else:
		position += motion


#==== custom functions ====
func select_next_point() -> void:
	set_physics_process(false)
	position = target_point.global_position
	point_wait_timer.wait_time = target_point.wait_time
	target_point = pathway.get_next_path_point(target_point)
	point_wait_timer.start()

func create_tiles() -> void:
	get_node("Tiles").clear()
	get_node("Tiles").position.x = -tile_width * C.HALF_TILE_SIZE
	
	# set left most tile
	get_node("Tiles").set_cell(0, 0, 0)
	#set right most tile
	get_node("Tiles").set_cell(tile_width - 1, 0, 1)
	# set middle tiles
	if tile_width > 2:
		for i in range(1, tile_width - 1):
			get_node("Tiles").set_cell(i, 0, 2)
		

#==== signals ====
func _on_PointWaitTimer_timeout() -> void:
	set_physics_process(true)
