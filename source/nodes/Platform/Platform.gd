tool
extends Node2D
class_name Platform


#==== pathway ====
export(NodePath) var pathway_node_path : NodePath 
export(NodePath) var start_node_path : NodePath 
var pathway : Pathway
var start : Point
#==== platform ====
export(float, 0, 1024) var movement_speed : float = 200
export(int, 2, 6, 1) var tile_width : int = 2 setget _set_tile_width
var target : Point

#==== node functions ====
func _enter_tree() -> void:
	if U.in_editor():
		_setup()

func _ready() -> void:
	_setup()

func _physics_process(delta: float) -> void:
	if not target:
		return
	var direction : Vector2 = (target.global_position - position).normalized()
	var motion : Vector2 = direction * movement_speed * delta
	var motion_length : float = motion.length()
	# if motion length is 0 movement does not have to be proccessed
	# can be 0 when target_point.global_position and position are same
	# or when movement_speed is 0
	if motion_length == 0.0:
		return
	elif motion_length > position.distance_to(target.global_position):
		select_next_point()
	else:
		position += motion


#==== custom functions ====
func create_tiles() -> void:
	$Tiles.clear()
	$Tiles.position.x = -tile_width * C.HALF_TILE_SIZE
	# set left most tile
	$Tiles.set_cell(0, 0, 0)
	# set right most tile
	$Tiles.set_cell(tile_width - 1, 0, 2)
	# set middle tiles
	if tile_width > 2:
		for i in range(1, tile_width -1):
			$Tiles.set_cell(i, 0, 1)

func select_next_point() -> void:
	set_physics_process(false)
	position = target.global_position
	var wait_time : float = target.wait_time
	if wait_time < 0.01:
		wait_time = pathway.point_wait_tile
	$PointWait.wait_time = wait_time
	target = pathway.get_next_path_point(target)
	$PointWait.start()

func find_pathway() -> void:
	if not pathway:
		if pathway_node_path:
			pathway = get_node(pathway_node_path)
	if not start:
		if start_node_path:
			start = get_node(start_node_path)

func _setup() -> void:
	find_pathway()
	if pathway:
		if not start:
			start = pathway.get_next_path_point(null)
		target = pathway.get_next_path_point(start)
		position = start.global_position
	else:
		set_physics_process(false)
	create_tiles()

#==== setters ====
func _set_tile_width(value : int) -> void:
	tile_width = value
	create_tiles()


#==== signals ====
func _on_PointWait_timeout() -> void:
	set_physics_process(true)
