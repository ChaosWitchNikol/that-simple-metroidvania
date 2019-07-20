tool
extends Node2D
class_name PathwayPreview_Tool

var parent : Pathway

var hide_path : bool = false
#==== node functions ====
func _ready() -> void:
	if not U.in_editor():
		visible = false
		set_process(false)
		queue_free()
	else:
		var parent = get_parent()
		if not parent or not (parent is Pathway):
			set_process(false)
			print("> preview: ", name, " parent: ", parent)
			return
		else:
			self.parent = parent
			var tree : SceneTree = get_tree()
			if tree:
				pass
			set_process(true)

func _process(delta: float) -> void:
	update()

func _draw() -> void:
	if not U.in_editor() or get_path_points().size() == 0 or hide_path:
		return
	
	var point_nodes : Array = get_path_points()
	var zero_point : PathwayPoint = point_nodes[0]
	
	var points : PoolVector2Array = PoolVector2Array()
	var triangles : Array = []
	var last_point : Vector2 = zero_point.global_position
	for point in point_nodes:
		points.append(point.position)
		if points.size() > 1:
			var center : Vector2 = (point.position + last_point) / 2
			var angle : float = last_point.angle_to_point(point.position)
			triangles.append({"center": center, "angle": angle})
		last_point = point.position
	points.append(zero_point.position)
	triangles.append({
		"center": (zero_point.position + last_point) / 2,
		"angle": last_point.angle_to_point(zero_point.position)
	})
	
	draw_polyline(points, Color("#FFFFFF"), 4.0, true)
	for triangle in triangles:
		draw_triangle(triangle["center"], triangle["angle"], 7.0)


#==== custom drawing functions
func draw_triangle(center : Vector2, angle : float, radius : float) -> void:
	var points : PoolVector2Array = PoolVector2Array()
	var colors : PoolColorArray = PoolColorArray([Color("#FFFFFF")])
	
	for i in range(3):
		var angle_point : float = angle + i * 2.0 * PI / 3.0 + PI
		var offset : Vector2 = Vector2(cos(angle_point), sin(angle_point)) * radius
		var point : Vector2 = center + offset
		points.append(point)
	
	draw_polygon(points, colors)


#==== getters ====
func get_path_points() -> Array:
	if not parent:
		return []
	
	var points : Array = []
	
	for child in parent.get_children():
		if child is PathwayPoint:
			points.append(child)
		
	return points