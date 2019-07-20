tool
extends Node2D
class_name MovingPlatformPreview_Tool

#==== parent ====
var parent : MovingPlatform
#==== pathway variables ====
var pathway : Pathway
var path_points : Array
var target : PathwayPoint
var start : PathwayPoint


#==== node functions ====
func _enter_tree() -> void:
	_setup()

func _ready() -> void:
	_setup()

func _physics_process(delta: float) -> void:
	if not parent:
		return
	
	get_node("Outline").shape.extents.x = parent.tile_width * C.HALF_TILE_SIZE
	get_node("Ghost/DrawShape2D").shape.extents.x = parent.tile_width * C.HALF_TILE_SIZE
	
	if not _update_pathway():
		return
	if get_node("Ghost").visible:
		_process_ghost_movement(delta)

#==== custom functions ====
func _update_pathway() -> bool:
	# update pathway
	var parent_pathway : Pathway = parent.get_node(parent.pathway_node_path)
	if parent_pathway is Pathway:
		if pathway != parent_pathway:
			pathway = parent_pathway
	else:
		pathway = null
		get_node("Ghost").global_position = position
		return false
	
	# update start point
	var parent_start : PathwayPoint
	if parent.start_point_node_path:
		parent_start = parent.get_node(parent.start_point_node_path)
	else:
		parent_start = U.get_next_pathway_point(pathway, null)
	
	if not parent_start:
		return false
	
	if start != parent_start:
		start = parent_start
		get_node("Ghost").global_position = start.global_position
		target = U.get_next_pathway_point(pathway, start)
	
	
	return true

func _process_ghost_movement(delta: float) -> void:
	var ghost := get_node("Ghost")
	
	var direction : Vector2 = (target.global_position - ghost.global_position).normalized()
	var motion : Vector2 = direction * parent.movement_speed * delta
	var motion_legth := motion.length()
	
	if motion_legth == 0.0:
		return
	elif motion_legth > ghost.global_position.distance_to(target.global_position):
		set_physics_process(false)
		ghost.global_position = target.global_position
		
		var wait_time : float
		if target.wait_time == -1:
			wait_time = pathway.point_wait_time
		else:
			wait_time = target.wait_time
		get_node("Ghost/Timer").wait_time = wait_time 
		
		target = U.get_next_pathway_point(pathway, target)
		
		get_node("Ghost/Timer").start()
	else:
		ghost.global_position += motion
	pass

#==== setup ====
func _setup() -> void:
	set_physics_process(false)
	set_process(false)
	
	if not U.in_editor():
		visible = false
		queue_free()
	else:
		var parent = get_parent()
		if not parent or not (parent is MovingPlatform):
			print("> preview: ", name, " parent: ", parent)
			return
		else:
			self.parent = parent as MovingPlatform
			set_physics_process(true)
			set_process(true)



#==== signals ====
func _on_GhostTimer_timeout() -> void:
	set_physics_process(true)
	pass # Replace with function body.
