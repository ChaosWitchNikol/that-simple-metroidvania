tool
extends Node2D
class_name TPlatformPath

export(float, 0.01, 1000, 0.01) var point_wait_time : float = 0.01  


#==== node functions ====
func _ready() -> void:
	if not Engine.editor_hint:
		set_process(false)
	set_process(false)

func _process(delta: float) -> void:
	pass
	update()

func _draw() -> void:
	if not Engine.editor_hint or get_path_points().size() == 0:
		return
	var point_nodes : Array = get_path_points()
	var zero_point : TPlatformPathPoint = point_nodes[0]
	
	var points : PoolVector2Array = PoolVector2Array()
	var triangles : Array = []
	var last_point : Vector2 = zero_point.global_position
	for point in point_nodes:
		points.append(point.position)
		if points.size() > 1:
			var center : Vector2 = (point.position + last_point) / 2
			var angle : float = last_point.angle_to_point(point.position)
			triangles.append({"center":center, "angle":angle})
		last_point = point.position
	points.append(zero_point.position)
	triangles.append({
		"center": (zero_point.position + last_point) / 2,
		"angle": last_point.angle_to_point(zero_point.position )
	})
	
	draw_polyline(points, Color("#FFFFFF"), 2.0, true)
	for triangle in triangles:
		draw_triangle(triangle["center"], triangle["angle"], 6.0)


#==== custom drawing functions ====
func draw_triangle(center : Vector2, angle: float, radius : float) -> void:
	var points : PoolVector2Array = PoolVector2Array()
	var colors : PoolColorArray = PoolColorArray([Color("#FFFFFF")])
	
	for i in range(3):
		var angle_point : float = angle + i * 2.0 * PI / 3.0 + PI
		var offset : Vector2 = Vector2(radius * cos(angle_point), radius * sin(angle_point))
		var point : Vector2 = center + offset
		points.append(point)
	
	draw_polygon(points, colors)


#==== getters ====
func get_path_points() -> Array:
	var points : Array = []
	for point in get_children():
		if point is TPlatformPathPoint:
			points.append(point)
	return points

func get_point_wait_time(point_index : int = -1) -> float:
	var points : Array = get_path_points()
	if point_index < 0 or point_index > points.size():
		return point_wait_time
	var wait_time = points[point_index].wait_time
	if wait_time < 0.01:
		wait_time = point_wait_time
	return wait_time
