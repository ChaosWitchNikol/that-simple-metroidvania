tool
extends Node2D
class_name Pathway


#==== wait times ====
export(float, 0.01, 2048, 0.01) var point_wait_tile : float = 0.01
export(float, 0.01, 2048, 0.01) var start_wait_time : float = 0.01 setget _set_start_wait_time
#==== points ====
var _path_points : Array


#=== node functions ====
func _ready() -> void:
	if U.in_editor():
		return
	visible = false
	set_process(false)
	# when in game the path points will not change
	_set_path_points(get_path_points())

func _process(delta: float) -> void:
	update()

func _draw() -> void:
	_in_editor_draw()


#==== getters ====
func get_path_points() -> Array:
	if _path_points and _path_points.size() > 0:
		return _path_points
	
	var path_points : Array = []
	
	for child in get_children():
		if child is Point:
			path_points.append(child)
	
	return path_points

func get_next_path_point(path_point ) :
	var path_points : Array = get_path_points()
	var index : int = path_points.find(path_point)
	# if the path point was not found, return first one
	if index == -1:
		return path_points[0]
	# make sure that 
	return path_points[(index + 1) % path_points.size()]


#==== setters ====
func _set_path_points(points : Array) -> void:
	_path_points = points

func _set_start_wait_time(value : float) -> void:
	start_wait_time = value
	$StartPoint.wait_time = value


#==== editor drawing ====
func _in_editor_draw() -> void:
	draw_circle(Vector2(), 7, Color("#FFFFFF"))
	
	var point_nodes : Array = get_path_points()
	var zero_point : Point = point_nodes[0]
	
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
		_draw_triangle(triangle["center"], triangle["angle"], 8.0)
	pass


func _draw_triangle(center : Vector2, angle : float, radius : float) -> void:
	var points : PoolVector2Array = PoolVector2Array()
	var colors : PoolColorArray = PoolColorArray([Color("#FFFFFF")])
	
	for i in range(3):
		var angle_point : float = angle + i * 2.0 * PI / 3.0 + PI
		var offset : Vector2 = Vector2(cos(angle_point), sin(angle_point)) * radius
		var point : Vector2 = center + offset
		points.append(point)
	
	draw_polygon(points, colors)