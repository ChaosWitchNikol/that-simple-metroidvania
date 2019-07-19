extends Node2D
class_name Pathway

#==== export variables ====
export(float, 0.01, 2048, 0.01) var point_wait_time : float = 0.01

#==== variables ====
var path_points : Array = [] setget ,get_path_points

#==== node functions ====
func _ready() -> void:
	path_points = get_path_points()
	
	# set wait time on points that have not wait time set
	for point in path_points:
		if point.wait_time <= 0:
			point.wait_time = point_wait_time
	

#==== custom functions ====


#==== getters ====
func get_path_points() -> Array:
	# if there are path_points return them
	if path_points and path_points.size() > 0:
		return path_points
	# make sure that path_points are clear and set to empty array
	path_points = []
	# filter only PathwayPoint children
	for child in get_children():
		if child is PathwayPoint:
			path_points.append(child)
	
	return path_points

func get_next_path_point(path_point : PathwayPoint ) -> PathwayPoint:
	var index : int = self.path_points.find(path_point)
	# if the path point was not found, return first one
	if index == -1:
		return path_points[0]
	# make sure that 
	return self.path_points[(index + 1) % path_points.size()]

